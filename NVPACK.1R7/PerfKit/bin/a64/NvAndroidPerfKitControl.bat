@echo off

SET INTENTS=
SET OPTIONS=

:CmdParseTop
  IF "%1"=="" GOTO CommandLineParsed
  IF "%1"=="--help" GOTO PrintHelp
  IF "%1"=="install" GOTO InstallApk
  IF "%1"=="uninstall" GOTO UnInstallApk
  IF "%1"=="inst" GOTO SetInst
  IF "%1"=="gpuclk" GOTO SetGpuClock
  IF "%1"=="-d" GOTO SetDevice
  IF "%1"=="-s" GOTO SetDevice
  GOTO CmdParseBottom

:PrintHelp
  ECHO Usage:   NvAndroidPerfKitControl [OPTIONS] [COMMANDS]
  ECHO          OPTIONS:
  ECHO          -d                      - directs command to the only connected USB device
  ECHO                                    returns an error if more than one USB device is present.
  ECHO          -s [specific device]    - directs command to the device or emulator with the given
  ECHO                                    serial number or qualifier. Overrides ANDROID_SERIAL
  ECHO                                    environment variable.
  ECHO          COMMANDS:
  ECHO          install                 - install NvPerfKitControl.apk
  ECHO          uninstall               - uninstall NvPerfKitControl.apk
  ECHO          inst=enable             - enable driver instrumentation
  ECHO          inst=disable            - disable driver instrumentation
  ECHO          gpuclk=restore          - restore the gpu clock to the power profiler default
  ECHO          gpuclk=sysmax           - set the gpu clock to the system max
  ECHO          gpuclk=promax           - set the gpu clock to the power profile max
  GOTO Exit

:InstallApk
  set OPTIONS=%OPTIONS% install NvPerfKitControlApk.apk
  GOTO CmdParseBottom

:UnInstallApk
  set OPTIONS=%OPTIONS% uninstall com.nvidia.NvPerfKitControl
  GOTO CmdParseBottom
 
:SetInst
  adb %OPTIONS% shell id | findstr /C:"uid=0" > nul
  IF %errorLevel% == 0 GOTO SetInstAsRoot

:SetInstAsNonRoot
  SHIFT
  IF "%1"=="enable"  (SET INTENTS=%INTENTS% --es inst enable
  ) ELSE IF "%1"=="disable" (SET INTENTS=%INTENTS% --es inst disable
  ) ELSE (GOTO PrintHelp)
  GOTO CmdParseBottom

:SetInstAsRoot
  SHIFT
  IF "%1"=="enable"  (SET OPTIONS=%OPTIONS% shell setprop persist.sys.tegra.74095214 1
  ) ELSE IF "%1"=="disable" (SET OPTIONS=%OPTIONS% shell setprop persist.sys.tegra.74095214 0
  ) ELSE (GOTO PrintHelp)
  GOTO CmdParseBottom

:SetGpuClock
  SHIFT
  IF "%1"=="restore"  (SET INTENTS=%INTENTS% --es gpuclk restore
  ) ELSE IF "%1"=="sysmax" (SET INTENTS=%INTENTS% --es gpuclk sysmax
  ) ELSE IF "%1"=="promax" (SET INTENTS=%INTENTS% --es gpuclk promax
  ) ELSE (GOTO PrintHelp)
  GOTO CmdParseBottom

:SetDevice
  SET OPTIONS=%OPTIONS% %1
  IF "%1"=="-s" (
  SET OPTIONS=%OPTIONS% %2
  SHIFT)
  GOTO CmdParseBottom
  
:CmdParseBottom
  SHIFT
  GOTO CmdParseTop

:CommandLineParsed
  IF NOT "%INTENTS%"=="" (GOTO SendApkIntents
  ) ELSE IF NOT "%OPTIONS%"=="" (adb %OPTIONS%
  ) ELSE (GOTO PrintHelp)
  GOTO Exit
  
:SendApkIntents
  adb %OPTIONS% shell am startservice -n com.nvidia.NvPerfKitControl/.NvPerfKitControlService %INTENTS%
  GOTO Exit
  
:Exit
