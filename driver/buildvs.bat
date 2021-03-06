@ECHO OFF
SETLOCAL
REM Ensure the environment is set up
if not defined %INCLUDE% GOTO ERROR
REM Workaround to detect x64 or x86 environment
cl 1> NUL 2> tmp.txt
find /C "x64" < tmp.txt > tmp2.txt
SET /p IS64BIT= < tmp2.txt
del tmp.txt
del tmp2.txt
cl /Fevstmididrv.dll /O1 /MT /EHsc /D_WIN32_WINNT=0x0501 /D_USING_V110_SDK71_ /DUNICODE /D_UNICODE /LD /I "..\external_packages" /MP%NUMBER_OF_PROCESSORS% VSTDriver.cpp MidiSynth.cpp winmm_drv.cpp kernel32.lib user32.lib Shlwapi.lib advapi32.lib winmm.lib Ole32.lib uuid.lib vstmididrv.def
if ERRORLEVEL 1 goto END
REM Move files to the output dir
mkdir ..\output\64
if "%IS64BIT%" EQU "1" (
  move vstmididrv.dll ..\output\64
) else (
  move vstmididrv.dll ..\output\
)
goto END
:ERROR
echo.
echo This scripts needs to be run from a Visual studio command line 
echo (Check Visual Studio tools, Visual studio comand line in the programs menu)
:END
ENDLOCAL
