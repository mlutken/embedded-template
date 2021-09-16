set (CMAKE_SYSTEM_NAME      Radio       )
set (CMAKE_SYSTEM_VERSION   1           )
set (CMAKE_CROSSCOMPILING   TRUE        )

set (PLATFORM               radio       )
set (PLATFORM_COMPILER      keil        )
set (PLATFORM_TYPE          embedded    )

if (EXISTS "c:/Keil_v5/ARM/ARMCC/bin")
    message("AAAAAAA: c:/Keil_v5/ARM/ARMCC/bin")
    set (RADIO_PREFIX "c:/Keil_v5/ARM/ARMCC/bin")
elseif (EXISTS "/c/Keil_v5/ARM/ARMCC/bin")
    message("BBBBBB: /c/Keil_v5/ARM/ARMCC/bin")
    set (RADIO_PREFIX "/c/Keil_v5/ARM/ARMCC/bin")
endif()


set (RADIO_SUFFIX ".exe")

set (CMAKE_C_COMPILER "${RADIO_PREFIX}/armcc${RADIO_SUFFIX}")
set (CMAKE_CXX_COMPILER "${RADIO_PREFIX}/armcc${RADIO_SUFFIX}")
set (CMAKE_AR "${RADIO_PREFIX}/armar${RADIO_SUFFIX}" CACHE PATH "Path to Emscripten ar")
set (CMAKE_RANLIB "${RADIO_PREFIX}/armlink${RADIO_SUFFIX}" CACHE PATH "Path to Emscripten ranlib")

set (CMAKE_C_FLAGS "--cpu=Cortex-M0" CACHE STRING "" FORCE )
set (CMAKE_CXX_FLAGS "--cpu=Cortex-M0" CACHE STRING "" FORCE )


set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)


# --cpu=Cortex-M0 