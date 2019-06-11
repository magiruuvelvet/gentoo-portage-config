#!/bin/bash

# invoke emerge hook trigger for each package and ebuild phase
# hooks are stored in /etc/portage/hooks
if [ ! -z "$EBUILD_PHASE" ]; then
    echo -e "\e[1m>>> \e[38;2;120;120;39m[${CATEGORY}/${PN}]\e[0m\e[1m Running ebuild phase \e[38;2;48;90;116m$EBUILD_PHASE\e[0m\e[1m...\e[0m"
    /etc/portage/hooks/portage-hook-ctrl --pkg "${CATEGORY}/${PN}" --phase "$EBUILD_PHASE" --run
fi
