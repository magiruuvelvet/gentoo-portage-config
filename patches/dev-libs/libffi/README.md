clang 10 was able to build this, but clang 11 now errors out

src/x86/sysv.S:832:1: error: changed section flags for .eh_frame, expected: 0x2
.section .eh_frame,"aw",@progbits
^

context:
 https://sourceware.org/pipermail/libc-alpha/2020-March/111890.html
 https://reviews.llvm.org/rGb20b70687a8defb529053da579df95f881e3b078
 https://reviews.llvm.org/D73999
