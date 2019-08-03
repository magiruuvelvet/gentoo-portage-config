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

The entire chromium web engine by itself is completely borked when not built against GNU
runtime libraries. Compiling with clang itself works, but only when using GNU/libstdc++.
(`clang -stdlib=libstdc++`, *note that libc++ is the default stdlib for my clang build*)

There seems to be incompatibilities with libunwind and libc++ with the renderer process.
In particular some JavaScript DOM operations and HTML5 media are causing a SIGABRT followed
by a SIGSEGV trying to generate a backtrace with libunwind.

This crash also includes everything depending on the chromium engine, like Qt Web Engine,
Electron, and more. Prebuilt binaries against the GNU libraries are working just fine.
This crash only affects self compiled binaries.
