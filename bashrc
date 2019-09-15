#!/bin/bash

# invoke emerge hook trigger for each package and ebuild phase (except depend)
# hooks are stored in /etc/portage/hooks
if [[ ! -z "$EBUILD_PHASE" && "$EBUILD_PHASE" != "depend" ]]; then
    echo -e "\e[1m>>> \e[38;2;120;120;39m[${CATEGORY}/${PN}]\e[0m\e[1m Running ebuild phase \e[38;2;48;90;116m$EBUILD_PHASE\e[0m\e[1m...\e[0m"
    /etc/portage/hooks/portage-hook-ctrl --pkg "${CATEGORY}/${PN}" --phase "$EBUILD_PHASE" --run
fi

# glibc configure script bad
# lets just unset this for everything in case of other bad build systems
unset LD_LIBRARY_PATH

# ninja progress status format
# default is: "[%f/%t] "
# see src/build.cc in BuildStatus::FormatProgressStatus for supported placeholders
export NINJA_STATUS="$(echo -e "\e[1m[%f/%t \e[38;2;42;181;0m(%p)\e[0m\e[1m]\e[0m ")"
