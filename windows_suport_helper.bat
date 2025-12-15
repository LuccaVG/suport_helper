@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ---------------------------------------------------------
:: Tech Support Quick Commands (numeric menu 1-24)
:: ---------------------------------------------------------
set "LOG=%~dp0support-tool.log"

:menu
cls
echo ================================
echo   Tech Support Quick Commands
echo ================================
echo  1) IP config (detailed)
echo  2) Flush DNS
echo  3) Ping host
echo  4) Tracert to host
echo  5) DNS lookup (nslookup)
echo  6) Netstat active connections (all)
echo  7) Netstat listening ports
echo  8) System info
echo  9) Hardware inventory (CIM)
echo 10) SFC scan (may take time)
echo 11) DISM restore health (may take time)
echo 12) Process tools (list or kill)
echo 13) Driver list
echo 14) Services (all)
echo 15) Route table
echo 16) ARP cache
echo 17) Pathping to host
echo 18) Display DNS cache
echo 19) Wi-Fi profiles
echo 20) Wi-Fi drivers/capabilities
echo 21) Firewall status (all profiles)
echo 22) Network shares
echo 23) Installed updates (hotfixes)
echo 24) Recent System event log (20 entries)
echo  Q) Quit
echo.

set /p "opt=Select (1-24 or Q): "
if /i "%opt%"=="Q" goto quit

if "%opt%"=="1"  goto ipconfig
if "%opt%"=="2"  goto flushdns
if "%opt%"=="3"  goto ping_host
if "%opt%"=="4"  goto tracert_host
if "%opt%"=="5"  goto dnslookup
if "%opt%"=="6"  goto netstat_all
if "%opt%"=="7"  goto netstat_listen
if "%opt%"=="8"  goto sysinfo
if "%opt%"=="9"  goto hwinfo
if "%opt%"=="10" goto sfc
if "%opt%"=="11" goto dism
if "%opt%"=="12" goto process_tools
if "%opt%"=="13" goto driverlist
if "%opt%"=="14" goto services_all
if "%opt%"=="15" goto route_table
if "%opt%"=="16" goto arp_cache
if "%opt%"=="17" goto pathping_host
if "%opt%"=="18" goto displaydns
if "%opt%"=="19" goto wifi_profiles
if "%opt%"=="20" goto wifi_drivers
if "%opt%"=="21" goto fw_status
if "%opt%"=="22" goto net_shares
if "%opt%"=="23" goto hotfixes
if "%opt%"=="24" goto eventlog_recent

echo Invalid choice. Press any key...
pause >nul
goto menu

:logrun
:: %* = command executed
echo [%date% %time%] %*>>"%LOG%"
goto :eof

:ipconfig
call :logrun ipconfig /all
ipconfig /all
pause
goto menu

:flushdns
call :logrun ipconfig /flushdns
ipconfig /flushdns
pause
goto menu

:ping_host
set /p "host=Host/IP to ping: "
if not defined host goto menu
call :logrun ping -n 6 "%host%"
ping -n 6 "%host%"
pause
goto menu

:tracert_host
set /p "host=Host/IP to tracert: "
if not defined host goto menu
call :logrun tracert "%host%"
tracert "%host%"
pause
goto menu

:dnslookup
set /p "host=Hostname to query (blank=example.com): "
if not defined host set "host=example.com"
call :logrun nslookup "%host%"
nslookup "%host%"
pause
goto menu

:netstat_all
call :logrun netstat -ano
netstat -ano
pause
goto menu

:netstat_listen
call :logrun netstat -ano ^| findstr LISTENING
netstat -ano | findstr LISTENING
pause
goto menu

:sysinfo
call :logrun systeminfo
systeminfo
pause
goto menu

:hwinfo
echo Collecting hardware inventory (may take a moment)...
call :logrun powershell -NoProfile -ExecutionPolicy Bypass -Command "$classes = 'Win32_ComputerSystem','Win32_Processor','Win32_PhysicalMemory','Win32_DiskDrive','Win32_VideoController','Win32_NetworkAdapterConfiguration'; foreach ($c in $classes) { Write-Host ('=== ' + $c + ' ==='); Get-CimInstance -ClassName $c -ErrorAction SilentlyContinue ^| Format-List * }"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$classes = 'Win32_ComputerSystem','Win32_Processor','Win32_PhysicalMemory','Win32_DiskDrive','Win32_VideoController','Win32_NetworkAdapterConfiguration'; foreach ($c in $classes) { Write-Host ('=== ' + $c + ' ==='); Get-CimInstance -ClassName $c -ErrorAction SilentlyContinue | Format-List * }"
pause
goto menu

:sfc
echo This requires elevated CMD. Continue?
choice /c YN /n /m "[Y/N]: "
if errorlevel 2 goto menu
call :logrun sfc /scannow
sfc /scannow
pause
goto menu

:dism
echo DISM /RestoreHealth may take several minutes. Continue?
choice /c YN /n /m "[Y/N]: "
if errorlevel 2 goto menu
call :logrun DISM /Online /Cleanup-Image /RestoreHealth
DISM /Online /Cleanup-Image /RestoreHealth
pause
goto menu

:process_tools
echo.
echo [1] List processes
echo [2] Kill process by PID
set /p "popt=Select (1-2, other=back): "
if "%popt%"=="1" (
  call :logrun tasklist
  tasklist
  pause
  goto menu
)
if "%popt%"=="2" (
  set /p "pid=PID to kill: "
  if not defined pid goto menu
  call :logrun taskkill /PID %pid% /F
  taskkill /PID %pid% /F
  pause
  goto menu
)
goto menu

:driverlist
call :logrun driverquery /v
driverquery /v
pause
goto menu

:services_all
call :logrun sc query type^=service state^=all
sc query type=service state=all
pause
goto menu

:route_table
call :logrun route print
route print
pause
goto menu

:arp_cache
call :logrun arp -a
arp -a
pause
goto menu

:pathping_host
set /p "host=Host/IP to pathping: "
if not defined host goto menu
call :logrun pathping "%host%"
pathping "%host%"
pause
goto menu

:displaydns
call :logrun ipconfig /displaydns
ipconfig /displaydns
pause
goto menu

:wifi_profiles
call :logrun netsh wlan show profiles
netsh wlan show profiles
pause
goto menu

:wifi_drivers
call :logrun netsh wlan show drivers
netsh wlan show drivers
pause
goto menu

:fw_status
call :logrun netsh advfirewall show allprofiles
netsh advfirewall show allprofiles
pause
goto menu

:net_shares
call :logrun net share
net share
pause
goto menu

:hotfixes
call :logrun powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-HotFix ^| Sort-Object -Property InstalledOn"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-HotFix | Sort-Object -Property InstalledOn"
pause
goto menu

:eventlog_recent
call :logrun powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-EventLog -LogName System -Newest 20"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-EventLog -LogName System -Newest 20"
pause
goto menu

:quit
echo Log saved to: "%LOG%"
endlocal
exit /b 0
