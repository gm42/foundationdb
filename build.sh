#!/bin/bash
## build.sh
## @author gm42
##
## This is the build script used within the container to compile FoundationDB
## and then generate the .deb packages.
## Not supposed to run directly, but only via the FoundationDB builder image.
##
#

set -e

if [ ! -d build_output ]; then
	mkdir -p build_output
	cmake -S . -B build_output -G Ninja -DENABLE_DOCTESTS=OFF
fi

# leave some cores unused for general responsiveness
CORES=$[$(nproc)-2]

# If this crashes it probably ran out of memory. Try ninja -j1
$NINJA_PREFIX ninja -j$CORES -C build_output

cd build_output
exec cpack -G DEB
