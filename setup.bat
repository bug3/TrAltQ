@echo off

goto check_admin

:check_admin
  	fsutil dirty query %systemdrive% > nul
  	if %errorlevel% neq 0 (
    		goto show_admin_control
  	) else (
    		goto main
  	)
exit /B

:show_admin_control
	echo set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
  	echo UAC.ShellExecute "cmd.exe", "/c %~s0 %~1", "", "runas", 1 >> "%temp%\getadmin.vbs"

  	"%temp%\getadmin.vbs"
  	del "%temp%\getadmin.vbs"
exit /B

:main
	cd %~dp0

	Powershell.exe -Executionpolicy bypass -File save-input-methods.ps1
	build\setup.exe
	Powershell.exe -Executionpolicy bypass -File change-key-layout.ps1
exit /B
