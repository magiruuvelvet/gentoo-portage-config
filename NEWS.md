# News

## 2019-08-14 20:36 CEST

I completed my self contained LLVM toolchain which finally
doesn't depend on GCC anymore and can work on its own.
This is possible thanks to the guys who implemented CRT stuff
in compiler-rt. Those where previously taken from GCC in past
LLVM releases. Since 9.0.0 you can kiss GCC goodbye on Linux.

I successfully unmerged GCC and binutils on Gentoo and made
virtual stub packages for them. I can still compile and link
working applications and libraries. For stuff which is still
incompatible with LLVM due to excessive GNU extension usage
I have kept a copy of GCC and binutils inside the /opt/gnu
directory and adjusted the env file for gcc accordingly.
The gcc env works with Portage just fine and uses BFD as
default linker without additional hacks. GCC and LLD are
incompatible now with my new setup and produce faulty ELF
files. Same with Clang + BFD/Gold, because LLVM's CRT files
are not compatible with BFD and Gold.

Summary:
 clang => uses lld by default without additional intervention
 gcc => uses bfd by default without additional intervention

I also made symlinks to the GCC runtime libraries inside
/usr/lib and /usr/lib64 with a custom ebuild to keep software
which depends on it alive. Other than that, GCC and binutils
are "out of sight" on my system and are not longer part of the
standard environment. I additionally made binutils symlinks to
the LLVM counterparts, which now fully replaces binutils on my
system without noticeable issues so far. I will report any
problems as soon as I find any.

ar -> llvm-ar
ranlib -> llvm-ranlib
readelf -> llvm-readelf

and so on...
