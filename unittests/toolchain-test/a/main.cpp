// clang -nostdlib++ -O3 -fno-exceptions -fno-rtti main.cpp -Wl,--rpath=. init.so -o main

#include <stdio.h>

extern int get();

int main()
{
    return get();
}
