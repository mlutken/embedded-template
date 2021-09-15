#!/bin/bash

# NOTE: meld CAN be installed using choco installer, but it seems to have problems
#       when running it with file and directory arguments

# https://download.gnome.org/binaries/win32/meld/3.20/Meld-3.20.4-mingw.msi

MELD_INSTALL_STARTUP_DIR="$( pwd )"
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/versions.env

MELD_DOWNLOAD_BASE_URL="https://download.gnome.org/binaries/win32/meld/${MELD_VERSION_MAJOR}.${MELD_VERSION_MINOR}"
MELD_INSTALL_NAME="Meld-${MELD_VERSION}-mingw.msi"
MELD_INSTALL_URL="${MELD_DOWNLOAD_BASE_URL}/${MELD_INSTALL_NAME}"
MELD_SOURCE_INSTALL_PATH="${PROJECT_INSTALL_SOURCES_DIR}/${MELD_INSTALL_NAME}"


echo "MELD_VERSION                 : '${MELD_VERSION}'"
echo "MELD_INSTALL_NAME            : '${MELD_INSTALL_NAME}'"
echo "MELD_INSTALL_URL             : '${MELD_INSTALL_URL}'"
echo "MELD_SOURCE_INSTALL_PATH     : '${MELD_SOURCE_INSTALL_PATH}'"

wget_ensure_present ${MELD_INSTALL_URL} ${MELD_SOURCE_INSTALL_PATH}

echo "Running Meld installer!"
echo "IMPORTANT: "
echo "------------------------------------------------------------------------------------------"
echo "--- YOU MUST INSTALL IN THIS DIRECTORY! ---"
echo "--- 'C:\prg86\meld' (all lowercase) ---"
echo "--- 'AND then rename the 'Meld.exe'  to lowercase 'meld.exe'---"
echo "--- AND add the meld.exe directory 'C:\prg86\meld' to your PATH! ---"
echo "------------------------------------------------------------------------------------------"
echo " "

# read -p "Press any key to continue... " -n1 -s

run_with_cmd_exe ${MELD_SOURCE_INSTALL_PATH}

cd ${MELD_INSTALL_STARTUP_DIR}


