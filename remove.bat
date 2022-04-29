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

:show_admin_control
	echo set prompt = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
  	echo prompt.ShellExecute "cmd.exe", "/c %~s0 %~1", "", "runas", 1 >> "%temp%\getadmin.vbs"

  	"%temp%\getadmin.vbs"
  	del "%temp%\getadmin.vbs"
exit /B 0

:main
	Powershell.exe -Executionpolicy bypass -File set-default.ps1
	build\setup.exe
exit /B 0
