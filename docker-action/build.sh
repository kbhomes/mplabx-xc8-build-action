#!/bin/bash

echo "Building project $1:$2"

set -x -e

ls -alh

pwd 

/opt/mplabx/mplab_platform/bin/prjMakefilesGenerator.sh -v "$1@$2" || exit 1
make -C "$1" CONF="$2" build || exit 2
