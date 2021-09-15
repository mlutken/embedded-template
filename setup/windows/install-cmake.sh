#!/bin/bash

CMAKE_INSTALL_STARTUP_DIR="$( pwd )"
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/versions.env

CMAKE_DOWNLOAD_BASE_URL="https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}"
CMAKE_INSTALL_NAME="cmake-${CMAKE_VERSION}-windows-x86_64.msi"
CMAKE_INSTALL_URL="${CMAKE_DOWNLOAD_BASE_URL}/${CMAKE_INSTALL_NAME}"
CMAKE_SOURCE_INSTALL_PATH="${PROJECT_INSTALL_SOURCES_DIR}/${CMAKE_INSTALL_NAME}"


echo "CMAKE_VERSION                 : '${CMAKE_VERSION}'"
echo "CMAKE_INSTALL_NAME            : '${CMAKE_INSTALL_NAME}'"
echo "CMAKE_INSTALL_URL             : '${CMAKE_INSTALL_URL}'"
echo "CMAKE_SOURCE_INSTALL_PATH     : '${CMAKE_SOURCE_INSTALL_PATH}'"

wget_ensure_present ${CMAKE_INSTALL_URL} ${CMAKE_SOURCE_INSTALL_PATH}

echo "Running CMake installer!"
echo "IMPORTANT: "
echo "--------------------------------------------------------------------------------------------"
echo "--- Make sure you allow the installer to add CMake to the PATH for current or all users! ---"
echo "--------------------------------------------------------------------------------------------"
echo " "


run_with_cmd_exe ${CMAKE_SOURCE_INSTALL_PATH}

cd ${CMAKE_INSTALL_STARTUP_DIR}


