@echo off
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process cmd -ArgumentList '/c \"%~f0\"' -Verb RunAs"
    exit /b
)
chcp 65001
title mind blowing
color 2

:start
CLS
type "%~dp0banner.txt"
echo (1) C.C stopper
echo (2) C.C remover (WARNING: IT department DOESNT like this.)
echo (3) Exit
set /p input=.%BS%
if /I %input% EQU 1 goto :stopper
if /I %input% EQU 2 goto :remover
if /I %input% EQU 3 goto :exit

CLS
goto start

:stopper
CLS
set keywords=CIC Classroom.Cloud classroom.cloud student Netsupport NetSupport netsupport
type "%~dp0banner.txt"
echo Killing processes matching: %keywords%
for %%K in (%keywords%) do (
    for /f "tokens=1" %%P in ('tasklist /FI "IMAGENAME ne cmd.exe" /NH ^| findstr /I %%K') do (
        echo Terminating process: %%P
        taskkill /F /IM %%P >nul 2>&1
    )
)


echo Done.
pause
CLS
goto start

:remover
CLS
type "%~dp0banner.txt"
echo Are you sure you want to do this? (y)es / (n)o
set /p input=.%BS%
if /I %input% EQU y goto :r1
if /I %input% EQU yes goto :r1
if /I %input% EQU n goto start
if /I %input% EQU no goto start

goto remover

:r1
CLS
type "%~dp0banner.txt"
echo are you really sure? (WARNING: IT department DOESNT like this.) YES / (n)o 
set /p input=.%BS%
if /I %input% EQU YES goto :r2
if /I %input% EQU no goto start
if /I %input% EQU n goto start

goto r1

:r2
CLS
set keywords=CIC Classroom.Cloud classroom.cloud student Netsupport NetSupport netsupport
type "%~dp0banner.txt"
for %%K in (%keywords%) do (
    for /f "tokens=1" %%P in ('tasklist /FI "IMAGENAME ne cmd.exe" /NH ^| findstr /I %%K') do (
        echo Terminating: %%P
        taskkill /F /IM %%P >nul 2>&1
    )
)

IF EXIST "C:\Program Files (x86)\NetSupport" (
    ECHO Deleting Classroom Cloud
    RMDIR /S /Q "C:\Program Files (x86)\NetSupport"
    echo Classroom Cloud deleted
    pause
    goto start
) ELSE (
    ECHO Classroom Cloud not detected on this system.
    pause
    goto start
)



:exit
CLS
exit

