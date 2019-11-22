#!/usr/bin/env bash
set -e
set -x

build_type=RelWithDebInfo

source build_common.sh
rebuild_project $build_type default ""
rebuild_project $build_type papi "-DHPX_WITH_PAPI:BOOL=ON"
