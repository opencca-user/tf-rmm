#!/usr/bin/env bash
set -euo pipefail

#
# $0 script.sh
#
# Runs script.sh inside a opencca-build docker environment.
# script.sh is mounted into the container. So it can not depend
# on other relative scripts.
#
# This is a helper to build CI projects


SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
BUILD_REPO=https://github.com/opencca-user/docker-image-test.git
BUILD_DIRNAME=.opencca-build
BUILD_REPO_DIR="$SCRIPT_DIR/$BUILD_DIRNAME"

SCRIPT_TO_RUN=${1:-}
INVOKE_DIR=$PWD

if [[ -n "$SCRIPT_TO_RUN" ]]; then
    SCRIPT_TO_RUN=$(realpath "$SCRIPT_TO_RUN")

    if [[ ! -f "$SCRIPT_TO_RUN" ]]; then
        echo "Error: Script '$SCRIPT_TO_RUN' not found."
        exit 1
    fi
fi

echo ""
echo "Fetching git repository..."

if [[ ! -d "$BUILD_REPO_DIR" ]]; then
    git clone --depth 1 "$BUILD_REPO" "$BUILD_REPO_DIR"
else 
    echo "Updating build repo..."
    cd "$BUILD_REPO_DIR"
    git fetch origin
    git reset --hard origin/opencca/main
fi

cd "$BUILD_REPO_DIR/docker"

echo ""
echo "Pulling docker container..."
make pull

echo ""
echo "Starting docker container..."
make start

echo ""
echo "Executing payload..."

if [[ -z "${SCRIPT_TO_RUN:-}" ]]; then
    echo "No script provided. Opening interactive shell..."
    make enter
    exit 0
fi

echo "Using script: '$SCRIPT_TO_RUN'"
make run-script SCRIPT="$SCRIPT_TO_RUN"