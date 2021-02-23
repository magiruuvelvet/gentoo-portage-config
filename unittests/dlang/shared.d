// ldc2 -shared shared.d --of=shared.so
// function some_function should be callable from any programming language with ffi support

extern (C) int some_function()
{
    return 1;
}
