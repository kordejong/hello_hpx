#!/usr/bin/env bash
set -e
set -x

build_type=Debug
variant=default

source build_common.sh

rebuild_project
