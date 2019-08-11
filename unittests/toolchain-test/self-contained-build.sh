# only libc crt files and compiler-rt crt files used; 100% GCC-free toolchain yay :)
clang++ -v -nostdlib test.cpp /usr/lib64/crt1.o /usr/lib64/crti.o /usr/lib/clang/9.0.0/lib/linux/clang_rt.crtbegin-x86_64.o -lc -lc++ -lm /usr/lib/clang/8.0.1/lib/linux/libclang_rt.builtins-x86_64.a /usr/lib/clang/9.0.0/lib/linux/clang_rt.crtend-x86_64.o /usr/lib64/crtn.o
