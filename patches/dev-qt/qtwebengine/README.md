# `qtwebengine-QTBUG-75265-v5.12.3.patch`

Fails to build in Release mode with optimizations due to a bug
in the build system. This patch enables release builds.

# `add-missing-header-in-webrtc-lib.patch`

Fails to find a specific declaration since the installation
of Linux Headers 5.2 (worked with 5.1). Add the missing header
files to allow compilation.

# `replace-gcc-with-llvm.patch`

Remove explicit gcc runtime linkage and replace with LLVM.
Does not actually work, but keep this patch anyway.

# `disable-stack-tracing.patch`

Stack tracing is broken when compiled against a pure LLVM runtime.
Chrome sneaks in a libgcc_s using some dlopen hack and than crashes
because of obvious incompatibility with LLVM and libunwind.

Disable stack tracing entirely to avoid crashes.

