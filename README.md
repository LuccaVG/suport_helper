# suport_helper / Tech Support Quick Commands

Bilingual README (English / Português-BR) describing a Windows batch menu with 24 quick diagnostic/remediation actions.

## Overview / Visão geral

- Windows batch script with a numeric menu (1–24 + Q) for common support commands.
- Logs every executed command to `support-tool.log` in the script directory.
- Prompts for host inputs where needed (ping, tracert, pathping, nslookup).
- Includes safety prompts for long/elevated operations (SFC, DISM).
- Uses PowerShell for richer hardware inventory and hotfix listing.

## Usage / Como usar

1. Open Command Prompt (recommended: “Run as administrator” for SFC/DISM).  
   Abra o Prompt de Comando (recomendado: “Executar como administrador” para SFC/DISM).
2. Run the batch file from its folder; a menu will appear.  
   Execute o arquivo .bat na sua pasta; o menu será exibido.
3. Enter an option number (1–24) or `Q` to quit.  
   Digite o número da opção (1–24) ou `Q` para sair.
4. Outputs are displayed on screen; commands and timestamps are appended to `support-tool.log`.  
   Saídas aparecem na tela; comandos e horários são gravados em `support-tool.log`.

## Menu (English)

1) IP config (detailed) — `ipconfig /all`  
2) Flush DNS — `ipconfig /flushdns`  
3) Ping host — `ping -n 6 <host>`  
4) Tracert to host — `tracert <host>`  
5) DNS lookup — `nslookup <host>`  
6) Netstat active connections (all) — `netstat -ano`  
7) Netstat listening ports — `netstat -ano | findstr LISTENING`  
8) System info — `systeminfo`  
9) Hardware inventory (CIM) — PowerShell `Get-CimInstance ... | Format-List *`  
10) SFC scan — `sfc /scannow` (elevated)  
11) DISM restore health — `DISM /Online /Cleanup-Image /RestoreHealth` (elevated)  
12) Process tools — list (`tasklist`) or kill by PID (`taskkill /PID <pid> /F`)  
13) Driver list — `driverquery /v`  
14) Services (all) — `sc query type=service state=all`  
15) Route table — `route print`  
16) ARP cache — `arp -a`  
17) Pathping to host — `pathping <host>`  
18) Display DNS cache — `ipconfig /displaydns`  
19) Wi-Fi profiles — `netsh wlan show profiles`  
20) Wi-Fi drivers/capabilities — `netsh wlan show drivers`  
21) Firewall status (all profiles) — `netsh advfirewall show allprofiles`  
22) Network shares — `net share`  
23) Installed updates (hotfixes) — PowerShell `Get-HotFix | Sort-Object InstalledOn`  
24) Recent System event log (20 entries) — PowerShell `Get-EventLog -LogName System -Newest 20`  
Q) Quit

## Menu (Português-BR)

1) IP config (detalhado) — `ipconfig /all`  
2) Limpar DNS — `ipconfig /flushdns`  
3) Ping em host — `ping -n 6 <host>`  
4) Tracert para host — `tracert <host>`  
5) Consulta DNS — `nslookup <host>`  
6) Conexões ativas (netstat) — `netstat -ano`  
7) Portas em escuta — `netstat -ano | findstr LISTENING`  
8) Info do sistema — `systeminfo`  
9) Inventário de hardware (CIM) — PowerShell `Get-CimInstance ... | Format-List *`  
10) Verificação SFC — `sfc /scannow` (elevado)  
11) DISM restaurar imagem — `DISM /Online /Cleanup-Image /RestoreHealth` (elevado)  
12) Processos — listar (`tasklist`) ou matar por PID (`taskkill /PID <pid> /F`)  
13) Lista de drivers — `driverquery /v`  
14) Serviços (todos) — `sc query type=service state=all`  
15) Tabela de rotas — `route print`  
16) Cache ARP — `arp -a`  
17) Pathping para host — `pathping <host>`  
18) Exibir cache DNS — `ipconfig /displaydns`  
19) Perfis Wi-Fi — `netsh wlan show profiles`  
20) Drivers/capacidades Wi-Fi — `netsh wlan show drivers`  
21) Status do firewall (perfis) — `netsh advfirewall show allprofiles`  
22) Compartilhamentos de rede — `net share`  
23) Atualizações instaladas (hotfixes) — PowerShell `Get-HotFix | Sort-Object InstalledOn`  
24) Log de eventos do Sistema (20 mais recentes) — PowerShell `Get-EventLog -LogName System -Newest 20`  
Q) Sair

## Logging / Registro

- File: `support-tool.log` in the script directory.  
- Format: `[date time] <command>` per execution.

## Notes / Observações

- Some commands (SFC, DISM) require elevated Command Prompt.  
- Long-running tasks show a confirmation prompt.  
- Network tests prompt for hostnames/IPs where applicable.  
- PowerShell is invoked with `-NoProfile -ExecutionPolicy Bypass` for inventory and hotfix queries.

## Disclaimer / Aviso

Use at your own risk. Review commands before running in production environments.  
Use por sua conta e risco. Revise os comandos antes de usar em ambientes de produção.
