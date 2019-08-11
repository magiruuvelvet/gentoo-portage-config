#include <stdlib.h>
#include <stdio.h>

// musl-clang -v test.c
// musl-ldd a.out
// working 64-bit executable, no segfaults before main()

// musl-clang -v -m32 test.c
// musl-ldd a.out
// working 32-bit executable, no segfaults before main()

// glibc ldd should throw this error: invalid ELF header

int main(int argc, char **argv)
{
    printf("argc = %i, argv[0] = %s\n", argc, argv[0]);
    return 0;
}
