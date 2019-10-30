# `revert-829501dd777966091ddcf94e5c5247aaa78ac832.patch`

Reverts the "fix" for mouse pointer acceleration
which changed the behavior and bricked my mouse
acceleration. Everything is totally fucked with
this commit so revert it.

# `taskmanager-*` (discontinued, too buggy)

~~Improves the situation with a global menu bar and only~~
~~one single panel to avoid jump scare glitches in the~~
~~panel when the menu size changes. Task Manager is pushed~~
~~to the right using "Latte Spacer".~~
~~Works in 95% of the cases when the menu bar isn't too~~
~~long.~~

~~NOTE: I like screen real estate and don't want to fucking~~
~~close a Mac with this shitty bottom icon bar. There is~~
~~enough free available space on the top panel to force~~
~~everything into.~~

# `pager-always-show-minimized-windows.patch`

Visualizes even minimized windows in the Plasma Pager to
see what the fuck is going on on my 10 workspaces with
a KWin Tiling WM Script. Makes live so much easier, never
lose minimized windows again in this workspace mess.
