# `rubygems-operating-system-defaults.patch`

The `--platform=ruby` option forces the compilation of native extensions from source over downloading potentially incompatible binaries.

Examples:
- GNU `libgcc_s.so.1` being used instead of LLVM `libunwind.so.1` - causing 2 different unwind libraries being loaded into the process.
- GNU `libstdc++.so.6` (for C++ extensions) being used instead of LLVM `libc++.so.1` - the former is not present on my system in the ELF linker's default lookup paths.
