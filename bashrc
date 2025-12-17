#!/bin/bash

# enable ebuild preservation archive
EBUILD_PRESERVATION_ARCHIVE_ENABLED=true

# prepend latest LLVM version to PATH to avoid problems with env.d and multiple LLVM versions
export PATH="/usr/lib/llvm/current/bin:$PATH"

# invoke emerge hook trigger for each package and ebuild phase (except depend)
# hooks are stored in /etc/portage/hooks
if [[ ! -z "$EBUILD_PHASE" && "$EBUILD_PHASE" != "depend" ]]; then
    echo -e "\e[1m>>> \e[38;2;120;120;39m[${CATEGORY}/${PN}]\e[0m\e[1m Running ebuild phase \e[38;2;48;90;116m$EBUILD_PHASE\e[0m\e[1m...\e[0m"
    /etc/portage/hooks/portage-hook-ctrl --pkg "${CATEGORY}/${PN}" --phase "$EBUILD_PHASE" --run
    if (( $? != 0 )); then
        die "\e[1mhook for [${CATEGORY}/${PN}][$EBUILD_PHASE] terminated with an error\e[0m"
    fi
fi

# preserve the ebuild during the postinst phase
if [[ "${EBUILD_PHASE}" == "postinst" && "${EBUILD_PRESERVATION_ARCHIVE_ENABLED}" == "true" ]]; then
    source "/etc/portage/ebuild-preservation-archive.sh"
    ebuild_preservation_archive_main
fi

notify-send() {
    # only attempt to send a notification if DISPLAY is set to avoid hangs in tty mode
    if [ ! -z "$DISPLAY" ]; then
        su - magiruuvelvet -c "DISPLAY=:0 notify-send -t 6000 --app-name=Portage Portage \"$@\""
    fi
}

# show use flags and features during the setup phase
if [[ "$EBUILD_PHASE" == "setup" ]]; then

    # notify when package starts merging
    notify-send "Emerging <b>${CATEGORY}/${PN}</b>..."

    echo -e "\e[1mUSE:     \e[0m ${USE}"
    echo -e "\e[1mFEATURES:\e[0m ${FEATURES}"
    echo -e "\e[1mCFLAGS:  \e[0m $( [ "$CC" ] && echo "${CC} " )${CFLAGS}"
    echo -e "\e[1mCXXFLAGS:\e[0m $( [ "$CXX" ] && echo "${CXX} " )${CXXFLAGS}"
    echo -e "\e[1mLDFLAGS: \e[0m $( [ "$LD" ] && echo "${LD} " )${LDFLAGS}"
fi

# notify when package was successfully installed
if [[ "$EBUILD_PHASE" == "postinst" ]]; then
    notify-send "Installed <b>${CATEGORY}/${PN}</b>"
fi

# unset LD_LIBRARY_PATH and rely exclusively on ld.so.cache
unset LD_LIBRARY_PATH

# ninja progress status format
# default is: "[%f/%t] "
# see src/build.cc in BuildStatus::FormatProgressStatus for supported placeholders
export NINJA_STATUS="$(echo -e "\e[1m[%f/%t \e[38;2;42;181;0m(%p)\e[0m\e[1m]\e[0m ")"
