use std::env;

// test if rustc forced against libunwind instead of libgcc_s
// passes a simple example application
// $ rustc test.rs
// $ ldd test
// should contain libunwind by default
// application should work too without crashing

fn main()
{ 
    for argument in env::args()
    {
        println!("{}", argument); 
    } 
}
