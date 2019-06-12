# removes all desktop files from a package before it is merged into the system
# that way "equery files" will not show these files as they are not part of the
# package; call this function inside the instprep ebuild phase
remove_desktop_files() {
    if [ ! -z "$ED" ]; then
        rm -r "$ED/usr/share/applications"
    fi
}

remove_desktop_directories() {
    if [ ! -z "$ED" ]; then
        rm -r "$ED/usr/share/desktop-directories"
    fi
}

remove_xdg_menus() {
    if [ ! -z "$ED" ]; then
        rm -r "$ED/etc/xdg/menus"
    fi
}
