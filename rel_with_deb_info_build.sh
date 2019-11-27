#!/usr/bin/env bash
set -e
set -x

build_type=RelWithDebInfo

source build_common.sh
rebuild_project $build_type default ""
rebuild_project $build_type papi "-DHPX_WITH_PAPI:BOOL=ON"
# rebuild_project $build_type apex "
#     -DHPX_WITH_APEX:BOOL=ON
#     -DAPEX_WITH_OTF2:BOOL=ON
# "
# #   -DAPEX_WITH_PAPI:BOOL=ON
# # HPX_WITH_APEX_TAG "v2.1.3"
# # HPX_WITH_APEX_NO_UPDATE ON