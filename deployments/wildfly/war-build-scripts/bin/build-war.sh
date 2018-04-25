#!/usr/bin/env bash
set -e

pushd "$BUILD_SCRIPTS_FOLDER"
if [ -f ${1}/install.sh ]; then
    echo "Running ${1}.sh ..."
    bash ${1}/install.sh
else
    echo "Script ${1} does not exist"
fi
popd
