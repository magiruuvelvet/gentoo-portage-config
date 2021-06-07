# `disable-stack-tracing.patch`

Stack tracing is broken when compiled against a pure LLVM runtime.
Chrome sneaks in a libgcc_s using some dlopen hack and than crashes
because of obvious incompatibility with LLVM and libunwind.

Disable stack tracing entirely to avoid crashes.

# `disable-crash-reporting.patch`

Broken and crashes with a pure LLVM runtime without GCC stuff.

# `remove-gnu-runtime-linkage.patch`

This can't work with a pure LLVM based userland, because the GNU runtime
doesn't exist there. Linking non existent libraries makes the LLD linker
unhappy :(
