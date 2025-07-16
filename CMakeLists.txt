cmake_minimum_required(VERSION 3.31)
project(core)

set(CMAKE_CXX_STANDARD 20)

# Paths to your setup scripts
set(POWERSHELL_SCRIPT "${CMAKE_SOURCE_DIR}/scripts/download_cef.ps1")
set(BASH_SCRIPT "${CMAKE_SOURCE_DIR}/scripts/download_cef.sh")

# Path to extracted CEF binaries (update if your folder name differs)
set(CEF_ROOT "${CMAKE_SOURCE_DIR}/CEF")

if(WIN32)
    add_custom_target(CEF_DOWNLOAD ALL
            COMMAND powershell.exe -NoProfile -ExecutionPolicy Bypass -File "${POWERSHELL_SCRIPT}"
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
            COMMENT "Downloading CEF binaries on Windows"
    )
elseif(APPLE)
    add_custom_target(CEF_DOWNLOAD ALL
            COMMAND /bin/bash "${BASH_SCRIPT}"
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
            COMMENT "Downloading CEF binaries on macOS"
    )
elseif(UNIX)
    add_custom_target(CEF_DOWNLOAD ALL
            COMMAND /bin/bash "${BASH_SCRIPT}"
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
            COMMENT "Downloading CEF binaries on Linux"
    )
else()
    message(FATAL_ERROR "Unsupported platform")
endif()


add_executable(core main.cpp)

# Ensure CEF is downloaded before building your app
add_dependencies(core CEF_DOWNLOAD)

target_include_directories(core PRIVATE "${CEF_ROOT}/include")