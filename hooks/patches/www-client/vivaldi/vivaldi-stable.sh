#!/bin/sh

# use dGPU for rendering and video decoding to take away usage from the iGPU
exec primerun /opt/vivaldi/vivaldi "$@"
