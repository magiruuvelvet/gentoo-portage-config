// merely checking for coroutine_handle presence in std::

// should compile in C++20 mode

// #if __has_include(<coroutine>)
// #if defined(__clang__) && !defined(__cpp_impl_coroutine)
// #define __cpp_impl_coroutine 123
// #endif
// #endif

#include <coroutine>

// #if defined(__clang__) && (__cpp_impl_coroutine == 123)
// namespace std::experimental
// {
//     using ::std::coroutine_traits;
//     using ::std::coroutine_handle;
// }
// #endif

#ifdef _LIBCPP_HAS_NO_CXX20_COROUTINES

std::coroutine_handle<> handle;
std::suspend_always suspend;

int _LIBCPP_HAS_NO_CXX20_COROUTINES = 1;
#else
int _LIBCPP_HAS_NO_CXX20_COROUTINES = 0;
#endif

int main()
{
    return _LIBCPP_HAS_NO_CXX20_COROUTINES;
}
