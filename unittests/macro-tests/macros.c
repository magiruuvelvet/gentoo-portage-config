#include <stdio.h>

/* current output (2019-08-31, LLVM 9.0.0)
 *
 * __GLIBC__
 * __clang__
 *
 */

static inline void print_macro(const char *macro)
{
    printf("%s\n", macro);
}

int main(void)
{
    // if this doesn't compile I fucked up when updating my toolchain to a newer version
    const char *asm = "this is not a ISO C keyword, but a GNU language extension";

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

    return 0;
}
