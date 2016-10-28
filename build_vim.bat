@echo off
REM Run this batch file from any directory to build gvim.exe and vim.exe.
REM But first edit the paths and Python version number.

REM --- Specify Vim /src folder ---
set VIMSRC=C:\Users\rshafigulin\Downloads\vim\src
REM --- Add MinGW /bin directory to PATH ---
PATH = C:\MinGW-w64\x86_64-6.2.0-posix-sjlj-rt_v5-rev1\mingw64\bin;%PATH%
REM --- Also make sure that PYTHON, PYTHON_VER below are correct. ---

REM get location of this batch file
set WORKDIR=%~dp0
set LOGFILE=%WORKDIR%log.txt
set ARCH=x86-64

echo Work directory: %WORKDIR%
echo Vim source directory: %VIMSRC%

REM change to Vim /src folder
cd /d %VIMSRC%

REM --- Build GUI version (gvim.exe) ---
echo Building gvim.exe ...
REM The following command will compile with both Python 2.7 and Python 3.3
mingw32-make.exe -f Make_ming.mak ^
  PYTHON="C:\Python27" ^
  PYTHON_VER=27 ^
  DYNAMIC_PYTHON=yes ^
  PYTHON3="C:\Python35"^
  PYTHON3_VER=35 ^
  DYNAMIC_PYTHON3=yes ^
  FEATURES=HUGE ^
  GUI=yes ^
  ARCH=%ARCH% ^
  gvim.exe "%LOGFILE%" 2>&1

REM --- Build console version (vim.exe) ---
echo Building vim.exe ...
REM The following command will compile with both Python 2.7 and Python 3.3
mingw32-make.exe -f Make_ming.mak ^
  PYTHON="C:\Python27" ^
  PYTHON_VER=27 ^
  DYNAMIC_PYTHON=yes ^
  PYTHON3="C:\Python35" ^
  PYTHON3_VER=35 ^
  DYNAMIC_PYTHON3=yes ^
  FEATURES=HUGE ^
  GUI=no ^
  ARCH=%ARCH% ^
  vim.exe >> "%LOGFILE%" 2>&1

echo Moving files ...
move gvim.exe "%WORKDIR%"
move vim.exe "%WORKDIR%"

echo Cleaning Vim source directory ...
REM NOTE: "mingw32-make.exe -f Make_ming.mak clean" does not finish the job
IF NOT %CD%==%VIMSRC% GOTO THEEND
IF NOT EXIST vim.h GOTO THEEND
IF EXIST pathdef.c DEL pathdef.c
IF EXIST obj\NUL      RMDIR /S /Q obj
IF EXIST obj%ARCH%\NUL  RMDIR /S /Q obj%ARCH%
IF EXIST gobj\NUL     RMDIR /S /Q gobj
IF EXIST gobj%ARCH%\NUL RMDIR /S /Q gobj%ARCH%
IF EXIST gvim.exe DEL gvim.exe
IF EXIST vim.exe  DEL vim.exe
:THEEND

cd /d %WORKDIR%

pause
