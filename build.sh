#!/bin/bash

PROJECT_NAME="embedded-template"
PROJECT_REPOSITORY_ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TOOLCHAINS_DIR="${PROJECT_REPOSITORY_ROOT_DIR}/tools/toolchains"
CONFIG_DIR="${PROJECT_REPOSITORY_ROOT_DIR}/tools/config"
PROJECT_PARENT_DIR="$( dirname "${PROJECT_REPOSITORY_ROOT_DIR}" )"
BUILD_ROOT_DIR="${PROJECT_PARENT_DIR}/_build"
PROJECT_BUILD_ROOT_DIR="${BUILD_ROOT_DIR}/${PROJECT_NAME}"

# Clang(tidy) commands MUST all be in PATH. The setup scripts must ensure this.
RUN_CLANG_TIDY_PY_CMD="run-clang-tidy.py"
CLANG_TIDY_CMD="clang-tidy"
### CLANG_TIDY_CHECKS="*,clang-analyzer-*"
CLANG_TIDY_CHECKS="$( cat "${CONFIG_DIR}/clangtidy-default-checks.cfg" )"


JOBS=""
REBUILD="n"
BUILD_TYPE="release"
RUN_TESTS="y"
VERBOSE="n"
SUGGEST_USAGE="n"
CREATE_DOXYGEN_DOCS="n"
PLATFORM="hostwindows"      # Default platform set to 'hostwindows'
HOST_PLATFORM="windows"     # Default host-platform set to 'windows'
COMPILER=""
CMAKE_GENERATOR="Unix Makefiles"

# -----------------------------
# --- Detect default system ---
# -----------------------------
if [ -f /etc/lsb-release ]; then
    RUN_CLANG_TIDY_PY_CMD="run-clang-tidy-12.py"
    CLANG_TIDY_CMD="clang-tidy-12"
    HOST_PLATFORM="linux"   # Default host-platform detected as 'linux'
    PLATFORM="hostlinux"    # Default platform detected as 'hostlinux'
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
# echo "PROJECT_PARENT_DIR                 : '${PROJECT_PARENT_DIR}'"
# echo "BUILD_ROOT_DIR           : '${BUILD_ROOT_DIR}'"
# echo "PROJECT_BUILD_ROOT_DIR        : '${PROJECT_BUILD_ROOT_DIR}'"

# -------------------------------------
# --- Parse command line parameters ---
# -------------------------------------
for i in $*
do
	case $i in
    	--doxygen=*)
		CREATE_DOXYGEN_DOCS=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
		;;
    	-p=*|--platform=*)
		PLATFORM=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
		;;
    	-r=*|--rebuild=*)
		REBUILD=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
		;;
    	-b=*|--buildtype=*)
		BUILD_TYPE=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
    	;;
    	--compiler=*)
		COMPILER=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
		;;
    	-t=*|--test=*)
		RUN_TESTS=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
    	;;
    	-v=*|--verbose=*)
		VERBOSE=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
    	;;
    	-h|--help)
		echo "Options:"
		echo "  --doxygen=[$CREATE_DOXYGEN_DOCS]"
		echo "    Set to 'y' to create Doxygen documentation. TODO: Not implemented yet!"
		echo " "
		echo "  -j=|--jobs=[$JOBS]"
		echo "    Number of parallel compiler jobs to use."
		echo " "
		echo "  -p=|--platform=[$PLATFORM]"
		echo "    Platform! Values: targetall, hostlinux, hostwindows, staticanalysis, radio2003, dsp7, web."
		echo " "
		echo "  -r=|--rebuild=[$REBUILD]"
		echo "    Rebuild all: Values 'y' OR 'n'."
		echo " "
		echo "  -b=|--buildtype=[$BUILD_TYPE]"
		echo "    'debug' or 'release' or 'debug' (release)."
		echo " "
		echo "  --compiler=[$COMPILER]"
		echo "    Leave this empty for default builds for the hostpc platform Linux uses 'gcc' and Windows uses 'msvc' as default. "
		echo "    For linux or windows hostpc builds you could build using clang by setting this to 'clang'. "
		echo " "
		echo "  -t=|--test=[$RUN_TESTS]"
		echo "    Run tests. Values 'y' or 'n'."
		echo " "
		echo "  -v=|--verbose=[$VERBOSE]"
		echo "    Show verbose (full) compiler commands."
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
if [[ "${PLATFORM}" == "hostlinux" || "${PLATFORM}" == "hostwindows" ]]; then
    PLATFORM_TYPE="hostpc"
elif [[ "${PLATFORM}" == "staticanalysis" ]]; then
    PLATFORM_TYPE="analysis"
fi

COMPILER_PATH=""
if [[ "" == "${COMPILER}" ]];
then
    # *** Handle default compilers fot each platform ***
    if      [[ "hostlinux"      == "${PLATFORM}" ]]; then COMPILER="gcc";
    elif    [[ "hostwindows"    == "${PLATFORM}" ]]; then COMPILER="gcc";
    elif    [[ "staticanalysis" == "${PLATFORM}" ]]; then COMPILER="clangtidy";
    fi
fi


COMPILER_PATH="${TOOLCHAINS_DIR}/${PLATFORM}.${COMPILER}.toolchain.cmake"
# The default compilers on each platform does NOT have a toolchain 
if [[   ("${PLATFORM}" == "hostlinux" && "${COMPILER}" == "gcc")    ||
        ("${PLATFORM}" == "hostwindows" && "${COMPILER}" == "gcc") 
    ]]; 
then
    COMPILER_PATH=""
fi

PLATFORM_BUILD_ROOT_DIR="${PROJECT_BUILD_ROOT_DIR}/${PLATFORM}.${COMPILER}"

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
    if [[ "" == "${COMPILER_PATH}" ]]; then
        echo "!CMAKE CMD: cmake -G \"${CMAKE_GENERATOR}\" -D CMAKE_BUILD_TYPE:STRING=${BUILD_TYPE} -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ../../../${PROJECT_NAME}"
        cmake -G "${CMAKE_GENERATOR}" -D CMAKE_BUILD_TYPE:STRING=${BUILD_TYPE} -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ../../../${PROJECT_NAME}
    else
        echo "CMAKE CMD: cmake -G \"${CMAKE_GENERATOR}\" -D CMAKE_TOOLCHAIN_FILE=${COMPILER_PATH} -D CMAKE_BUILD_TYPE:STRING=${BUILD_TYPE} -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ../../../${PROJECT_NAME}"
        cmake -G "${CMAKE_GENERATOR}" -D CMAKE_TOOLCHAIN_FILE=${COMPILER_PATH} -D CMAKE_BUILD_TYPE:STRING=${BUILD_TYPE} -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ../../../${PROJECT_NAME}
    fi
    popd
fi


# -----------------------
# --- Print some info ---
# -----------------------
echo "PLATFORM                      : '${PLATFORM}'"
echo "HOST_PLATFORM                 : '${HOST_PLATFORM}'"
echo "COMPILER                      : '${COMPILER}'"
echo "COMPILER_PATH                 : '${COMPILER_PATH}'"
echo "PLATFORM_TYPE                 : '${PLATFORM_TYPE}'"
echo "JOBS                          : '${JOBS}'"
echo "REBUILD                       : '${REBUILD}'"
echo "BUILD_TYPE                    : '${BUILD_TYPE}'"
echo "REBUILD                       : '${REBUILD}'"
echo "VERBOSE                       : '${VERBOSE}'"
echo "RUN_TESTS                     : '${RUN_TESTS}'"
echo "CREATE_DOXYGEN_DOCS           : '${CREATE_DOXYGEN_DOCS}'"
echo "PLATFORM_BUILD_ROOT_DIR       : '${PLATFORM_BUILD_ROOT_DIR}'"

VERBOSE_PREFIX=""
if [ "y" == "${VERBOSE}" ]
then
    VERBOSE_PREFIX="VERBOSE=1 "
    export ${VERBOSE_PREFIX}
fi

# exit 1; # FIXMENM

pushd ${PLATFORM_BUILD_ROOT_DIR}
if [[ "${PLATFORM}" == "staticanalysis" ]]; then
    echo "Running static analysis using '${COMPILER}' ..."
    if [[ "${COMPILER}" == "clangtidy" ]]; then
        echo "${RUN_CLANG_TIDY_PY_CMD} -p ${PLATFORM_BUILD_ROOT_DIR} -checks ${CLANG_TIDY_CHECKS}"
        ${RUN_CLANG_TIDY_PY_CMD} -p ${PLATFORM_BUILD_ROOT_DIR} -checks ${CLANG_TIDY_CHECKS}
    fi
else
    echo "Building in: '${PLATFORM_BUILD_ROOT_DIR}'"
    echo "${VERBOSE_PREFIX} make -j ${JOBS}"
    make -j ${JOBS}
fi
popd


if [[ "y" == "${RUN_TESTS}" && "${PLATFORM_TYPE}" == "hostpc" ]]; then
    echo "Running tests ..."
    pushd ${PLATFORM_BUILD_ROOT_DIR}
    ctest
    popd
fi

if [ "y" == "${CREATE_DOXYGEN_DOCS}" ]
then
    echo "Creating Doxygen documentation ..."
    pushd ${PLATFORM_BUILD_ROOT_DIR}
    # doxygen
    popd
fi

echo "PLATFORM_BUILD_ROOT_DIR: '${PLATFORM_BUILD_ROOT_DIR}'"
echo "compile_commands.json: ${PLATFORM_BUILD_ROOT_DIR}/compile_commands.json"


