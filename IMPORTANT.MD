# IMPORTANT!!!!

Don't fuck around with `eselect gcc` or you brick clang for some
reason, producing faulty code with undefined behavior and crashes.

I wasted hours recompiling my toolchain for nothing. At least I
figured it out, because I keep notes and document my GNU-free
migration process and keep log files around.

Something funky with the CRT files happened causing incompatibilities
with glibc.

For now you still need to keep one gcc installation around
to make Gentoo happy. I hope this is not required anymore
with musl, because musl comes with their own crt files.
