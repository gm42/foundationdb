#!/bin/bash
## generate-arm64-deb-packages.sh
## @author gm42
##
## Helper script to generate arm64 .deb packages for FoundationDB.
##
#

set -e

## this unofficial builder image is separately built using Ubuntu22 as base
IMAGE=ghcr.io/gm42/fdb-build-support:ubuntu22-latest

# some options that can help to limit resource consumption
#NINJA_PREFIX="nice -n15"
#DOCKER_OPTS="	--cpu-shares=512 --memory=12G --memory-swap=16G"

exec docker run -it --platform linux/arm64/v8 -v $PWD:/opt/src/foundationdb -w /opt/src/foundationdb \
	$DOCKER_OPTS \
	-e NINJA_PREFIX="$NINJA_PREFIX" \
	"$IMAGE" ./build.sh
