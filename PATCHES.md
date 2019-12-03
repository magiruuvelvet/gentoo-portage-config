# Patches

Overview of custom patches I've made for myself.

## `app-emulation/playonlinux`

 - remove system wine check
 - force clang compiler

## `dev-qt/qtcore`

 - remove QFileSystemWatcher log spam

## `dev-qt/qtspeech`

 - remove actual speech dispatcher functionality

## `dev-qt/qtwebengine`

 - disable stack tracing (crashes on pure LLVM based runtime without GNU)
 - disable crash reporting (broken on non-GNU systems)
 - force LLVM tools at random places

## `dev-util/cmake`

 - use ninja by default when no generator was specified

## `kde-apps/akonadi`

 - force PostgreSQL and remove support for other database backends

## `kde-apps/dolphin`

 - remove trash functionality and visibility (not suited for power users like me)

## `kde-apps/grantleetheme`

 - fix to prevent empty templates from being loaded causing errors in KMail

## `kde-apps/kdepim-runtime`

 - disable this annoying and nagging "retry" error dialog which appears
   when the connection to the IMAP server timed out and Akonadi thinks
   my password is suddenly invalid
 - silently auto-retry with the current password to continue receiving
   e-mails and mitigate connection timeouts automatically in the background
   (no more user intervention required)
 - *delet Google*

## `kde-apps/libgravatar`

 - *delet Gravatar*
 - no more Gravatar connection attempts, just empty invalid pixmaps for everything
 - cache generation removed

## `kde-apps/libkgapi`

 - *delet Google* domains and connection attempts, rendering the library invalid
   without creating monster patches

## `kde-apps/messagelib`

 - remove some babysitting warnings (I don't need this)
 - entirely delete Google Safe Browsing and auto-trust all links by default
 - remove Google server connection attempts

## `kde-apps/pimcommon`

 - remove Google Translate and connection attempts to Google servers

## `kde-frameworks/kio`

 - silence warnings about Samba server not running (the Samba client to browse
   Samba shares via the smb:/ kio slave works without the server, but KIO
   constantly spams shit to the console about it)

## `kde-frameworks/knotifications`

 - hotfix to make notification sounds work again when PulseAudio is running
   in system-mode for every user

## `kde-frameworks/sonnet`

 - remove some console spam about missing languages

## `kde-plasma/plasma-desktop`

 - revert commit [829501dd](https://cgit.kde.org/plasma-desktop.git/commit/?id=829501dd777966091ddcf94e5c5247aaa78ac832)
   which "fixed" mouse pointer acceleration. I almost died because the pointer acceleration was fucked to shit after
   this patch. Thanks Gentoo for saving my sanity <3

## `kde-plasma/plasma-nm`

 - remove a new spam feature introduced in Plasma 5.17 which attempted to constantly scan WiFi networks
   within a 2 second interval rendering the `journalctl -f` output useless. My WiFi card is **NOT**
   managed by NetworkManager because I use it externally using hostapd to create a hot spot. This
   patch increases the interval to 10 minutes and removes error messages about the interface not
   being managed by NetworkManager.

## `kde-plasma/plasma-pa`

 - make the applications tab the default

## `kde-plasma/plasma-workspace`

 - disable the notification history entirely for everything rendering all settings about history invalid.
   The new plasma notification system is way too mobile experience and I don't want to constantly
   remove notifications from the panel like an idiot. Keep this mobile shit out of my laptop!!!
 - disable the notification history for jobs, when job done -> delet notification from history
 - force the notification urgency to "Normal" for all notifications
 - fixes a global menu bar bug caused by KWin hover focus policy

## `media-sound/pulseaudio`

 - minor system mode fix for the `pacmd` command

## `sys-apps/portage`

 - clang is the default system compiler
 - estrip support for LLVM strip command
 - remove some output noise
 - add LLVM toolchain to info pkgs and remove GNU toolchain


## `sys-devel/clang`

 - change platform defaults of Linux to
   - libc++ (instead of libstdc++)
   - libunwind (instead of libgcc_s)
   - compiler-rt (instead of libgcc)
 - change default debugger tuning to LLDB
 - disable unused command warning for `-fuse-ld=`
 - switch default linker to LLD

## *other*

All other patches not mentioned in the above list are LLVM and clang
build fixes and adjustments for my unsupported custom environment.



# Hooks

## `dev-lang/rust`

 - force LLVM runtime libraries and avoid GNU shit

## `dev-libs/openssl`

 - remove local documentation novel

## `kde-apps/kdepim-runtime`

 - remove more Google stuff

## `kde-apps/kipi-plugins`

 - remove everything except remote storage and KDE connect plugin

## `kde-frameworks/kio`

 - remove trash bin and search providers

## `kde-frameworks/purpose`

 - remove proprietary providers

## `kde-plasma/plasma-desktop`

 - remove trash bin

## *other*

All other hooks not mentioned in the above list are generic
bloat clean ups, like useless .desktop files cluttering up
the application menu.
