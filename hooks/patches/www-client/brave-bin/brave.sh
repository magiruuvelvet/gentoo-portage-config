#!/bin/sh

# brave requires GCC runtime libraries
export LD_LIBRARY_PATH="/sucks/gnu/runtime/64:$LD_LIBRARY_PATH"

# use dGPU for rendering and video decoding to take away usage from the iGPU
exec primerun /opt/brave/brave "$@"
