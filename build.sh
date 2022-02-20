#!/bin/bash

PROJECT=$1
CONFIGURATIONS=$2
PRE=$3
POST=$4

set -e
echo "Building project $PROJECT for configurations '$CONFIGURATIONS' with MPLAB X v6.00 and XC8 v2.36"

if [ ! -z "$PRE" ]; then
	eval $PRE
fi

for CONFIGURATION in ${CONFIGURATIONS}; do
	echo "Generating Makefiles for configuration $CONFIGURATION"
	/opt/mplabx/mplab_platform/bin/prjMakefilesGenerator.sh "$PROJECT@$CONFIGURATION" || exit 1

	echo "Building configuration $CONFIGURATION"
	make -C "$PROJECT" CONF="$CONFIGURATION" build || exit 2
done

if [ ! -z "$POST" ]; then
	eval $POST
fi