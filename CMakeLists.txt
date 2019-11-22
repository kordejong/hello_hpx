cmake_minimum_required(VERSION 3.15)
project(HELLO_HPX LANGUAGES CXX)

include(FetchContent)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(HPX_WITH_CXX17 ON CACHE BOOL "")

if(${CMAKE_PROJECT_NAME}_REPOSITORY_CACHE AND
        EXISTS ${${CMAKE_PROJECT_NAME}_REPOSITORY_CACHE}/hpx)
    set(hpx_repository ${${CMAKE_PROJECT_NAME}_REPOSITORY_CACHE}/hpx)
else()
    set(hpx_repository https://github.com/STEllAR-GROUP/hpx)
endif()

FetchContent_Declare(hpx
    GIT_REPOSITORY ${hpx_repository}
    # GIT_TAG 81747589077ddd78ea9de683f80a3b5663501b04  # 1.4.0-rc1
    # GIT_TAG 30c2f114162  # cmake_path_pb pull request 1
    # GIT_TAG 560e3d06568  # cmake_path_pb pull request 2
    GIT_TAG a81289b0e66  # cmake_path_pb pull request 3
)

FetchContent_MakeAvailable(hpx)
