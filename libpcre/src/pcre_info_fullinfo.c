/*************************************************
 *      Perl-Compatible Regular Expressions       *
 *************************************************/

/* PCRE is a library of functions to support regular expressions whose syntax
 and semantics are as close as possible to those of the Perl 5 language.
 
 Written by Philip Hazel
 Copyright (c) 1997-2012 University of Cambridge
 
 -----------------------------------------------------------------------------
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice,
 this list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 
 * Neither the name of the University of Cambridge nor the names of its
 contributors may be used to endorse or promote products derived from
 this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 -----------------------------------------------------------------------------
 */

//
//  pcre_info_fullinfo.c
//  libpcre
//
//  Created by Thierry Douez on 11/09/13.
//  Copyright (c) 2013 Sunny-Tdz. All rights reserved.
//
//  For backwards compatibility exposes the obsolete pcre_info()
//  which is a small wrapper on top of pcre_fullinfo()
//  This file should be erased later when updating the livecode project
//

// TDZ-2013-09-10: [[ Avoid using -DHAVE_CONFIG_H as flag compiler ]]
#define HAVE_CONFIG_H   1

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include "pcre_internal.h"


/*************************************************
 * (Obsolete) Return info about compiled pattern  *
 *************************************************/

/* This is the original "info" function. It picks potentially useful data out
 of the private structure, but its interface was too rigid. It remains for
 backwards compatibility. The public options are passed back in an int - though
 the re->options field has been expanded to a long int, all the public options
 at the low end of it, and so even on 16-bit systems this will still be OK.
 Therefore, I haven't changed the API for pcre_info().
 
 Arguments:
 argument_re   points to compiled code
 optptr        where to pass back the options
 first_byte    where to pass back the first character,
 or -1 if multiline and all branches start ^,
 or -2 otherwise
 
 Returns:        number of capturing subpatterns
 or negative values on error
 */


// TDZ-2013-09-11 [[ Wrapper pcre_info - pcre_fullinfo ]]
// PCRE_DATA_SCOPE int  pcre_info(const pcre *, int *, int *);

int
pcre_info(const pcre *argument_re, int *optptr, int *first_byte)
{
    int re_nsub;
    const real_pcre *re = (const real_pcre *)argument_re;
    if (re == NULL) return PCRE_ERROR_NULL;
    pcre_fullinfo((const pcre *)argument_re, NULL,
                    PCRE_INFO_CAPTURECOUNT, &re_nsub);
    return re_nsub;
}

/* End of pcre_info_fullinfo.c */

