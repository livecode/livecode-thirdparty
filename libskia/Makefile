NAME=libskia
TYPE=archive

################################################################################

SRC_CORE=Sk64.cpp SkAAClip.cpp \
	SkAdvancedTypefaceMetrics.cpp \
	SkAlphaRuns.cpp SkBBoxHierarchy.cpp \
	SkBBoxHierarchyRecord.cpp SkBBoxRecord.cpp SkBitmap.cpp \
	SkBitmapHeap.cpp SkBitmapProcShader.cpp SkBitmapProcState.cpp \
	SkBitmapProcState_matrixProcs.cpp SkBlitMask_D32.cpp SkBlitRow_D16.cpp \
	SkBlitRow_D32.cpp SkBlitRow_D4444.cpp SkBlitter.cpp SkBlitter_4444.cpp \
	SkBlitter_A1.cpp SkBlitter_A8.cpp SkBlitter_ARGB32.cpp \
	SkBlitter_RGB16.cpp SkBlitter_Sprite.cpp SkBuffer.cpp SkCanvas.cpp \
	SkChunkAlloc.cpp SkClipStack.cpp SkColor.cpp SkColorFilter.cpp \
	SkColorTable.cpp SkComposeShader.cpp SkConfig8888.cpp SkCordic.cpp \
	SkData.cpp SkDebug.cpp SkDeque.cpp SkDevice.cpp SkDither.cpp \
	SkDraw.cpp SkEdge.cpp SkEdgeBuilder.cpp SkEdgeClipper.cpp \
	SkFlattenable.cpp SkFlattenableBuffers.cpp SkFontHost.cpp \
	SkGeometry.cpp SkGlyphCache.cpp SkImageFilter.cpp SkInstCnt.cpp \
	SkLineClipper.cpp SkMallocPixelRef.cpp SkMask.cpp SkMaskFilter.cpp \
	SkMaskGamma.cpp SkMath.cpp SkMatrix.cpp SkMetaData.cpp \
	SkMMapStream.cpp \
	SkOrderedReadBuffer.cpp SkOrderedWriteBuffer.cpp SkPackBits.cpp \
	SkPaint.cpp SkPath.cpp SkPathEffect.cpp SkPathHeap.cpp \
	SkPathMeasure.cpp SkPicture.cpp SkPictureFlat.cpp \
	SkPicturePlayback.cpp SkPictureRecord.cpp SkPictureStateTree.cpp \
	SkPixelRef.cpp SkPoint.cpp SkPtrRecorder.cpp SkRasterClip.cpp \
	SkRasterizer.cpp SkRect.cpp SkRefCnt.cpp SkRegion.cpp \
	SkRegion_path.cpp SkRRect.cpp SkRTree.cpp SkScalar.cpp \
	SkScalerContext.cpp SkScan.cpp SkScan_Antihair.cpp SkScan_AntiPath.cpp \
	SkScan_Hairline.cpp SkScan_Path.cpp SkShader.cpp \
	SkSpriteBlitter_ARGB32.cpp SkSpriteBlitter_RGB16.cpp SkStream.cpp \
	SkString.cpp SkStroke.cpp SkStrokeRec.cpp SkStrokerPriv.cpp SkTLS.cpp \
	SkTSearch.cpp \
	SkTypeface.cpp SkTypefaceCache.cpp SkUnPreMultiply.cpp SkUtils.cpp \
	SkWriter32.cpp SkXfermode.cpp
	
SRC_IMAGE=SkImage.cpp SkSurface.cpp

SRC_EFFECTS_GRADIENTS=SkBitmapCache.cpp SkClampRange.cpp SkGradientShader.cpp \
	SkLinearGradient.cpp SkRadialGradient.cpp SkSweepGradient.cpp \
	SkTwoPointConicalGradient.cpp SkTwoPointRadialGradient.cpp
	
SRC_EFFECTS=SkDashPathEffect.cpp $(addprefix gradients/,$(SRC_EFFECTS_GRADIENTS))

SRC_UTILS=SkOSFile.cpp
	
SRC_OPTS=SkBitmapProcState_opts_none.cpp SkBlitRow_opts_none.cpp SkUtils_opts_none.cpp

SRC_PORTS=SkDebug_stdio.cpp SkFontDescriptor.cpp SkFontHost_linux.cpp SkFontHost_FreeType.cpp SkFontHost_FreeType_common.cpp SkFontHost_tables.cpp SkMemory_malloc.cpp SkOSFile_stdio.cpp SkThread_pthread.cpp


SOURCES=$(addprefix core/,$(SRC_CORE)) \
	$(addprefix effects/,$(SRC_EFFECTS)) \
	$(addprefix image/,$(SRC_IMAGE)) \
	$(addprefix opts/,$(SRC_OPTS)) \
	$(addprefix ports/,$(SRC_PORTS)) \
	$(addprefix utils/,$(SRC_UTILS))

ifeq ($(MODE),debug)
CUSTOM_DEFINES=SK_DEBUG
else
CUSTOM_DEFINES=
endif

CUSTOM_INCLUDES=./src \
		./src/core \
		./src/image \
		/usr/include/freetype2

CUSTOM_CCFLAGS=-fno-exceptions -fno-rtti


include ../../rules/archive.linux.makefile
