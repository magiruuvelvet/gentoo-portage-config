#include <stdlib.h>
#include <stdio.h>

// clang -v -target x86_64-pc-linux-musl --sysroot /usr/musl test.c
// clang -v -target x86_64-pc-linux-musl --sysroot /usr/musl -static test.c

/* OLD METHOD
// musl-clang -v test.c
// musl-ldd a.out
// working 64-bit executable, no segfaults before main()

// musl-clang -v -m32 test.c
// musl-ldd a.out
// working 32-bit executable, no segfaults before main()

// glibc ldd should throw this error: invalid ELF header
*/

int main(int argc, char **argv)
{
    printf("argc = %i, argv[0] = %s\n", argc, argv[0]);
    return 0;
}
