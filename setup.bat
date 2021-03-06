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
  	echo UAC.ShellExecute "cmd.exe", "/c %~s0 %*", "", "runas", 1 >> "%temp%\getadmin.vbs"

  	"%temp%\getadmin.vbs"
  	del "%temp%\getadmin.vbs"
exit /B

:main
	set argc=0

	cd %~dp0

	for %%x in (%*) do set /A argc+=1

	if %argc% equ 0 (
		goto install
	)

	if "%1" == "-r" (
		goto uninstall
	)
exit /B

:install
	Powershell.exe -Executionpolicy bypass -File save-input-methods.ps1
	build\setup.exe
	Powershell.exe -Executionpolicy bypass -File change-key-layout.ps1
exit /B

:uninstall
	Powershell.exe -Executionpolicy bypass -File set-default.ps1
	build\setup.exe
exit /B
