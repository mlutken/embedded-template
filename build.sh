#!/bin/bash

PROJECT_NAME="embedded-template"
PROJECT_REPOSITORY_ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CODE_ROOT_DIR="$( dirname "${PROJECT_REPOSITORY_ROOT_DIR}" )"
CODE_BUILD_ROOT_DIR="${CODE_ROOT_DIR}/_build"
PROJECT_BUILD_ROOT_DIR="${CODE_BUILD_ROOT_DIR}/${PROJECT_NAME}"


REBUILD="n"
BUILD_TYPE="release"
RUN_TESTS="y"
SUGGEST_USAGE="n"
PLATFORM="hostwindows"

# ---------------------
# --- Detect system ---
# ---------------------
if [ -f /etc/lsb-release ]; then
    PLATFORM="hostlinux"
fi

BITWIDTH=64

DISTRIB=linux

if type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    DISTRIB_ID=$(lsb_release -si)
    DISTRIB_RELEASE=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    . /etc/lsb-release # Get system info
fi

# --- Lowercase DISTRIB_ID ---
DISTRIB_ID=${DISTRIB_ID,,}
DISTRIB=${DISTRIB_ID}${DISTRIB_RELEASE}
export DISTRIB_ID
export DISTRIB_RELEASE
export DISTRIB

# echo "DISTRIB_ID                    : '${DISTRIB_ID}'"
# echo "DISTRIB_RELEASE               : '${DISTRIB_RELEASE}'"
# echo "DISTRIB                       : '${DISTRIB}'"
# echo "PROJECT_REPOSITORY_ROOT_DIR   : '${PROJECT_REPOSITORY_ROOT_DIR}'"
# echo "CODE_ROOT_DIR                 : '${CODE_ROOT_DIR}'"
# echo "CODE_BUILD_ROOT_DIR           : '${CODE_BUILD_ROOT_DIR}'"
# echo "PROJECT_BUILD_ROOT_DIR        : '${PROJECT_BUILD_ROOT_DIR}'"

# -------------------------------------
# --- Parse command line parameters ---
# -------------------------------------
for i in $*
do
	case $i in
    	-p=*|platform=*)
		PLATFORM=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
		;;
    	-r=*|--rebuild=*)
		REBUILD=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
		;;
    	-b=*|--buildtype=*)
		BUILD_TYPE=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
    	;;
    	-t=*|--test=*)
		RUN_TESTS=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
    	;;
    	-h|--help)
		echo "Options:"
		echo "  -p=|--platform=[$PLATFORM]"
		echo "    Platform! Values: targetall, hostlinux, hostwindows, clangstatic, radio2003, dsp7."
		echo " "
		echo "  -r=|--rebuild=[$REBUILD]"
		echo "    Rebuild all: Values 'y' OR 'n'."
		echo " "
		echo "  -b=|--buildtype=[$BUILD_TYPE]"
		echo "    'debug' or 'release' or '' (release)."
		echo " "
		echo "  -t=|--test=[$RUN_TESTS]"
		echo "    Run tests. Values 'y' or 'n'."
		echo " "
		echo "  -h=|--help"
		echo "    Print this help"
		echo " "
		exit
		;;
    	--default)
		SUGGEST_USAGE="y"
		;;
    	*)
                # unknown option
		;;
  	esac
done


PLATFORM_TYPE="embedded"
if [[ "hostlinux" == "${PLATFORM}" || "hostwindows" == "${PLATFORM}" ]];
then
    PLATFORM_TYPE="hostpc"
fi

PLATFORM_BUILD_ROOT_DIR="${PROJECT_BUILD_ROOT_DIR}/${PLATFORM}"

if [ "y" == "${REBUILD}" ]
then
    echo "Rebuilding..."
    rm -rf ${PLATFORM_BUILD_ROOT_DIR}
fi


if [[ ! -d ${PLATFORM_BUILD_ROOT_DIR} || ! -f ${PLATFORM_BUILD_ROOT_DIR}/Makefile ]];
then
    echo "Creating build directory '${PLATFORM_BUILD_ROOT_DIR}'"
    mkdir -p ${PLATFORM_BUILD_ROOT_DIR}
    echo "Running CMake in '${PLATFORM_BUILD_ROOT_DIR}'"
    pushd ${PLATFORM_BUILD_ROOT_DIR}
    cmake -D CMAKE_BUILD_TYPE:STRING=${BUILD_TYPE} ../../../${PROJECT_NAME}
    popd
fi


# -----------------------
# --- Print some info ---
# -----------------------
echo "PLATFORM                  : '${PLATFORM}'"
echo "PLATFORM_TYPE             : '${PLATFORM_TYPE}'"
echo "REBUILD                   : '${REBUILD}'"
echo "BUILD_TYPE                : '${BUILD_TYPE}'"
echo "PLATFORM_BUILD_ROOT_DIR   : '${PLATFORM_BUILD_ROOT_DIR}'"

# exit 1; # FIXMENM

pushd ${PLATFORM_BUILD_ROOT_DIR}
echo "Building in: '${PLATFORM_BUILD_ROOT_DIR}'"
make -j
popd

if [ "y" == "${RUN_TESTS}" ]
then
    echo "Running tests ..."
    pushd ${PLATFORM_BUILD_ROOT_DIR}
    ctest
    popd
fi




