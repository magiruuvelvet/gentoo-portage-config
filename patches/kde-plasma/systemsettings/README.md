# Revert opening KCM modules in System Settings

To revert opening KCM modules in `systemsettings` you need to perform a rather nuclear option. After literal hours of looking through the source code I was unable to find the offending code. At some point I stopped caring.

1. Compile `kde-plasma/systemsettings` with the supplied patches. No other components need to be patched.
2. Create a symlink in `/usr/local/bin/systemsettings` (or somewhere in `PATH` that has higher priority than `/usr/bin`) that points to `/usr/bin/kcmshell6`.
3. (Optional?) Restart the KDE session.

The ability to open the full system settings application stays in-tact.

To test if everything works correctly you can open the display settings by right clicking on the Plasma desktop and selecting the corresponding context menu item. The display settings KCM should open as a standalone window. Now open another KCM module using KRunner specifically; you might also want to launch a third KCM module just for fun. You now should see **3 standalone windows** each containing a KCM module. The same effect must apply to Plasma panel modules like NetworkManager and Bluetooth, they all should open as standalone window containing their KCM module again. This restores multitasking and the ability to see multiple system settings side-by-side.

**Personal rant:** I hate how KDE is cloning this shitty and horrible Windows 10+ single-instance locked settings application where it is impossible to open and configure multiple aspects of the system side-by-side. Just like in Windows, the KDE system settings application just navigates to the launched KCM module instead of opening a new standalone window. On desktops this kind of UX is just garbage and a waste of time.
