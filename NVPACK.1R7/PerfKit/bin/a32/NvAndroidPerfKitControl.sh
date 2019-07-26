#!/bin/bash

INTENTS=
OPTIONS=

adbpath=`which adb`

function PrintHelp()
{
  echo "Usage:   NvAndroidPerfKitControl [OPTIONS] [COMMANDS]"
  echo "         OPTIONS:"
  echo "         -d                      - directs command to the only connected USB device"
  echo "                                   returns an error if more than one USB device is present."
  echo "         -s [specific device]    - directs command to the device or emulator with the given"
  echo "                                   serial number or qualifier. Overrides ANDROID_SERIAL"
  echo "                                   environment variable."
  echo "         COMMANDS:"
  echo "         install                 - install NvPerfKitControl.apk"
  echo "         uninstall               - uninstall NvPerfKitControl.apk"
  echo "         inst=enable             - enable driver instrumentation"
  echo "         inst=disable            - disable driver instrumentation"
  echo "         gpuclk=restore          - restore the gpu clock to the power profiler default"
  echo "         gpuclk=sysmax           - set the gpu clock to the system max"
  echo "         gpuclk=promax           - set the gpu clock to the power profile max"
  exit 1
}

function InstallApk()
{
    OPTIONS=${OPTIONS}" install NvPerfKitControlApk.apk"
}

function UninstallApk()
{
    OPTIONS=${OPTIONS}" uninstall com.nvidia.NvPerfKitControl"
}

function SetInst()
{
    COUNT=`adb $OPTIONS shell id | grep -c uid=0`
    if [ "$COUNT" == "1" ]; then
        SetInstAsRoot "$1"
    else
        SetInstAsNonRoot "$1"
    fi
}

function SetInstAsRoot()
{
    local state=$1
    case ${state} in
    "enable")
        OPTIONS=$OPTIONS" shell setprop persist.sys.tegra.74095214 1"
        ;;
    "disable")
        OPTIONS=$OPTIONS" shell setprop persist.sys.tegra.74095214 0"
        ;;
    *)
        ;;
    esac
}

function SetInstAsNonRoot()
{
    local state=$1
    case ${state} in
    "enable")
        tmp=" --es inst enable "
        INTENTS=${INTENTS}${tmp}
        ;;
    "disable")
        tmp=" --es inst disable "
        INTENTS=${INTENTS}${tmp}
        ;;
    *)
        ;;
    esac
}

function SetGpuClock()
{
    local state=$1
    case ${state} in
    "restore")
        tmp=" --es gpuclk restore "
        INTENTS=${INTENTS}${tmp}
        ;;
    "sysmax")
        tmp=" --es gpuclk sysmax "
        INTENTS=${INTENTS}${tmp}
        ;;
    "promax")
        tmp=" --es gpuclk promax "
        INTENTS=${INTENTS}${tmp}
        ;;
    *)
        ;;
    esac
}

function SendApkIntents()
{
    $adbpath $OPTIONS shell am startservice -n com.nvidia.NvPerfKitControl/.NvPerfKitControlService $INTENTS
}

function SetDevice()
{
    space=" "
    OPTIONS=${OPTIONS}${space}$1
    if [ "$1" == "-s" ]; then 
        OPTIONS=${OPTIONS}${space}$2
    fi
}

function func_parse()
{
    while [[ $# > 0 ]]
    do
        token=$1
        shift

        case $token in
            "--help")
            PrintHelp
            ;;
            "install")
            InstallApk
            ;;
            "uninstall")
            UninstallApk
            ;;
            "inst=enable")
            SetInst "enable"
            ;;
            "inst=disable")
            SetInst "disable"
            ;;
            "gpuclk=restore")
            SetGpuClock "restore"
            ;;
            "gpuclk=sysmax")
            SetGpuClock "sysmax"
            ;;
            "gpuclk=promax")
            SetGpuClock "promax"
            ;;
            "-d")
            SetDevice "-d"
            ;;
            "-s")
            SetDevice "-s" "$1"
            shift
            ;;
            *)
            ;;
        esac
    done

    if [[ -n $INTENTS ]]; then SendApkIntents
    elif [[ -n $OPTIONS ]]; then $adbpath $OPTIONS
    fi
}

mainfn()
{
    if [[ $# < 1 ]]; then PrintHelp 
    fi
    func_parse $@
}

mainfn "$@"
