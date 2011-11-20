@echo off

if Test%BUILD_ALT_DIR%==Test goto usage

::# /M 2 for multiple cores
set BUILD_CMD=build -bcwgZ -M2
set PWD=%~dp0

::# Set target platform type
set ARCH_DIR=%_BUILDARCH%
if /I Test%_BUILDARCH%==Testx86 set ARCH_DIR=i386

if EXIST Makefile ren Makefile Makefile.hide

copy .msvc\rufus_sources sources >NUL 2>&1
@echo on
%BUILD_CMD%
@echo off
if errorlevel 1 goto builderror
copy obj%BUILD_ALT_DIR%\%ARCH_DIR%\rufus.exe . >NUL 2>&1

if EXIST Makefile.hide ren Makefile.hide Makefile
if EXIST sources del sources >NUL 2>&1

goto done

:builderror
if EXIST Makefile.hide ren Makefile.hide Makefile
if EXIST sources del sources >NUL 2>&1
echo Build failed
goto done

:usage
echo wdk_build must be run in a Windows Driver Kit build environment
pause

:done
cd %PWD%