## Build Fixer

 - ld wrapper to remove GNU-only options

## Compiler Patches

 - remove linker options which are only available in GNU
 - use compiler-rt from LLVM instead of libgcc (including crt files)

## Breakage caused by above patches

 - only x86-64 compilation is supported, all other architectures are broken now
 - x64-32 doesn't work either due to hardcoded architecture in crt filenames
 - cross-compilation doesn't work anymore

## Personal notes

 - fpc has some room for improvement to stop depending on GCC
   and add LLVM toolchain support, including compiler-rt and co.
