#!/usr/bin/env bash

bash ./debug_build.sh 2>&1 | tee debug_build.txt
bash ./rel_with_deb_info_build.sh 2>&1 | tee release_with_deb_info_build.txt
bash ./release_build.sh 2>&1 | tee release_build.txt
