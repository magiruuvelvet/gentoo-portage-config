# `revert-7f3967cf38f8ab707681981dd0bc6b220c3dbf83-hide-trash-mime.patch`

This reverts the commit [7f3967cf38f8ab707681981dd0bc6b220c3dbf83](https://github.com/KDE/dolphin/commit/7f3967cf38f8ab707681981dd0bc6b220c3dbf83.patch) which hides backup and trash files together with dot files.

Backup files should always be visible and not be treated as dot files.

TODO (Revert)
- https://invent.kde.org/system/dolphin/-/commit/697d58e9727e229abb81956d27a05d1f02d8c775
  setfoldericonitemaction
