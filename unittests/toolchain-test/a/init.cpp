// clang -shared -fPIC -nostdlib++ -O3 -fno-exceptions -fno-rtti init.cpp -o init.so

#include <stdio.h>

int global{};

namespace
{
    constexpr int g = 1;
}

class test
{
public:
    test(int a) : a(a) {}
    int a;
};

int get()
{
    return global;
}

__attribute__((constructor))
static void _main()
{
    printf("constructor\n");
    global = test{g}.a;
}
