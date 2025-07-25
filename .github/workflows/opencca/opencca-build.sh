#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

#
# XXX: This runs inside opencca-build environment
#
PRE_RUN_DIR=$PWD
cd $SCRIPT_DIR

# XXX: /opencca in container
PROJECT_ROOT=/opencca
REPO_DIR=$PROJECT_ROOT/tf-rmm
SNAPSHOT_DIR=$PROJECT_ROOT/snapshot
BUILD_DIR=$PROJECT_ROOT/opencca-build
BUILD_REPO=https://github.com/opencca-user/docker-image-test.git

rm -r $BUILD_DIR
git clone --depth 1 "$BUILD_REPO" "$BUILD_DIR"    

rm -r $SNAPSHOT_DIR
mkdir -p $SNAPSHOT_DIR

cd $BUILD_DIR/buildconf

./firmware_opencca.mk rmm



