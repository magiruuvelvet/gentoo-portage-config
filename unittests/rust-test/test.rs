use std::env;

// test if rustc forced against libunwind instead of libgcc_s
// passes a simple example application
// $ rustc test.rs
// $ ldd test
// should contain libunwind by default
// application should work too without crashing

// rust-bin uses libgcc_s but a symlink to libunwind inside
// /opt/rust-bin-$VERSION/lib/rustlib/x86_64-unknown-linux-gnu/lib
// libgcc_s.so -> /usr/lib64/libunwind.so
// makes rustc link binaries to libunwind.so (verify with ldd)
// and they seem to work

fn test() -> i32
{
    println!("test");
    return 1;
}

fn main()
{ 
    println!("{}", test());
    for argument in env::args()
    {
        println!("{}", argument); 
    } 
}
