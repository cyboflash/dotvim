@echo off
REM Run this batch file from any directory to build ctags
REM But first edit the paths and Python version number.

REM --- Specify Vim /src folder ---
set CTAGS_SRC=C:\ctags58
REM --- Add MinGW /bin directory to PATH ---
PATH = C:\MinGW-w64\x86_64-6.2.0-posix-sjlj-rt_v5-rev1\mingw64\bin;%PATH%

REM get location of this batch file
set WORKDIR=%~dp0
set LOGFILE=%WORKDIR%log.txt

echo Work directory: %WORKDIR%
echo ctags source directory: %VIMSRC%

REM change to ctags /src folder
cd /d %CTAGS_SRC%

REM --- Build ctags ---
echo Building ctags.exe ...
mingw32-make.exe -f mk_mingw.mak ctags "%LOGFILE%" 2>&1

cd /d %WORKDIR%

pause
