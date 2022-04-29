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
	cd %~dp0

	Powershell.exe -Executionpolicy bypass -File save-input-methods.ps1
	build\setup.exe
	Powershell.exe -Executionpolicy bypass -File change-key-layout.ps1
exit /B 0
