#include <iostream>
#include <cstdio>

// clang++ -v -target x86_64-pc-linux-musl --sysroot /usr/musl test.cpp
// clang++ -v -target x86_64-pc-linux-musl --sysroot /usr/musl -static test.cpp

/* OLD METHOD
// musl-clang++ -v test.cpp
// musl-ldd a.out
// working 64-bit executable, no segfaults before main()

// musl-clang++ -v -m32 test.cpp
// musl-ldd a.out
// working 32-bit executable, no segfaults before main()

// glibc ldd should throw this error: invalid ELF header
*/

int main(int argc, char **argv)
{
    std::printf("argc = %i, argv[0] = %s\n", argc, argv[0]);
    std::cout << argc << std::endl;
    return 0;
}
