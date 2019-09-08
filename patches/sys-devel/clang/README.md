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

- changes the default debugger tuning to LLDB because this is my default
  debugger. I don't want GDB "optimized" shit when I only use LLDB. The patch
  also prevents GNU pubnames from being created when the tuning is set to LLDB.
  This makes debugging with LLDB way more efficient and easier.


## LLDB tuning patch in action!!!

before with GDB tuning by default:

```plain
* frame #0: 0x00007ffff7bedc71 libc.so.6`__GI_raise + 321
    frame #1: 0x0000000000201252 a.out`A::hello(char*) + 50
    frame #2: 0x00000000002011be a.out`main + 62
    frame #3: 0x00007ffff7bd8f1b libc.so.6`__libc_start_main + 235
    frame #4: 0x000000000020102a a.out`_start + 42
```

after the LLDB tuning by default patch:

```plain
  * frame #0: 0x00007ffff7bedc71 libc.so.6`__GI_raise + 321
    frame #1: 0x0000000000201252 a.out`A::hello(this=0x00007fffffffbda8, a="/etc/portage/unittests/toolchain-test/a.out") at testdebugger.cpp:23:9
    frame #2: 0x00000000002011be a.out`main(argc=1, argv=0x00007fffffffbea8) at testdebugger.cpp:39:7
    frame #3: 0x00007ffff7bd8f1b libc.so.6`__libc_start_main + 235
    frame #4: 0x000000000020102a a.out`_start + 42
```

No more `-glldb -gno-gnu-pubnames` options required when building software, because this patch makes this the default :)
