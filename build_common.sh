#!/usr/bin/env bash

# Requirements:
# - build_type
# - variant

basename=hello_hpx
repository_cache=$HOME/development/repository  # Optional


source_root="$(cd "$(dirname "$BASH_SOURCE")"; pwd -P)"
tmp_root=${TMPDIR:-/tmp}/$basename/$build_type-$variant
build_root=$tmp_root/build


function remove_build()
{
    rm -fr $build_root
}


function build_project()
{
    mkdir -p `dirname $build_root`
    mkdir $build_root
    cmake \
        -DCMAKE_BUILD_TYPE=$build_type \
        -DHELLO_HPX_REPOSITORY_CACHE:PATH=$repository_cache \
        -S $source_root \
        -B $build_root
    cmake --build $build_root
}


function rebuild_project()
{
    remove_build
    build_project
}
