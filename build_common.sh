#!/usr/bin/env bash

basename=hello_hpx
repository_cache=$HOME/development/repository  # Optional
source_root="$(cd "$(dirname "$BASH_SOURCE")"; pwd -P)"


function remove_build()
{
    build_type=$1
    variant=$2

    tmp_root=${TMPDIR:-/tmp}/$basename/$build_type-$variant
    build_root=$tmp_root/build

    rm -fr $build_root
}


function build_project()
{
    build_type=$1
    variant=$2
    cmake_flags="${@:3}"

    tmp_root=${TMPDIR:-/tmp}/$basename/$build_type-$variant
    build_root=$tmp_root/build
    default_cmake_flags="
        -HPX_WITH_MALLOC:STRING=tcmalloc
        -HPX_WITH_HWLOC:BOOL=ON
    "

    mkdir -p `dirname $build_root`
    mkdir $build_root
    cmake \
        -DCMAKE_BUILD_TYPE=$build_type \
        -DHELLO_HPX_REPOSITORY_CACHE:PATH=$repository_cache \
        $cmake_flags \
        $default_cmake_flags \
        -S $source_root \
        -B $build_root
    cmake --build $build_root
}


function rebuild_project()
{
    remove_build $*
    build_project $*
}
