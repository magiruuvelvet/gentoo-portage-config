#include <iostream>

template <typename T>
class A
{
public:
    T value;
    static constexpr auto address = &A<T>::value;
};

template class A<float>;

int main()
{
    A<float> af{42.F};  // uses explicit instantiation: no implicit instantiation occurs.
    A<int> ai{43};      // implicit instantiation.
    std::cout
        << af.*A<float>::address // 42
        << "\n"
        << ai.*A<int>::address;  // 43
}
