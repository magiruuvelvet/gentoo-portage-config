#!/bin/sh

# brave requires GCC runtime libraries
export LD_LIBRARY_PATH="/sucks/gnu/runtime/64:$LD_LIBRARY_PATH"

# NOTE: I swapped GPUs in the UEFI settings, dGPU default, primerun -> iGPU
# use dGPU for rendering and video decoding to take away usage from the iGPU
#exec primerun /opt/brave/brave "$@"

exec /opt/brave/brave "$@"
