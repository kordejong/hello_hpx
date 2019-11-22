#!/usr/bin/env bash
set -e
set -x

build_type=RelWithDebInfo
variant=default

source build_common.sh

rebuild_project
