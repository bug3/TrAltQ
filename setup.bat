@echo off

call :check_admin
exit /B %ERRORLEVEL%

:check_admin
  	fsutil dirty query %systemdrive% > nul
  	if %errorlevel% neq 0 (
    		call :show_admin_control
  	) else (
    		call :main
  	)
exit /B 0
