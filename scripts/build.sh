#!/bin/bash

# Grab the MACHINE from the environment; otherwise, set it to a sane default
export MACHINE="${MACHINE-measured-intel-corei7-64}"

# What to build
BUILD_TARGETS="
    core-image-tpm \
    core-image-txt \
    measured-image-bootimg \
"

die() {
    echo "$*" >&2
    exit 1
}

rm -f build/conf/bblayers.conf || die "failed to nuke bblayers.conf"
rm -f build/conf/local.conf || die "failed to nuke local.conf"

./scripts/containerize.sh bitbake -k ${BUILD_TARGETS} || die "failed to build"

