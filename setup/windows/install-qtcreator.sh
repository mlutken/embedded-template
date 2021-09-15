#!/bin/bash

#https://download.qt.io/official_releases/qt/5.12/5.12.11/qt-opensource-windows-x86-5.12.11.exe

QTCREATOR_INSTALL_STARTUP_DIR="$( pwd )"
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/versions.env

QTCREATOR_DOWNLOAD_BASE_URL="https://download.qt.io/official_releases/qt/${QTCREATOR_VERSION_MAJOR}.${QTCREATOR_VERSION_MINOR}/${QTCREATOR_VERSION}"
QTCREATOR_INSTALL_NAME="qt-opensource-windows-x86-${QTCREATOR_VERSION}.exe"
QTCREATOR_INSTALL_URL="${QTCREATOR_DOWNLOAD_BASE_URL}/${QTCREATOR_INSTALL_NAME}"
QTCREATOR_SOURCE_INSTALL_PATH="${PROJECT_INSTALL_SOURCES_DIR}/${QTCREATOR_INSTALL_NAME}"


echo "QTCREATOR_VERSION                 : '${QTCREATOR_VERSION}'"
echo "QTCREATOR_INSTALL_NAME            : '${QTCREATOR_INSTALL_NAME}'"
echo "QTCREATOR_INSTALL_URL             : '${QTCREATOR_INSTALL_URL}'"
echo "QTCREATOR_SOURCE_INSTALL_PATH     : '${QTCREATOR_SOURCE_INSTALL_PATH}'"

wget_ensure_present ${QTCREATOR_INSTALL_URL} ${QTCREATOR_SOURCE_INSTALL_PATH}

echo "Running QtCreator installer!"
echo "IMPORTANT: "
echo "------------------------------------------------------------------------------------------"
echo "--- Make sure you only select the actual Creator IDE and not install any Qt libraries! ---"
echo "------------------------------------------------------------------------------------------"
echo " "


#run_with_cmd_exe ${QTCREATOR_SOURCE_INSTALL_PATH}

cd ${QTCREATOR_INSTALL_STARTUP_DIR}


