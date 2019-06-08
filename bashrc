#!/bin/bash
#
# emerge hooks
#

# TODO:
#   improve this when more hooks are required with a proper hook loader
#   like pacman's libalpm library
#   currently this is still manageable with less than 10 packages

# source all hooks
for f in /etc/portage/hooks/*.hook; do
    . "$f";
done

# helper function to print hook feedback
print_run_hook_msg() {
    echo -e "\e[1m\e[38;2;188;18;160m>>> Running $1 hook for [$2]...\e[0m"
}

# print current ebuild phase
if [ ! -z "$EBUILD_PHASE" ]; then
    echo -e "\e[1m>>> \e[38;2;120;120;39m[${CATEGORY}/${PN}]\e[0m\e[1m Running ebuild phase \e[38;2;48;90;116m$EBUILD_PHASE\e[0m\e[1m...\e[0m"
fi

# invoke emerge hook trigger
case "$EBUILD_PHASE" in
    prepare)        prepare ;;
    postinst)       post_install ;;

    *) : ;;
esac

prepare() {
    case "${CATEGORY}/${PN}" in
        sys-libs/glibc)
            # fix glibc configure and build by removing custom library paths
            unset LD_LIBRARY_PATH ;;

        *) : ;;
    esac
}

# post install hook trigger
post_install() {
    case "${CATEGORY}/${PN}" in
        app-emulation/wine-vanilla)
            print_run_hook_msg "post install" "${CATEGORY}/${PN}"
            hook_wine_postinst ;;

        app-emulation/winetricks)
            print_run_hook_msg "post install" "${CATEGORY}/${PN}"
            hook_winetricks_postinst ;;

        x11-misc/compton)
            print_run_hook_msg "post install" "${CATEGORY}/${PN}"
            hook_compton_postinst ;;

        x11-terms/xterm)
            print_run_hook_msg "post install" "${CATEGORY}/${PN}"
            hook_xterm_postinst ;;

        sys-process/htop)
            print_run_hook_msg "post install" "${CATEGORY}/${PN}"
            hook_htop_postinst ;;

        media-sound/alsa-tools)
            print_run_hook_msg "post install" "${CATEGORY}/${PN}"
            hook_alsa_tools_postinst ;;

        *) : ;;
    esac
}
