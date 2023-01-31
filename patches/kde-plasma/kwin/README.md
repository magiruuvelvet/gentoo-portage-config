# `disable-window-open-close-animation.patch`

Apparently the window open/close animation is enforced. There are only 3 animations with no ability to completely disable window open/close animations.

As solution: take the least annoying animation and remove its implementation to get rid of it. Windows now instantly open and close without animations and delay.

This patch is part of my migration effort from `picom` back to KWin's compositor.
