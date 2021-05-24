echo off
cls
rem ### Sample configuration.  Set your directories similarly from 1 thru however many drives you want.  Do not uses spaces.
rem set dir1=P:\Chia_Plots\
rem set dir2=U:\Chia_Plots\
rem set dir3=V:\Chia_Plots\
rem ### Configure below
set dir1=


rem ### Start program - no need to edit below this line.
Title Chia Plot Copy %CD% to multiple destinations.
echo Started multi directory Plot Copy.
setlocal enabledelayedexpansion
set var=1
:loop
FOR %%G IN (plot*.iso) DO (call :set %%G
set loopvar=!dir%var%!
if not defined dir%var% goto error
dir !loopvar! | find "bytes free" > %CD%\space%var%.tmp
set /p out%var%=<space%var%.tmp & set out%var%=!out%var%:~24! & set out%var%=!out%var%:bytes free=! & set out%var%=!out%var%: =! & set out%var%=!out%var%:,=! & del space%var%.tmp
call :increment !out%var%!
set destination=!loopvar!
)
if not defined plotname goto timer
if not %destination:~-1%==\ set destination=%destination%\
if defined increment (if not %increment%==larger set /a var=var+1 & goto loop)
echo %date% %time:~0,-3% Plot found: starting move
:start
set _time=%time: =0%
set _hh=%_time:~0,2%
if %_hh:~0,1% equ 0 set _hh=%_time:~1,1%
set _mm=%_time:~3,2%
if %_mm:~0,1% equ 0 set _mm=%_time:~4,1%
set _ss=%_time:~6,2%
if %_ss:~0,1% equ 0 set _ss=%_time:~7,1%
set /a strt=(%_hh%*3600)+(%_mm%*60)+%_ss%
:rename
REN %plotname% %plotname%.tmp
echo %time:~0,-3% %date% Renamed %plotname% to %plotname%.tmp >> plotcopylog.txt
MOVE %plotname%.tmp %destination% > nul
echo %time:~0,-3% %date% Moved %plotname%.tmp to %destination% >> plotcopylog.txt
REN %destination%%plotname%.tmp %plotname%
echo %time:~0,-3% %date% Renamed %destination%%plotname%.tmp to %plotname% >> plotcopylog.txt
:end
set _time2=%time: =0%
set _hh2=%_time2:~0,2%
if %_hh2:~0,1% equ 0 set _hh2=%_time2:~1,1%
set _mm2=%_time2:~3,2%
if %_mm2:~0,1% equ 0 set _mm2=%_time2:~4,1%
set _ss2=%_time2:~6,2%
if %_ss2:~0,1% equ 0 set _ss2=%_time2:~7,1%
set /a end=(%_hh2%*3600)+(%_mm2%*60)+%_ss2%
set strt=%strt%
set end=%end%
if %strt% gtr %end% set /a end=%end%+86400
set /a diff=%end%-%strt%
set /a hh=%diff/3600
set /a mm=%diff%/60
:reduce
if %mm% gtr 60 set /a mm=%mm%-60 & goto reduce
set /a ss=(%diff%-(%diff%/60*60))
set timess=
if %ss% gtr 0 set "timess= %ss% second"
if %ss% gtr 1 set "timess= %ss% seconds"
set timemm=
if %mm% gtr 0 if %mm% lss 60 set "timemm= %mm% minute"
if %mm% gtr 1 if %mm% lss 60 set "timemm= %mm% minutes"
set timehh=
if %hh% gtr 0 set "timehh= %hh% hour"
if %hh% gtr 1 set "timehh= %hh% hours"
if %hh% gtr 0 set "timed=%timehh%"
if %mm% gtr 0 set "timed=%timed%%timemm%"
if %ss% gtr 0 set "timed=%timed%%timess%"
:outputtaskcompletiontime
find /c "%date% Moved" plotcopylog.txt > copylog.tmp
for /f "delims=" %%x in (copylog.tmp) do set times=%%x
set times=%times:~28,4%
echo %date% %time:~0,-3% Plot moved in%timed%. %times% Plots moved today. & echo %time:~0,-3% %date% Plot moved in%timed%. %times% Plots moved today. >> plotcopylog.txt
del copylog.tmp
set var=1
set plotname=
set plotsize=
set increment=
goto loop
goto :eof
:error
echo Out of free space to move to.
pause
goto :eof
:set
set plotname=%1
set plotsize=%~z1
goto :eof
:increment
set ivar=%1
set ivar=%ivar:~0,-4%
set plotsize=%plotsize:~0,-4%
if %ivar% lss %plotsize% (set increment=smaller) else (set increment=larger)
goto :eof
:timer
timeout /t 60 /nobreak > nul
goto loop
goto :eof
endlocal
