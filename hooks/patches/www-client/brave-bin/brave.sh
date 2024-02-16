#!/bin/sh

# brave requires GCC runtime libraries
export LD_LIBRARY_PATH="/sucks/gnu/runtime/64:$LD_LIBRARY_PATH"

# prevent usage of the dGPU - chromium seems to occupy a DRM handle for no valid reason
exec firejail --profile=/etc/firejail/disable-amd-dgpu.local /opt/brave/brave "$@"
