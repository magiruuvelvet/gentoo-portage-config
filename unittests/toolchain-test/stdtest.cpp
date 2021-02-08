#include <cstdio>
#include <memory>

// test for various features

int main()
{
    std::printf("%ld\n", __cplusplus);

    std::unique_ptr<int> a;
    std::shared_ptr<int> b;
    std::auto_ptr<int> c; // compile error C++17 onward
}
