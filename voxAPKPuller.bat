@echo off
REM Author: Tyler L. Jones;
REM Script Function: Remove the monotony of pulling .APK files from a mobile device, with ADB.
REM This script assumes you already have Android Debugger Bridge installed on your system.
REM Make sure to run as administrator.
	
echo Changing working directory to platform-tools installation location.
echo.
REM Change the working directory to the ADB installation directory.
REM You may need to change the line below, to the exact installation path of your platform tools.
cd C:\Program Files (x86)\Android\android-sdk\platform-tools
echo You are now here:
cd
echo.
REM Initiate ADB - if it isn't already - and list connected devices.
echo Listing attached devices (ADB).
echo.
adb devices
REM Redirects the ADB list packages command to a .txt file, located on c:\
echo Invoking ADB's list packages function, and redirecting output.
echo File will be located at c:\, and be called packageList.txt
adb shell pm list packages > c:\packageList.txt
echo.
echo Search packageList.txt for the package you want to pull.
echo.
echo Enter the package name now:
REM Waits for user input, in form of package name from packageList.txt
set /p packageName=Package Name: 
echo.
echo Finding path to the package, on your device.
echo.
echo Your package: %packageName%
REM Stores the output from the "adb shell pm path" command to variable called packagePath 
echo Path to Package:
FOR /F "tokens=* USEBACKQ" %%F IN (`adb shell pm path %packageName%`) DO (
SET packagePath=%%F
)
echo %packagePath%
REM Slices off "package:" so the adb pull command works properly, when pulling the package path.
set packagePath=%packagePath:~8,300%
echo.
adb pull %packagePath% c:\
echo Your .apk file is now located at c:\
echo.
echo Deleting the packageList.txt file.
del c:\packageList.txt
pause
REM Enjoy.
