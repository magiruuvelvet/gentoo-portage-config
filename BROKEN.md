# Notes about broken things

Writing down some thoughts and notes I find during the migration to a 100% GNU-free toolchain.
I'm doing this for fun and on my perfectly working production system and it still somehow works.

If you are a noob, don't do this, you are gonna brick your OS real hard.


## D-Bus Daemon (`sys-apps/dbus`)

After recompiling dbus with my LLVM toolchain, Portage somehow forgot to set the SUID flag
on `/usr/libexec/dbus-daemon-launch-helper` which breaks things, because this flag is required.

Several recompiles doesn't fix this, what the fuck Portage??

This needs to be manually fixed by executing: `chmod u+s /usr/libexec/dbus-daemon-launch-helper`.

Without this I have funny things like this in my syslog (`journalctl -f | grep --line-buffered kde`):

```plain
 8月 03 13:11:24 magiruuvelvet-workstation dbus-daemon[718]: [system] Activating service name='org.kde.ktexteditor.katetextbuffer' requested by ':1.433' (uid=1000 pid=18133 comm="/usr/bin/kwrite ") (using servicehelper)
 8月 03 13:11:24 magiruuvelvet-workstation dbus-daemon[718]: [system] Activated service 'org.kde.ktexteditor.katetextbuffer' failed: The permission of the setuid helper is not correct
```

I found this problem using KWrite (my standard GUI text editor) which didn't asked me for
my root password anymore when editing system files and instead annoyed me with a write
permission error. I first though I broke polkit or KAuth, but they are both working fine,
D-Bus was the broken part here.


## Chromium

**UPDATE 2019-08-19: FIXED!**

I fixed the crashing by completely disabling stack tracing in the engine. See patch
`disable-stack-tracing.patch`, as well as the README inside the patch folder for more
details. I tested everything where the engine crashed on me and it works now, including
Netflix and the widevine DRM plugin (which ironically depends on libgcc_s, but it doesn't
crash fortunately :) watched some shows without issues. libgcc_s sneaky is no more, but
you no longer get crash reports; but you can still use a debugger anyway.

**WHAT THE FUCK, KIND OF RESOLVED, BUT ACTUALLY NOT!!**

~~I figured out why this piece of an overengineered shit engine is crashing when compiled~~
~~against LLVM runtime libraries. Thanks to the `--single-process` option using the Qt Web Engine~~
~~I found out that the v8 backtrace handler is silently loading `libgcc_s` for no apparent~~
~~reason, even though the engine was compiled against `libunwind` and than fucking fails~~
~~because "reasons". When moving the gcc_s library out of sight by renaming it the engine has~~
~~no fucking way to load this piece of shit library and than everything fucking works like~~
~~what the fuck dude. Netflix works, fucking everything just works. What the fuck Google are~~
~~you doing? Why are you loading shit you aren't supposed to load when not compiled and linked~~
~~against this library???????!!!! Now I need a way to figure out how to keep software which~~
~~depends on libgcc_s running, but at the same time hide it from you, for fucks sake.~~

**ORIGINAL POST**

~~The entire chromium web engine by itself is completely borked when not built against GNU~~
~~runtime libraries. Compiling with clang itself works, but only when using GNU/libstdc++.~~
~~(`clang -stdlib=libstdc++`, *note that libc++ is the default stdlib for my clang build*)~~

~~There seems to be incompatibilities with libunwind and libc++ with the renderer process.~~
~~In particular some JavaScript DOM operations and HTML5 media are causing a SIGABRT followed~~
~~by a SIGSEGV trying to generate a backtrace with libunwind.~~

~~This crash also includes everything depending on the chromium engine, like Qt Web Engine,~~
~~Electron, and more. Prebuilt binaries against the GNU libraries are working just fine.~~
~~This crash only affects self compiled binaries.~~


## LLDB (LLVM Debugger)

***WORKAROUND:*** Build `glibc` without `splitdebug` (if you need debugging symbols use `nostrip`)
and LLDB finds the correct split debug files again. For even more compatibility it is recommended
to build the entire system with `nostrip` instead of `splitdebug`, when debugging symbols are desired.
This increases the ELF file sizes as consequence, which may hurt performance in some cases.
Side note: LLDB still has trouble finding some debugging symbols when not using the `nostrip` option.

The LLVM Debugger has serious trouble finding the correct split debug files
stored under `/usr/lib/debug` and instead uses `/usr/lib/debug/usr/lib64/crti.o.debug`
for literally everything when debugging symbols are not inside the same file.
As a consequence this causes no symbols to be found:
`libQt5Core.so.5``___lldb_unnamed_symbol6383$$libQt5Core.so.5 + 91`

I tracked this issue down to the LLD ELF Linker. All other libraries which were
linked with GNU/ld have the correct debugging information loaded, but libraries
linked with LLVM/lld use `crti.o.debug` instead. I tested this by recompiling
libraries with the 2 toolchains and then check the `image list` output of LLDB.
100% reproducible all the time. Bug in LLDB or LLD???


## LibreOffice

***RESOLVED!!*** (see patch)

~~Incompatible with LLVM/libc++, makes use of old deprecated and removed features in the C++ standard.~~
~~`std::unexpected_handler` was deprecated in C++11 and completely removed in C++17, LibreOffice still~~
~~depends on this. The funny thing is they are compiling their entire code base with the `-std=gnu++2a`~~
~~flag. Removing the GNU part from this std translates to `-std=c++2a`, which is C++20. I'm literally~~
~~rolling on floor laughing; how can the GNU people still have this old shit in their libstdc++ header~~
~~files when C++20 is requested.~~

~~clang and libc++ follows strict ISO C++ compliance (no vendor extensions), hence this error is generated.~~
~~Requires a fix upstream in LibreOffice.~~

```plain
bridges/source/cpp_uno/gcc3_linux_x86-64/share.hxx:116:10: error: no type named 'unexpected_handler' in namespace 'std'
    std::unexpected_handler unexpectedHandler;
    ~~~~~^
1 error generated.
```

~~A temporary workaround would be to compile LO with the `-stdlib=libstdc++` flag and call it a day,~~
~~but on a GNU-free system this is not an option and needs a patch upstream in LibreOffice.~~


## Grub

Fonts and high resolutions don't work, otherwise no noticeable issues.
Restored from a previous backup, because low res boot is annoying and disturbing.

ebuild requires patching when building with an "out of sight" toolchain.
Didn't bothered to look into it yet, but it fails at the configure step.
