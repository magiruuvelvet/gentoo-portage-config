import std.stdio;

void main()
{
    // check if using the correct libraries and environment
    // except glibc, there should be no GNU in here
    version(CppRuntime_Clang) { writeln("CppRuntime_Clang"); } // print
    version(CppRuntime_Gcc) { writeln("CppRuntime_Gcc"); }     // NOT print
    version(DRuntime_Use_Libunwind) { writeln("DRuntime_Use_Libunwind"); } // print
}
