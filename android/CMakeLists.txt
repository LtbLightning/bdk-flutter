set(LIB_VERSION "bdk_flutter_0.29.3") # generated; do not edit

cmake_minimum_required(VERSION 3.10)
project(bdk_flutter)


get_filename_component(CMAKE_PARENT_DIR "${CMAKE_CURRENT_SOURCE_DIR}" DIRECTORY)
set(JNI_LIB_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src/main")
set(BINARY_DIR "${CMAKE_PARENT_DIR}/${LIB_VERSION}")
set(BINARY_ZIP_DIR "${CMAKE_PARENT_DIR}.zip")

if(NOT EXISTS "${BINARY_DIR}")
    file(DOWNLOAD "https://github.com/LtbLightning/bdk-flutter/releases/download/0.29.3/${LIB_VERSION}.zip"
            ${BINARY_ZIP_DIR} TLS_VERIFY ON
         )
          if(WIN32)
                execute_process(
                        COMMAND powershell -Command "Expand-Archive -LiteralPath ${BINARY_ZIP_DIR} -DestinationPath ${CMAKE_PARENT_DIR}"
                )
            else()
                execute_process(
                        COMMAND unzip -q -o "${BINARY_ZIP_DIR}" -d "${CMAKE_PARENT_DIR}"
                )
          endif()
           file(REMOVE_RECURSE "${CMAKE_PARENT_DIR}/__MACOSX")
endif()

if(NOT EXISTS "${JNI_LIB_DIR}/jniLibs")
    file(COPY "${BINARY_DIR}/jniLibs" DESTINATION "${JNI_LIB_DIR}")
    file(REMOVE_RECURSE "${BINARY_DIR}/jniLibs")
endif()





