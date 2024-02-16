#!/bin/sh

# prevent usage of the dGPU - chromium seems to occupy a DRM handle for no valid reason
exec firejail --profile=/etc/firejail/disable-amd-dgpu.local /opt/vivaldi/vivaldi "$@"
