#include <iostream>
#include <cstdio>

// musl-clang++ -v test.cpp
// musl-ldd a.out
// working 64-bit executable, no segfaults before main()

// musl-clang++ -v -m32 test.cpp
// musl-ldd a.out
// working 32-bit executable, no segfaults before main()

// glibc ldd should throw this error: invalid ELF header

int main(int argc, char **argv)
{
    std::printf("argc = %i, argv[0] = %s\n", argc, argv[0]);
    std::cout << argc << std::endl;
    return 0;
}
