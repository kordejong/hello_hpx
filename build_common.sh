basename=hello_hpx
repository_cache=$HOME/development/repository  # Optional


function remove_build()
{
    tmp_root="$1"

    build_root="$tmp_root/build"

    if [ -d "$build_root" ]; then
        rm -fr "$build_root"
    fi
}


# function checkout_sources()
# {
#     tmp_root=${TMPDIR:-/tmp}
#     source_root=$tmp_root/source
# 
#     if [[ ! -d $tmp_root/hpx ]]; do
#         git clone $repository_cache/hpx $tmp_root
#     else
#         echo "Using existing clone of HPX in $tmp_root/hpx"
# }


function build_project()
{
    source_root=$1
    build_root=$2
    build_type=$3
    variant=$4
    shift 4
    cmake_flags=$*

    default_cmake_flags="
        -DHPX_WITH_MALLOC:STRING=tcmalloc
        -DHPX_WITH_HWLOC:BOOL=ON
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
    cmake --build $build_root --verbose --parallel 4
}


function clean_project()
{
    build_root=$1

    cmake --build $build_root --target clean
}


function build_project_fetch_content()
{
    tmp_root=$1
    build_type=$2
    variant=$3
    shift 3

    source_root="$(cd "$(dirname "$BASH_SOURCE")"; pwd -P)"
    build_root=$tmp_root/build

    build_project $source_root $build_root $build_type $variant $*
    clean_project $build_root
}


function build_project_classic()
{
    tmp_root=$1
    build_type=$2
    variant=$3
    shift 3

    source_root=$tmp_root/source
    build_root=$tmp_root/build

    git clone $repository_cache/hpx $source_root
    cd $source_root/hpx
    git checkout 9955e8e  # TODO

    build_project $source_root $build_root $build_type $variant $*
    clean_project $build_root
}


function rebuild_project()
{
    build_type=$1
    variant=$2
    shift 2

    tmp_root=${TMPDIR:-/tmp}/${basename}-fetch_content/$build_type-$variant

    remove_build $tmp_root
    build_project_fetch_content $tmp_root $build_type $variant $*
}


function rebuild_project_classic()
{
    build_type=$1
    variant=$2
    shift 2

    tmp_root=${TMPDIR:-/tmp}/${basename}-classic/$build_type-$variant

    remove_build $tmp_root
    build_project_classic $tmp_root $build_type $variant $*
}
