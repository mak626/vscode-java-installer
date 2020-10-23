@echo off
mode con: cols=82 lines=32
color 0F
title MAK VS CODE JAVA INSTALLER
echo ----------------------------------------------------------------------------------
echo                         VS CODE AND JAVA(x64) INSTALLER
echo                                  Author: MAK 
echo ----------------------------------------------------------------------------------
echo.
@rem Check OS archictecture
if not exist "C:\Program Files (x86)" ( 
	color 0C
	echo Sorry This Is Only For 64bit PC
	echo ----------------------------------------------------------------------------------
	echo Press Enter To Exit 
	pause>NUl
	exit 
)

cd /d data
set locationvs="C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\bin\code"
echo Just Press Yes.. Next Next Next.. Install.. Finish/Close When Prompted
echo.
echo Press Enter To Start Installing..
pause>NUL
@rem main function
if exist "C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\bin" (
	call :onlyjava	
	color 0E
	echo.
	echo Copy lines from the sample.json to settings.json
	call %locationvs% -n -g sample.json "C:\Users\%USERNAME%\AppData\Roaming\Code\User\settings.json" 
	echo Press Enter Once Done Copying The Lines
	pause>NUL
	taskkill /f /im Code.exe>nul 2>&1
	
) else (
	call :firstinstallation	
)

call :test
color 0A
echo ----------------------------------------------------------------------------------
echo You Can Close This Now
pause>NUl
exit 

:onlyjava
	echo Installing Java JDK 11.. 
	start /W jdk-11.0.8_windows-x64.exe
	echo Installing Java Extension Pack.. 
	start /W JavaCodingPack.exe
	taskkill /f /im Code.exe>nul 2>&1
	echo Installed Extensions
	exit /B 0

:firstinstallation
	echo Installing VS CODE..
	start /W VS.exe
	taskkill /f /im Code.exe>nul 2>&1
	xcopy "%cd%/Code" %appdata% /e /y /q /i>NUL
	echo Configurations Set
	call :onlyjava
	exit /B 0

:test
	echo.
	echo Test VS Code By Running The test.java Program
	call %locationvs% -n -g Test.java
	echo.
	exit /B 0
	