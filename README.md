# Gentoo Portage config files

Attempt to build a fully working LLVM+musl+Linux system with
Gentoo (no GNU toolchains and runtime libraries allowed).

~~GNU+Linux~~

I'm doing this for fun to prove that a Linux Desktop is possible
without using GNU tools.

see [NEWS.md](./NEWS.md) for progress reports


## Done and working on my machine™

 - [x] LLVM 9.0.0 as default toolchain without GCC installed
 - [x] LLVM/clang as default system compiler (can compile 95% of my system) [GNU equivalent: gcc/g++]
 - [x] LLVM/lld as default ELF linker (can link 98% of my system) [GNU equivalent: ld.bfd or ld.gold]
 - [x] LLVM/libc++ and libc++abi as default C++ runtime library (works for 99% of packages) [GNU equivalent: libstdc++]
 - [x] LLVM/libunwind as default stack unwinding library [GNU equivalent: libgcc_s (s for stack)]
 - [x] LLVM/compiler-rt as default compiler routines library [GNU equivalent: libgcc]
 - [x] LLVM/openmp as default openmp library [GNU equivalent: gomp (g as in GNU)]

## work in progress

 - [ ] replace GNU/glibc with musl
 - [ ] find GNU/coreutils replacement which is compatible (command line arguments)

side note: I plan to keep GPL licensed packages and keep GNU/bash as my default shell.
(assuming it works with musl)

## Problems

#### Packages which refuse to work with a non-GNU setup

 - `dev-db/mariadb` (compiles and links, but segfaults at startup instantly due to libunwind)
 - `sys-apps/gsmartcontrol` (naming conflicts with libc++)


---


Fully working without issues:

 - Qt Framework (except Web Engine)
 - KDE Frameworks
 - KDE Plasma Desktop
 - KDE Apps
 - many Qt applications
 - i3
 - mesa
 - Wayland
 - Vulkan (with one exception, see below)
 - X11 Input Drivers
 - fcitx (including all plugins; mozc, pinyin, ...)
 - GNU/binutils (compiled with LLVM toolchain)
 - GNU/coreutils (compiled with LLVM toolchain)
 - Bash shell
 - Zsh shell
 - Gtk+ Framework
 - GtkMM (C++ bindings)
 - Python (and so Portage)
 - Ruby
 - Perl
 - Rust (still depends on libgcc_s for some reason :thinking: )
 - NodeJS
 - NetworkManager
 - ModemManager
 - dbus-daemon (requires workaround)
 - pulseaudio
 - alsa userland tools
 - systemd
 - LibreOffice (requires libc++ compatibility patch)
 - Chromium Web Engine (well yes, but see rant in [BROKEN.md](./BROKEN.md) for details)
 - *and many more...* (can't maintain a full list here)


Not working, needs debugging and probably patches:

I'm compiling these packages with gcc and they are working, but it
is wasteful to load 2 standard libraries into memory at the same time.

 - Linux kernel obviously, same for kernel modules
 - NVIDIA drivers (because kernel module)
 - X11?? (needs more testing)
 - X11 Video Drivers (segfault on start)
 - XTerm (can't start shell??)
 - some X11 libs
 - MariaDB
 - Oracle DB Library (some packages depend on it, some with USE flags, some with a hard dependency)
 - Polkit
 - `media-libs/vulkan-loader` (assembler errors)
 - Wine (compiles and links, but undefined behavior during runtime, can't launch anything)

see also [BROKEN.md](./BROKEN.md) with more detailed descriptions


## Random interesting notes

glibc compatibility layer for musl to run closed source programs built against glibc:
[https://github.com/AdelieLinux/gcompat](https://github.com/AdelieLinux/gcompat)

to name a few programs:

 - Valve Steam
 - RAR Linux
 - xflux
 - "closed source" electron apps (Skype, Discord, ...)



## Gentoo Overlay

This private overlay is part of the migration process and contains patched ebuilds.

[https://github.com/magiruuvelvet/gentoo-overlay](https://github.com/magiruuvelvet/gentoo-overlay)
