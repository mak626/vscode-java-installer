@echo off
mode con: cols=82 lines=32
color 0F
setlocal enabledelayedexpansion
title MAK VS CODE JAVA WEB INSTALLER
echo ----------------------------------------------------------------------------------
echo                         VS CODE AND JAVA WEB INSTALLER
echo                                  Author: MAK 
echo ----------------------------------------------------------------------------------
echo.
set locationvs="C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\bin\code"

@rem main function
if exist "C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\bin" (
	"%cd%\python\python.exe" "download.py" "java" 
	if !errorlevel! EQU 1 ( 
	call :filenotfound
	EXIT 
    )
	cd /d data
	call :startmessage
	call :onlyjava	
	
) else (
	"%cd%\python\python.exe" "download.py" "vs" 
	if !errorlevel! EQU 1 ( 
	call :filenotfound
	EXIT 
    )
	cd /d data
	call :startmessage
	call :firstinstallation	
)

color 0E
call :test
color 0A
echo ----------------------------------------------------------------------------------
echo You Can Close This After Testing
pause>NUl
EXIT 

:onlyjava
	echo Installing Adobe Open JDK 11..
	start /W JDK.msi
	echo Installing Java and Extension Pack..
	start /W JavaCodingPack.exe
	taskkill /f /im Code.exe>nul 2>&1
	exit /B 0

:firstinstallation
	echo Installing VS CODE..
	start /W VS.exe
	taskkill /f /im Code.exe>nul 2>&1
	call :onlyjava
	exit /B 0

:test
	echo.
	echo Test VS Code By Running The test.java Program
	echo Press Enter To open test.java in VS Code for testing
	pause>NUL
	call %locationvs% -n -g Test.java
	echo.
	exit /B 0
	
:startmessage
	echo.
	echo.
	echo Just Press Yes/Run .. Next Next Next.. Install.. Finish/Close When Prompted
	color 0E
	echo.
	echo Press Enter To Start Installing..
	pause>NUL
	color 0F
	echo.
	exit /B 0

:filenotfound
	color 0C
	echo Files not found 
	echo Try this installer once again when you have a stable net connection
	echo ----------------------------------------------------------------------------------
	echo Press Enter To Exit 
	pause>NUl
	exit /B 0