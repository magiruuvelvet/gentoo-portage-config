Explanation of why `01-llvm-clang-remove-non-needed-libatomic.patch` exists.

You must enable the `system-ssl` USE flag for this patch to work, since the
bundled OpenSSL has the offending `__atomic_is_lock_free` function which isn't
implemented in LLVM compiler-rt right now.

Node.js itself doesn't depend on this function at all. It just works with the
system OpenSSL and without libatomic.
