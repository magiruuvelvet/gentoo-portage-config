#include <stdio.h>

/* current output (2021-02-05, LLVM 11.0.1)
 *
 * __GLIBC__
 * __STRICT_ANSI__
 * __clang__
 *
 */

static inline void print_macro(const char *macro)
{
    printf("%s\n", macro);
}

int main(void)
{
#ifndef __cplusplus
#warning C
    // if this doesn't compile I fucked up when updating my toolchain to a newer version
    const char *asm = "this is not a ISO C keyword, but a GNU language extension";
#else
#warning C++
    printf("%ld\n", __cplusplus);
#endif

// my current libc runtime: declared
#ifdef __GLIBC__
    print_macro("__GLIBC__");
#endif

// my toolchain: not declared
#ifdef __GNUG__
    print_macro("__GNUG__");
#endif

#ifdef __GNUC__
    print_macro("__GNUC__");
#endif

#ifdef __STRICT_ANSI__
    print_macro("__STRICT_ANSI__");
#endif

// my toolchain: declared
#ifdef __clang__
    print_macro("__clang__");
#endif

// my toolchain: not declared
#ifdef _GNU_SOURCE
    print_macro("_GNU_SOURCE");
#endif

#ifdef __ATOMIC_ACQ_REL
    print_macro("__ATOMIC_ACQ_REL");
#endif

    return 0;
}
