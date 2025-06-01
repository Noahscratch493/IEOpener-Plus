@echo off
echo === IE Opener+ ===
echo.

:: Set default values for flags and URL
set "extensions="
set "inprivate="
set "fullscreen="
set "noscript="
set "url=http://www.msn.com"

:: Prompt for user input on flags
echo Enter any of the following flags (separate by spaces):
echo --ExtOff    : Disable extensions
echo --NoHomePage: Disable homepage
echo --FullScreen: Open in fullscreen mode
echo --NoScript  : Disable JavaScript
echo.

:: Get the flags input from the user
set /p flags=Enter the flags you want to use (e.g., --ExtOff --NoScript --FullScreen): 
echo.

set "url=http://www.msn.com"

:: Prepare the VBScript based on flags
echo Set ie = CreateObject("InternetExplorer.Application") > temp.vbs
echo ie.Visible = True >> temp.vbs

:: Handle flags
for %%f in (%flags%) do (
    if /i "%%f"=="--ExtOff" (
        echo ie.Toolbar = False >> temp.vbs
        echo ie.Navigate "about:blank" >> temp.vbs
    )
    if /i "%%f"=="--NoHomePage" (
        echo ie.HomePage = "" >> temp.vbs
    )
    if /i "%%f"=="--FullScreen" (
        echo ie.FullScreen = True >> temp.vbs
    )
    if /i "%%f"=="--NoScript" (
        echo ie.Navigate "about:blank" >> temp.vbs
        echo 'Javascript is disabled in this mode' >> temp.vbs
    )
)

:: Navigate to the specified URL if no special flags for navigation are set
if not defined extensions (
    echo ie.Navigate "%url%" >> temp.vbs
)

:: Run the VBScript
cscript //nologo temp.vbs

:: Clean up
del temp.vbs
echo.
echo Internet Explorer should now be open with the specified flags.
pause
