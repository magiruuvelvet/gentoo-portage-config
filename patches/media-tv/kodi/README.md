Collection of Kodi patches to improve the UX on Laptops/Desktops :)

Those are basically workarounds for stuff Kodi was never intended to be used for.


## `always-show-os-mouse.patch`

Get rid of this pesky Kodi mouse and always use the default OS cursor.
No more weird mouse sensitivity and motion smoothing. Use the default
OS mouse settings as it should be.

**What this patch does?**

It removes calls to the following X11 APIs

 - `XDefineCursor`
 - `XUndefineCursor`

which declare custom cursors in X11 client windows.

In Kodi some toggle options are removed and force the mouse
state and visibility to be always on `true`.

This is unfortunately hardcoded and can't be toggled with a
setting in Kodi. Using a source-based distro like Gentoo
really helps in such situations.


## `hide-kodi-cursor.patch`

Hides the default Kodi cursor without disabling it. Because disabling
it also disables mouse input.


---

# Post Installation Steps

Copy the `pointer_1x1.png` to your theme and change the `Pointer.xml`
as seen in the `hide-kodi-cursor.patch` patch file. The patch only
applies to the default Kodi theme.

You still need to copy the pointer icon as the patch doesn't create
it.
