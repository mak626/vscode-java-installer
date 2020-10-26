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
echo Just Press Yes/Run .. Next Next Next.. Install.. Finish/Close When Prompted
echo.
color 0E
echo Press Enter To Start Installing..
pause>NUL
color 0F
@rem main function
if exist "C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\bin" (
	call :onlyjava	
) else (
	call :firstinstallation	
)

color 0E
call :test
color 0A
echo ----------------------------------------------------------------------------------
echo echo You Can Close This After Testing
pause>NUl
exit 

:onlyjava
	echo Installing Adobe Open JDK 11.. 
	start /W OpenJDK11U-jdk_x64.msi
	echo Installing Java Extension Pack.. 
	start /W JavaCodingPack.exe
	taskkill /f /im Code.exe>nul 2>&1
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
	echo Press Enter To open test.java in VS Code for testing
	pause>NUL
	call %locationvs% -n -g Test.java
	echo.
	exit /B 0
	