@echo off

set /p choice="Enter Program Number (1: Hackerone,2: BugCrowd, 3: Intigriti, 4: OpenBugBounty ,5: Synack, 6: Yeswehack,7: Vulnerable_apps): "
set /p "dirname=Enter Program name: "
if "%choice%"=="1" (
		call :Createprogramfile "C:\Users\vicky\OneDrive\Desktop\App_Sec\Bug_Bounty_Platform\Hackerone\" "%dirname%"
    goto :end
) else if "%choice%"=="2" (
		call :Createprogramfile "C:\Users\vicky\OneDrive\Desktop\App_Sec\Bug_Bounty_Platform\BugCrowd\" "%dirname%"
    goto :end
) else if "%choice%"=="3" (
		call :Createprogramfile "C:\Users\vicky\OneDrive\Desktop\App_Sec\Bug_Bounty_Platform\Intigriti\" "%dirname%"
    goto :end
) else if "%choice%"=="4" (
		call :Createprogramfile "C:\Users\vicky\OneDrive\Desktop\App_Sec\Bug_Bounty_Platform\OpenBugBounty\" "%dirname%"
    goto :end
) else if "%choice%"=="5" (
		call :Createprogramfile "C:\Users\vicky\OneDrive\Desktop\App_Sec\Bug_Bounty_Platform\Synack\" "%dirname%"
    goto :end
) else if "%choice%"=="6" (
		call :Createprogramfile "C:\Users\vicky\OneDrive\Desktop\App_Sec\Bug_Bounty_Platform\Yeswehack\" "%dirname%"
    goto :end
)else if "%choice%"=="7" (
		call :Createprogramfile "C:\Users\vicky\OneDrive\Desktop\App_Sec\Vulnerable_apps\" "%dirname%"
    goto :end
) else (
    echo Select Program of choice care fully. 
)
:end
exit /b %ERRORLEVEL%
pause
rem Function definition
:Createprogramfile
	setlocal
	set "Program_path=%1"
	set "directory=%2"
	if exist "%Program_path%%directory%" (
		echo Program already exists.
	) else (
		mkdir "%Program_path%%directory%"
		mkdir "%Program_path%%directory%"\Payload_Test_data"
		mkdir "%Program_path%%directory%"\PoC"
		mkdir "%Program_path%%directory%"\Reports"
		mkdir "%Program_path%%directory%"\Scan"
		type nul > "%Program_path%%directory%"\1_Target_deatils.txt
		type nul > "%Program_path%%directory%"\2_Rules_of_engagement.txt
		type nul > "%Program_path%%directory%"\3_Module_Feature_Audit_status.txt
		type nul > "%Program_path%%directory%"\4_Behavior_Observation.txt
		type nul > "%Program_path%%directory%"\5_Findings.txt
	)
	endlocal
goto :eof
exit /b 0
