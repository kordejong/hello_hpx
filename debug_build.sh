#!/usr/bin/env bash
set -e
set -x

build_type=Debug
variant=default


basename=hello_hpx
repository_cache=$HOME/development/repository  # Optional

source_root="$(cd "$(dirname "$BASH_SOURCE")"; pwd -P)"
tmp_root=${TMPDIR:-/tmp}/$basename/$build_type-$variant
build_root=$tmp_root/build


mkdir -p `dirname $build_root`
mkdir $build_root
cmake \
    -DCMAKE_BUILD_TYPE=$build_type \
    -DHELLO_HPX_REPOSITORY_CACHE:PATH=$repository_cache \
    -S $source_root \
    -B $build_root
cmake --build $build_root
