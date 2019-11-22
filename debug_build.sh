#!/usr/bin/env bash
set -e
set -x

build_type=Debug

source build_common.sh
rebuild_project $build_type default ""
