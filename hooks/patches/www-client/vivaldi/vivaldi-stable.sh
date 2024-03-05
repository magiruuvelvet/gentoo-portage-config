#!/bin/sh

# NOTE: I swapped GPUs in the UEFI settings, dGPU default, primerun -> iGPU
# use dGPU for rendering and video decoding to take away usage from the iGPU
#exec primerun /opt/vivaldi/vivaldi "$@"
exec /opt/vivaldi/vivaldi "$@"
