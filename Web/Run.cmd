@echo off
mode con: cols=82 lines=32
color 0F
title MAK VS CODE JAVA INSTALLER
echo ----------------------------------------------------------------------------------
echo                           VS CODE AND JAVA INSTALLER
echo                                  Author: MAK 
echo ----------------------------------------------------------------------------------
echo.

set locationvs="C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\bin\code"
echo Just Press Yes.. Next Next Next.. Install.. Finish/Close When Prompted
echo.

@rem main function
if exist "C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\bin" (
	"%cd%\python\python.exe" "download-jdk.py"
	if %ERRORLEVEL% == 0 ( 
	color 0C
	echo Files not found
	echo ----------------------------------------------------------------------------------
	echo Press Enter To Exit 
	pause>NUl
	EXIT 
    )

	call :onlyjava	
	color 0E
	echo.
	echo Copy lines from the sample.txt to settings.json
	call %locationvs% -n -g sample.json "C:\Users\%USERNAME%\AppData\Roaming\Code\User\settings.json" 
	echo Press Enter Once Done Copying The Lines
	pause>NUL
	taskkill /f /im Code.exe>nul 2>&1
	
) else (
	"%cd%\python\python.exe" "download-VSjdk.py"
	if %ERRORLEVEL% == 0 ( 
	color 0C
	echo Files not found
	echo ----------------------------------------------------------------------------------
	echo Press Enter To Exit 
	pause>NUl
	EXIT 
    )
	call :firstinstallation	
)

call :test
color 0A
echo ----------------------------------------------------------------------------------
echo You Can Close This Now
pause>NUl
EXIT 

:onlyjava
	cd /d data
	echo Installing Java.. 
	start /W JavaCodingPack.exe
	taskkill /f /im Code.exe>nul 2>&1
	echo Installed Extensions
	exit /B 0

:firstinstallation
	cd /d data
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
	