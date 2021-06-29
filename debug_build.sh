#!/usr/bin/env bash
set -e
set -x

build_type=Debug

source build_common.sh
rebuild_project $build_type default ""
rebuild_project $build_type tests_and_examples "
    -DHPX_WITH_PARCELPORT_TCP:BOOL=ON
    -DHPX_WITH_PARCELPORT_MPI:BOOL=ON
    -DHPX_WITH_PARCELPORT_MPI_MULTITHREADED:BOOL=ON
    -DHPX_WITH_TESTS:BOOL=ON
    -DHPX_WITH_EXAMPLES:BOOL=ON
"
