#!/usr/bin/env bash
set -e
set -x

build_type=RelWithDebInfo

source build_common.sh
rebuild_project $build_type default ""
rebuild_project $build_type papi "-DHPX_WITH_PAPI:BOOL=ON"
rebuild_project $build_type apex "
    -DHPX_WITH_APEX:BOOL=ON
    -DHPX_WITH_APEX_TAG:STRING=develop
    -DAPEX_WITH_OTF2:BOOL=ON
    -DHELLO_HPX_BUILD_OTF2:BOOL=ON
"
