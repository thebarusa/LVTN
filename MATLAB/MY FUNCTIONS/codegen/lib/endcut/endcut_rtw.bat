@echo off

set MATLAB=D:\Programs\MATLAB\R2019a

cd .

if "%1"=="" ("D:\Programs\MATLAB\R2019a\bin\win64\gmake"  -f endcut_rtw.mk all) else ("D:\Programs\MATLAB\R2019a\bin\win64\gmake"  -f endcut_rtw.mk %1)
@if errorlevel 1 goto error_exit

exit 0

:error_exit
echo The make command returned an error of %errorlevel%
exit 1
