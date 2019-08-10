#include <cstdio>

// test to check if the compiler works and can produce working
// executables without crashing inside the CRT

// test 1 -> build with: clang -v test.cpp -lunwind -lc++abi
// test 2 -> build with: clang++ -v test.cpp

// multilib
// clang -v -m32 test.cpp -lunwind -lc++abi
// clang++ -v -m32 test.cpp

class A
{
public:
    A() {}
    ~A() {}

    void hello(char *a)
    {
        std::printf("test: %s\n", a);
    }
};

namespace Test
{
    void test(int a)
    {
        std::printf("test: %i\n", a);
    }
}

int main(int argc, char **argv)
{
    Test::test(argc); // check if argc has the correct size
    A a; // requires libc++abi when building with C++ exceptions enabled
    a.hello(argv[0]); // check if argv is not a nullptr or points to an invalid address
    auto res = 9 % 2; // 1, test to check if compiler-rt works
    std::printf("%i\n", res);
    return 0;
}
