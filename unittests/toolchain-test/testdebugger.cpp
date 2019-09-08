#include <cstdio>
#include <csignal>

// clang++ -v -glldb -gno-gnu-pubnames testdebugger.cpp
// clang++ -v testdebugger.cpp

// both should produce the same cc1 command line options with my patch applied

// lldb should print detailed outputs about the call stack
// including the filename, line number and column
// lldb can even tell when the code was optimized, but still
// points to the correct position in the file, which makes
// debugging outside a graphical debugger a pleasure :)

// the only downside is that binaries are almost double the size,
// because of this detailed debugger tuning

class A
{
public:
    A() {}
    ~A() {}

    void hello(char *a)
    {
        std::printf("test: %s\n", a);
        std::raise(SIGSEGV);
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
