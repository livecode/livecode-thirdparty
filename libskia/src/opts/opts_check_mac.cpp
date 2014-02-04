#ifdef __ppc__

#include "SkBitmapProcState_opts_none.cpp"
#include "SkBlitMask_opts_none.cpp"
#include "SkBlitRow_opts_none.cpp"
#include "SkBlurImage_opts_none.cpp"
#include "SkMorphology_opts_none.cpp"
#include "SkUtils_opts_none.cpp"
#include "SkXfermode_opts_none.cpp"

#else

#include "opts_check_SSE2.cpp"
#include "SkBitmapFilter_opts_SSE2.cpp"
#include "SkBitmapProcState_opts_SSE2.cpp"
#include "SkBlitRect_opts_SSE2.cpp"
#include "SkBlitRow_opts_SSE2.cpp"
#include "SkBlurImage_opts_SSE2.cpp"
//#include "SkMorphology_opts_SSE2.cpp"
#include "SkUtils_opts_SSE2.cpp"
#include "SkXfermode_opts_none.cpp"

#endif