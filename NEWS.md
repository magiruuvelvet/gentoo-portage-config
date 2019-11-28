# News

## 2019-11-28 12:56 CEST

Building the Rust toolchain without having GNU shit
is cancerous as fuck. The Rust build system can't
handle a compiler defaulting to strict ISO compliance
with all the GNU extensions disabled by default
and spits out random compiler errors when building
native C code (curl, libgit2, ...).
I really hope the Rust people are going to fix this,
because as developer you can't rely with what compiler
the toolchain is built.

There are workarounds and Rust works just fine after that.
If you want to know more how I'm building Rust drop
me a message.


## 2019-08-23 21:03 CEST

I completely recompiled X11 and its entire set of libraries
and applications with clang, except XTerm and video drivers.
Those 2 packages don't work when compiled with clang, even
though there are no errors or warnings.

XTerm just freezes and never loads the shell. In case you
are wondering, XTerm is required for example for i3 to
use the internal i3-msg command for various operations.

The Xorg video drivers (in my case Intel), are making X11
segfault at start with an unhelpful error. There are no
errors or warnings during compilation, but for some reason
the Intel video driver decides to just die when compiled
with clang. I tried to disable all kinds of optimizations,
but to no avail. Just instant crashing.

**Bonus:** I finished recompiling my entire Gentoo with
my pure LLVM toolchain. Only about 10 packages I use
failed to either compile or work with clang. Thats a very
satisfying result compared to 2000 installed packages.

My Gentoo is now only 0.5% GNU, the other 99.5% are powered
by LLVM :) My dream of a GNU-free Linux desktop is becoming
closer and closer every day.


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

Summary:\
 clang => uses lld by default without additional intervention\
 gcc => uses bfd by default without additional intervention\

I also made symlinks to the GCC runtime libraries inside
/usr/lib and /usr/lib64 with a custom ebuild to keep software
which depends on it alive. Other than that, GCC and binutils
are "out of sight" on my system and are not longer part of the
standard environment. I additionally made binutils symlinks to
the LLVM counterparts, which now fully replaces binutils on my
system without noticeable issues so far. I will report any
problems as soon as I find any.

ar -> llvm-ar\
ranlib -> llvm-ranlib\
readelf -> llvm-readelf\

and so on...
