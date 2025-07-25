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

pwd

ls -al $PROJECT_ROOT

#
# Clone the opencca-build scripts
#
BUILD_REPO=https://github.com/opencca-user/docker-image-test.git
BUILD_DIRNAME=opencca-build
BUILD_REPO_DIR="$PROJECT_ROOT/$BUILD_DIRNAME"

git clone --depth 1 "$BUILD_REPO" "$BUILD_REPO_DIR"    
