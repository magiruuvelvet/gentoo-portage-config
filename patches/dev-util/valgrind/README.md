# `use-custom-implementations-of-missing-symbols.patch`

Fixes linker error when **NOT** using GCC and linking with
the LLVM linker.

Those symbols are usually defined in `libgcc.a`, but I don't
have this library in my LLVM toolchain obviously. Fortunately
valgrind has polyfills for Darwin that work on Linux too :)
