TOOLCHAIN UPDATE GUIDE
----------------------

**rules of thumb**

 - make a backup of the current toolchain with quickpkg
 - don't skip major versions to avoid undefined behavior or compiler errors during the upgrade
 - complete the toolchain update before installing/updating other software written in C/C++

 - after this steps the new toolchain has completely built itself (verify by checking the
   binaries if the version in the compiler ident section is the same version)
   **this is called a selfhosting toolchain**
 - run the C and C++ unit tests in the portage directory, if anything is wrong you fucked up
   and need to revert to the old version

**commands you will need**

 - `llvm-readelf --elf-output-style=LLVM --string-dump=.comment`
   (receive the compiler and linker version from a binary)

**stage 1** (bootstrap new llvm and clang version with current clang)

 - llvm
 - llvm-common
 - clang
 - clang-common

**stage 2 preparation**

 - update portage bashrc to point to the new toolchain (exported PATH)
   there is no eselect llvm to specify a default llvm version

 - localrepo: update `sys-devel/clang-aliases` and `sys-devel/llvm-binutils` to point
   to the new version and install them

 - once this is done **DON'T** install/update anything else or those
   packages will be most likely broken, you must complete the toolchain
   update at this point before you can use portage normally again

**stage 2** (install compiler-rt and rebuild new llvm and clang version with itself)

 - compiler-rt
 - llvm
 - llvm-common
 - clang
 - clang-common

**stage 3** (rebuild compiler-rt and build lld, and runtime libraries)

 - compiler-rt
 - lld
 - llvm-libunwind
 - libomp
 - libcxxabi
 - libcxx
 - clang-runtime

**stage 4 preparation**

 - check llvm and clang binaries and specially compiler-rt if they still contain the old version
   they shouldn't anymore at this point [compiler ident section]
   the linker identification is still from the previous version - this is normal

 - `compiler-ident /usr/lib/clang/${LLVM_VERSION_FULL}/lib/linux/*`
 - `compiler-ident /usr/lib/llvm/${LLVM_VERSION_MAJOR}/lib64/lib*`

**stage 4** (rebuild lld and then rebuild everything else again)

 - lld

 - llvm
 - llvm-common
 - clang
 - clang-common
 - clang-runtime
 - compiler-rt
 - llvm-libunwind
 - libomp
 - libcxxabi
 - libcxx
 - lldb

**verification step**

 - check if literally everything from the llvm packages is now fully selfhosted
   [compiler ident section]

 - if so, then the upgrade was successful, you should run the unit tests now

 - if you didn't spotted any errors (like wrong compiler-rt version used) and
   the produced binaries have the correct linker and compiler version built-in,
   you can use portage normally again

 - optionally remove the old llvm, clang and compiler-rt versions (slotted in portage)

