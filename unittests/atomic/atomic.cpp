#include <cstdio>
#include <atomic>

struct AtomicCounter
{
    std::atomic<int> value;

    void increment()
    {
        ++value;
    }

    void decrement()
    {
        --value;
    }

    int get()
    {
        return value.load();
    }
};

int main()
{
    AtomicCounter c{0};
    c.increment();
    std::printf("%i\n", c.get());
    return 0;
}
