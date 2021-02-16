#!/bin/sh

# discord requires GCC runtime libraries
export LD_LIBRARY_PATH="/sucks/gnu/runtime/64:$LD_LIBRARY_PATH"

exec /opt/discord/Discord "$@"
