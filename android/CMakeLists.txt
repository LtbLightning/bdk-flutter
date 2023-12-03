cmake_minimum_required(VERSION 3.18.1)
project(bdk_flutter)
get_filename_component(CMAKE_PARENT_DIR "${CMAKE_CURRENT_SOURCE_DIR}" DIRECTORY)
set(TEXT_FILE_PATH "${CMAKE_PARENT_DIR}/assets/release.config.txt")
file(STRINGS ${TEXT_FILE_PATH} lines)
foreach(line IN LISTS lines)
    string(REGEX MATCH "TAG_VERSION=(.*)" _ ${line})
    if(CMAKE_MATCH_1)
        set(TAG_VERSION ${CMAKE_MATCH_1})
    endif()

    string(REGEX MATCH "REPOSITORY_URL=(.*)" _ ${line})
    if(CMAKE_MATCH_1)
        set(REPOSITORY_URL ${CMAKE_MATCH_1})
    endif()
endforeach()


set(LIB_NAME "bdk.${TAG_VERSION}")
set(URL "${REPOSITORY_URL}${TAG_VERSION}/${LIB_NAME}.zip")
set(OUTPUT_PATH "${CMAKE_PARENT_DIR}/${LIB_NAME}.zip")
if(NOT EXISTS "${CMAKE_PARENT_DIR}/${LIB_NAME}")
        file(DOWNLOAD ${URL} ${OUTPUT_PATH}
                STATUS DOWNLOAD_STATUS
                SHOW_PROGRESS)
        list(GET DOWNLOAD_STATUS 0 STATUS_CODE)
        if(NOT STATUS_CODE EQUAL 0)
            message(FATAL_ERROR "Download failed: ${DOWNLOAD_STATUS}")
        endif()
        if(WIN32)
                execute_process(
                        COMMAND ${CMAKE_COMMAND} -E tar xvf ${OUTPUT_PATH}
                        WORKING_DIRECTORY ${CMAKE_PARENT_DIR}
                )
        else()
                execute_process(
                        COMMAND ${CMAKE_COMMAND} -E tar xvf ${OUTPUT_PATH}
                        WORKING_DIRECTORY ${CMAKE_PARENT_DIR}
                )
        endif()
        file(REMOVE_RECURSE "${CMAKE_PARENT_DIR}/__MACOSX" )
        file(REMOVE "${OUTPUT_PATH}" )
endif()
if( NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/src/main/jniLibs" )
    file(COPY "${CMAKE_PARENT_DIR}/${LIB_NAME}/jniLibs" DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/src/main/" )
    file(REMOVE_RECURSE "${CMAKE_PARENT_DIR}/${LIB_NAME}/jniLibs")
endif()
