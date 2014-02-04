/*
 * Copyright 2011 The Android Open Source Project
 *
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

#include "SkFontConfigParser_android.h"
#include "SkTDArray.h"
#include "SkTypeface.h"

#include <expat.h>
#include <stdio.h>
#include <sys/system_properties.h>

#define SYSTEM_FONTS_FILE "/system/etc/system_fonts.xml"
#define FALLBACK_FONTS_FILE "/system/etc/fallback_fonts.xml"
#define VENDOR_FONTS_FILE "/vendor/etc/fallback_fonts.xml"

// These defines are used to determine the kind of tag that we're currently
// populating with data. We only care about the sibling tags nameset and fileset
// for now.
#define NO_TAG 0
#define NAMESET_TAG 1
#define FILESET_TAG 2

////////////////////////////////////////////////////////////////////////////////
// MM-2014-01-14: [[ RefactorGraphics ]] The following block of code is ported in (and slightly modified)
//  from older versions of the Android font host. It adds support for hard coded font names, required for
//  pre 4.0 Android devices.

// used to record our notion of the pre-existing fonts
struct FontInitRec {
    const char*         fFileName;
    const char* const*  fNames;     // null-terminated list
};

// deliberately empty, but we use the address to identify fallback fonts
static const char* gFBNames[] = { NULL };

// MM-2012-03-06: Added in synonyms for the Droid * fonts
static const char* gSansNames[] = {
    "Droid Sans", "sans-serif", "arial", "helvetica", "tahoma", "verdana", NULL
};

static const char* gSerifNames[] = {
    "Droid Serif", "serif", "times", "times new roman", "palatino", "georgia", "baskerville",
    "goudy", "fantasy", "cursive", "ITC Stone Serif", NULL
};

static const char* gMonoNames[] = {
    "Droid Sans Mono", "monospace", "courier", "courier new", "monaco", NULL
};

/*  Fonts must be grouped by family, with the first font in a family having the
 list of names (even if that list is empty), and the following members having
 null for the list. The names list must be NULL-terminated
 */
static const FontInitRec gLegacySystemFonts[] = {
	{ "DroidSans.ttf",              gSansNames  },
    { "DroidSans-Bold.ttf",         NULL        },
    { "DroidSerif-Regular.ttf",     gSerifNames },
    { "DroidSerif-Bold.ttf",        NULL        },
    { "DroidSerif-Italic.ttf",      NULL        },
    { "DroidSerif-BoldItalic.ttf",  NULL        },
    { "DroidSansMono.ttf",          gMonoNames  },
    
    /*  These are optional, and can be ignored if not found in the file system.
	 These are appended to gFallbackFonts[] as they are seen, so we list
	 them in the order we want them to be accessed by NextLogicalFont().
     */
    { "DroidSansArabic.ttf",        gFBNames    },
    { "DroidSansHebrew.ttf",        gFBNames    },
    { "DroidSansThai.ttf",          gFBNames    },
    { "DroidSansJapanese.ttf",      gFBNames    },
    { "DroidSansFallback.ttf",      gFBNames    }
};

// IM-2013-07-03: [[ RefactorGraphics ]] add hardcoded font families
static void getLegacyFontFamilies(SkTDArray<FontFamily*> &fontFamilies)
{
	FontFamily *currentFamily = NULL;
	for (size_t i = 0; i < SK_ARRAY_COUNT(gLegacySystemFonts); i++)
	{
		if (gLegacySystemFonts[i].fNames != NULL)
		{
			// if we're first in a new family, push currentFamily to fontFamily & create a new one.
			if (currentFamily != NULL)
				*fontFamilies.append() = currentFamily;
			
			currentFamily = new FontFamily();
			
			currentFamily->order = -1;
			
			// add family names to currentFamily
			for (size_t n = 0; gLegacySystemFonts[i].fNames[n] != NULL; n++)
				*(currentFamily->fNames.append()) = gLegacySystemFonts[i].fNames[n];
		}
		
        FontFileInfo *fileInfo;
        fileInfo = new FontFileInfo();
        fileInfo->fFileName = gLegacySystemFonts[i].fFileName;
        *(currentFamily->fFontFiles.append()) = fileInfo;
        
        if (gLegacySystemFonts[i].fNames == gFBNames)
            currentFamily->fIsFallbackFont = true;
        }
	
	if (currentFamily != NULL)
		*fontFamilies.append() = currentFamily;
}

////////////////////////////////////////////////////////////////////////////////

/**
 * The FamilyData structure is passed around by the parser so that each handler
 * can read these variables that are relevant to the current parsing.
 */
struct FamilyData {
    FamilyData(XML_Parser *parserRef, SkTDArray<FontFamily*> &familiesRef) :
        parser(parserRef),
        families(familiesRef),
        currentFamily(NULL),
        currentFontInfo(NULL),
        currentTag(NO_TAG) {};

    XML_Parser *parser;                // The expat parser doing the work
    SkTDArray<FontFamily*> &families;  // The array that each family is put into as it is parsed
    FontFamily *currentFamily;         // The current family being created
    FontFileInfo *currentFontInfo;     // The current fontInfo being created
    int currentTag;                    // A flag to indicate whether we're in nameset/fileset tags
};

/**
 * Handler for arbitrary text. This is used to parse the text inside each name
 * or file tag. The resulting strings are put into the fNames or FontFileInfo arrays.
 */
static void textHandler(void *data, const char *s, int len) {
    FamilyData *familyData = (FamilyData*) data;
    // Make sure we're in the right state to store this name information
    if (familyData->currentFamily &&
            (familyData->currentTag == NAMESET_TAG || familyData->currentTag == FILESET_TAG)) {
        // Malloc new buffer to store the string
        char *buff;
        buff = (char*) malloc((len + 1) * sizeof(char));
        strncpy(buff, s, len);
        buff[len] = '\0';
        switch (familyData->currentTag) {
        case NAMESET_TAG:
            *(familyData->currentFamily->fNames.append()) = buff;
            break;
        case FILESET_TAG:
            if (familyData->currentFontInfo) {
                familyData->currentFontInfo->fFileName = buff;
            }
            break;
        default:
            // Noop - don't care about any text that's not in the Fonts or Names list
            break;
        }
    }
}

/**
 * Handler for font files. This processes the attributes for language and
 * variants then lets textHandler handle the actual file name
 */
static void fontFileElementHandler(FamilyData *familyData, const char **attributes) {
    FontFileInfo* newFileInfo = new FontFileInfo();
    if (attributes) {
        int currentAttributeIndex = 0;
        while (attributes[currentAttributeIndex]) {
            const char* attributeName = attributes[currentAttributeIndex];
            const char* attributeValue = attributes[currentAttributeIndex+1];
            int nameLength = strlen(attributeName);
            int valueLength = strlen(attributeValue);
            if (strncmp(attributeName, "variant", nameLength) == 0) {
                if (strncmp(attributeValue, "elegant", valueLength) == 0) {
                    newFileInfo->fPaintOptions.setFontVariant(SkPaintOptionsAndroid::kElegant_Variant);
                } else if (strncmp(attributeValue, "compact", valueLength) == 0) {
                    newFileInfo->fPaintOptions.setFontVariant(SkPaintOptionsAndroid::kCompact_Variant);
                }
            } else if (strncmp(attributeName, "lang", nameLength) == 0) {
                newFileInfo->fPaintOptions.setLanguage(attributeValue);
            }
            //each element is a pair of attributeName/attributeValue string pairs
            currentAttributeIndex += 2;
        }
    }
    *(familyData->currentFamily->fFontFiles.append()) = newFileInfo;
    familyData->currentFontInfo = newFileInfo;
    XML_SetCharacterDataHandler(*familyData->parser, textHandler);
}

/**
 * Handler for the start of a tag. The only tags we expect are family, nameset,
 * fileset, name, and file.
 */
static void startElementHandler(void *data, const char *tag, const char **atts) {
    FamilyData *familyData = (FamilyData*) data;
    int len = strlen(tag);
    if (strncmp(tag, "family", len)== 0) {
        familyData->currentFamily = new FontFamily();
        familyData->currentFamily->order = -1;
        // The Family tag has an optional "order" attribute with an integer value >= 0
        // If this attribute does not exist, the default value is -1
        for (int i = 0; atts[i] != NULL; i += 2) {
            const char* valueString = atts[i+1];
            int value;
            int len = sscanf(valueString, "%d", &value);
            if (len > 0) {
                familyData->currentFamily->order = value;
            }
        }
    } else if (len == 7 && strncmp(tag, "nameset", len) == 0) {
        familyData->currentTag = NAMESET_TAG;
    } else if (len == 7 && strncmp(tag, "fileset", len) == 0) {
        familyData->currentTag = FILESET_TAG;
    } else if (strncmp(tag, "name", len) == 0 && familyData->currentTag == NAMESET_TAG) {
        // If it's a Name, parse the text inside
        XML_SetCharacterDataHandler(*familyData->parser, textHandler);
    } else if (strncmp(tag, "file", len) == 0 && familyData->currentTag == FILESET_TAG) {
        // If it's a file, parse the attributes, then parse the text inside
        fontFileElementHandler(familyData, atts);
    }
}

/**
 * Handler for the end of tags. We only care about family, nameset, fileset,
 * name, and file.
 */
static void endElementHandler(void *data, const char *tag) {
    FamilyData *familyData = (FamilyData*) data;
    int len = strlen(tag);
    if (strncmp(tag, "family", len)== 0) {
        // Done parsing a Family - store the created currentFamily in the families array
        *familyData->families.append() = familyData->currentFamily;
        familyData->currentFamily = NULL;
    } else if (len == 7 && strncmp(tag, "nameset", len) == 0) {
        familyData->currentTag = NO_TAG;
    } else if (len == 7 && strncmp(tag, "fileset", len) == 0) {
        familyData->currentTag = NO_TAG;
    } else if ((strncmp(tag, "name", len) == 0 && familyData->currentTag == NAMESET_TAG) ||
            (strncmp(tag, "file", len) == 0 && familyData->currentTag == FILESET_TAG)) {
        // Disable the arbitrary text handler installed to load Name data
        XML_SetCharacterDataHandler(*familyData->parser, NULL);
    }
}

/**
 * This function parses the given filename and stores the results in the given
 * families array.
 */
static void parseConfigFile(const char *filename, SkTDArray<FontFamily*> &families) {

    FILE* file = NULL;

#if !defined(SK_BUILD_FOR_ANDROID_FRAMEWORK)
    // if we are using a version of Android prior to Android 4.2 (JellyBean MR1
    // at API Level 17) then we need to look for files with a different suffix.
    char sdkVersion[PROP_VALUE_MAX];
    __system_property_get("ro.build.version.sdk", sdkVersion);
    const int sdkVersionInt = atoi(sdkVersion);

    if (0 != *sdkVersion && sdkVersionInt < 17) {
        SkString basename;
        SkString updatedFilename;
        SkString locale = SkFontConfigParser::GetLocale();

        basename.set(filename);
        // Remove the .xml suffix. We'll add it back in a moment.
        if (basename.endsWith(".xml")) {
            basename.resize(basename.size()-4);
        }
        // Try first with language and region
        updatedFilename.printf("%s-%s.xml", basename.c_str(), locale.c_str());
        file = fopen(updatedFilename.c_str(), "r");
        if (!file) {
            // If not found, try next with just language
            updatedFilename.printf("%s-%.2s.xml", basename.c_str(), locale.c_str());
            file = fopen(updatedFilename.c_str(), "r");
        }
    }
#endif

    if (NULL == file) {
        file = fopen(filename, "r");
    }

    // Some of the files we attempt to parse (in particular, /vendor/etc/fallback_fonts.xml)
    // are optional - failure here is okay because one of these optional files may not exist.
    if (NULL == file) {
        return;
    }

    XML_Parser parser = XML_ParserCreate(NULL);
    FamilyData *familyData = new FamilyData(&parser, families);
    XML_SetUserData(parser, familyData);
    XML_SetElementHandler(parser, startElementHandler, endElementHandler);

    char buffer[512];
    bool done = false;
    while (!done) {
        fgets(buffer, sizeof(buffer), file);
        int len = strlen(buffer);
        if (feof(file) != 0) {
            done = true;
        }
        XML_Parse(parser, buffer, len, done);
    }
    XML_ParserFree(parser);
    fclose(file);
}

static void getSystemFontFamilies(SkTDArray<FontFamily*> &fontFamilies) {
    parseConfigFile(SYSTEM_FONTS_FILE, fontFamilies);
}

static void getFallbackFontFamilies(SkTDArray<FontFamily*> &fallbackFonts) {
    SkTDArray<FontFamily*> vendorFonts;
    parseConfigFile(FALLBACK_FONTS_FILE, fallbackFonts);
    parseConfigFile(VENDOR_FONTS_FILE, vendorFonts);

    // This loop inserts the vendor fallback fonts in the correct order in the
    // overall fallbacks list.
    int currentOrder = -1;
    for (int i = 0; i < vendorFonts.count(); ++i) {
        FontFamily* family = vendorFonts[i];
        int order = family->order;
        if (order < 0) {
            if (currentOrder < 0) {
                // Default case - just add it to the end of the fallback list
                *fallbackFonts.append() = family;
            } else {
                // no order specified on this font, but we're incrementing the order
                // based on an earlier order insertion request
                *fallbackFonts.insert(currentOrder++) = family;
            }
        } else {
            // Add the font into the fallback list in the specified order. Set
            // currentOrder for correct placement of other fonts in the vendor list.
            *fallbackFonts.insert(order) = family;
            currentOrder = order + 1;
        }
    }
}

/**
 * Loads data on font families from various expected configuration files. The
 * resulting data is returned in the given fontFamilies array.
 */
void SkFontConfigParser::GetFontFamilies(SkTDArray<FontFamily*> &fontFamilies) {

    getSystemFontFamilies(fontFamilies);
    
    // IM-2013-07-03: [[ RefactorGraphics ]] fallback to legacy font families if none could be loaded
	if (fontFamilies.count() == 0)
		getLegacyFontFamilies(fontFamilies);

    // Append all the fallback fonts to system fonts
    SkTDArray<FontFamily*> fallbackFonts;
    getFallbackFontFamilies(fallbackFonts);
    for (int i = 0; i < fallbackFonts.count(); ++i) {
        fallbackFonts[i]->fIsFallbackFont = true;
        *fontFamilies.append() = fallbackFonts[i];
    }
}

void SkFontConfigParser::GetTestFontFamilies(SkTDArray<FontFamily*> &fontFamilies,
                                             const char* testMainConfigFile,
                                             const char* testFallbackConfigFile) {
    parseConfigFile(testMainConfigFile, fontFamilies);

    SkTDArray<FontFamily*> fallbackFonts;
    parseConfigFile(testFallbackConfigFile, fallbackFonts);

    // Append all fallback fonts to system fonts
    for (int i = 0; i < fallbackFonts.count(); ++i) {
        fallbackFonts[i]->fIsFallbackFont = true;
        *fontFamilies.append() = fallbackFonts[i];
    }
}

/**
 * Read the persistent locale.
 */
SkString SkFontConfigParser::GetLocale()
{
    char propLang[PROP_VALUE_MAX], propRegn[PROP_VALUE_MAX];
    __system_property_get("persist.sys.language", propLang);
    __system_property_get("persist.sys.country", propRegn);

    if (*propLang == 0 && *propRegn == 0) {
        /* Set to ro properties, default is en_US */
        __system_property_get("ro.product.locale.language", propLang);
        __system_property_get("ro.product.locale.region", propRegn);
        if (*propLang == 0 && *propRegn == 0) {
            strcpy(propLang, "en");
            strcpy(propRegn, "US");
        }
    }

    SkString locale(6);
    char* localeCStr = locale.writable_str();

    strncpy(localeCStr, propLang, 2);
    localeCStr[2] = '-';
    strncpy(&localeCStr[3], propRegn, 2);
    localeCStr[5] = '\0';

    return locale;
}
