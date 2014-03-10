#ifndef sk_stdint_DEFINED
#define sk_stdint_DEFINED

typedef signed char int8_t;
typedef unsigned char   uint8_t;
typedef short  int16_t;
typedef unsigned short  uint16_t;
typedef int  int32_t;
typedef unsigned   uint32_t;
typedef long long  int64_t;
typedef unsigned long long   uint64_t;

typedef int64_t   intmax_t;
typedef uint64_t  uintmax_t;

#ifndef _UINTPTR_T
    #define _UINTPTR_T
    // MDW-2013-04-15: [[ x64 ]] make 64-bit safe
    #ifdef __LP64__
        typedef uint64_t uintptr_t;
    #else
        typedef uint32_t uintptr_t;
    #endif
#endif

#ifndef _INTPTR_T
    #define _INTPTR_T
    // MDW-2013-04-15: [[ x64 ]] make 64-bit safe
    #ifdef __LP64__
        typedef int64_t intptr_t;
    #else
        typedef int32_t intptr_t;
    #endif
#endif

#endif
