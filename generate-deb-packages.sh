#!/bin/bash
## generate-deb-packages.sh
## @author gm42
##
## Helper script to generate .deb packages for FoundationDB.
## It supports linux/arm64/v8 and linux/amd64.
##
#

set -e

if [ $# -ne 1 ]; then
	echo "Usage: generate-deb-packages.sh (linux/arm64/v8 | linux/amd64)" 1>&2
	exit 1
fi

## this unofficial builder image is separately built using Ubuntu22 as base
IMAGE=ghcr.io/gm42/fdb-build-support:ubuntu22-latest

# some options that can help to limit resource consumption
#NINJA_PREFIX="nice -n15"
#DOCKER_OPTS="	--cpu-shares=512 --memory=12G --memory-swap=16G"

exec docker run -it --platform "$1" -v $PWD:/opt/src/foundationdb -w /opt/src/foundationdb \
	$DOCKER_OPTS \
	-e NINJA_PREFIX="$NINJA_PREFIX" \
	"$IMAGE" ./build.sh
