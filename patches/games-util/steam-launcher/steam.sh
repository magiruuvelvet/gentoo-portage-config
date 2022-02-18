#!/bin/bash
export DISABLE_VK_LAYER_VALVE_steam_overlay_1=1
export DISABLE_VK_LAYER_VALVE_steam_fossilize_1=1

# enable PRIME Render Offload
export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __VK_LAYER_NV_optimus=NVIDIA_only

# unset Intel settings
unset __EGL_VENDOR_LIBRARY_FILENAMES
unset VK_ICD_FILENAMES

exec /usr/lib/steam/steam "$@"
