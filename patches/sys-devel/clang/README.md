# Clang Compiler Customizations

- changes default platform libraries to compiler-rt/libunwind/libc++ when
  `--rtlib=platform --unwindlib=platform --stdlib=platform` is specified
  on the command line. When omitted clang already used those by default,
  because you can configure this with CMake. But clang still thought I would
  prefer GNU bullshit when explicitly specifying `platform`.
  This patch is a counter measure for shitty build systems and I created this
  for just in case™. Fortunately I didn't encountered such a build system yet :)

  THIS PATCH ONLY AFFECTS THE `Linux` TOOLCHAIN WITHIN CLANG! Cross-compiling
  to other operating system targets isn't affected in any way.

- changes the default linker to LLVM's own linker when not specified with
  the `-fuse-ld=` command line flag.

- disables all kinds of warnings related to the `-fuse-ld=` command line flag
  to prevent failure when a program is built with `-Werror`, but an alternative
  linker is required to due bugs in either the build system of the program or in LLD.
