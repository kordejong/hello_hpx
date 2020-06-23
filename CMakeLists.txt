cmake_minimum_required(VERSION 3.15)
project(HELLO_HPX LANGUAGES CXX)

include(FetchContent)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

option(${CMAKE_PROJECT_NAME}_BUILD_OTF2
    "If OTF2 is required, build it instead of relying on the environment"
    FALSE)

set(HPX_USE_CMAKE_CXX_STANDARD ON CACHE BOOL "")
set(HPX_WITH_CXX17 ON CACHE BOOL "")

if(${CMAKE_PROJECT_NAME}_REPOSITORY_CACHE AND
        EXISTS ${${CMAKE_PROJECT_NAME}_REPOSITORY_CACHE}/hpx)
    set(hpx_repository ${${CMAKE_PROJECT_NAME}_REPOSITORY_CACHE}/hpx)
else()
    set(hpx_repository https://github.com/STEllAR-GROUP/hpx)
endif()

if(APEX_WITH_OTF2)
    if(${CMAKE_PROJECT_NAME}_BUILD_OTF2)

        set(OTF2_ROOT ${PROJECT_BINARY_DIR}/otf2)

        FetchContent_Declare(otf2
            URL https://www.vi-hps.org/cms/upload/packages/otf2/otf2-2.2.tar.gz
            URL_HASH MD5=cfedf583bf000e98ce0c86e663e5ded0 
        )

        # FetchContent_MakeAvailable(otf2)

        FetchContent_GetProperties(otf2)

        if(NOT otf2_POPULATED)
            FetchContent_Populate(otf2)

            set(otf2_system_type
                "${CMAKE_HOST_SYSTEM_PROCESSOR}-pc-${CMAKE_HOST_SYSTEM_NAME}")
            string(TOLOWER ${otf2_system_type} otf2_system_type)

            message(STATUS "Build OTF2")
            message(STATUS "  otf2_SOURCE_DIR: ${otf2_SOURCE_DIR}")
            message(STATUS "  otf2_BINARY_DIR: ${otf2_BINARY_DIR}")
            message(STATUS "  OTF2_ROOT      : ${OTF2_ROOT}")
            message(STATUS "  system-type    : ${otf2_system_type}")

            execute_process(
                COMMAND
                    ${otf2_SOURCE_DIR}/configure
                        --prefix ${OTF2_ROOT}
                        --build=${otf2_system_type}
                        --host=${otf2_system_type}
                        --target=${otf2_system_type}
                        CC=${CMAKE_C_COMPILER} CXX=${CMAKE_CXX_COMPILER}
                        PYTHON=: PYTHON_FOR_GENERATOR=:
                WORKING_DIRECTORY
                    ${otf2_BINARY_DIR}
            )

            include(ProcessorCount)
            ProcessorCount(nr_cores)
            math(EXPR nr_cores_to_use "${nr_cores} / 2")

            execute_process(
                COMMAND
                    make -j${nr_cores_to_use}
                WORKING_DIRECTORY
                    ${otf2_BINARY_DIR}
            )
            execute_process(
                COMMAND
                    make install
                WORKING_DIRECTORY
                    ${otf2_BINARY_DIR}
            )
        endif()
    ### else()
    ###     # Set OTF2_ROOT, or OTF2_LIBRARY and OTF2_INCLUDE_DIR
    ###     message(FATAL_ERROR "Add logic to find OTF2")
    endif()
endif()


FetchContent_Declare(hpx
    GIT_REPOSITORY ${hpx_repository}
    GIT_TAG 001c1bcc936  # Master at 20200619
)

FetchContent_MakeAvailable(hpx)
