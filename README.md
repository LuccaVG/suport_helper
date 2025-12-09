# suport_helper / Tech Support Quick Commands

Bilingual README (English / Português-BR) documenting Windows Batch and Unix Shell menus with quick diagnostic/remediation actions.

Repo languages: Shell (~54.3%), Batchfile (~45.7%).  
Este repositório contém versões em Shell (~54,3%) e Batch (~45,7%).

---

## Overview / Visão geral

- Cross-platform support:
  - Windows: Batch script with numeric menu (1–24 + Q) for common support commands.
  - Linux/macOS: Shell script with numeric menu (1–24 + Q) offering equivalent diagnostics.
- Logging:
  - Windows: logs every executed command to `support-tool.log` in the script directory.
  - Unix: logs to `support-tool.log` (same directory) using `tee`/redirections.
- Interactive prompts:
  - Host inputs where needed (ping, traceroute/tracert, pathping, nslookup/dig).
  - Safety prompts for long/elevated operations (SFC/DISM on Windows; integrity checks on Unix).
- PowerShell on Windows for richer hardware inventory and hotfix/event listing.
- Cross-platform alternatives for hardware and updates on Unix (lshw, lspci, lsusb, dmidecode, journalctl, system_profiler).

---

## Usage / Como usar

### Windows (Batch)
1. Open Command Prompt (recommended: “Run as administrator” for SFC/DISM).  
   Abra o Prompt de Comando (recomendado: “Executar como administrador” para SFC/DISM).
2. Run the `.bat` file from its folder; a menu will appear.  
   Execute o arquivo `.bat` na sua pasta; o menu será exibido.
3. Enter an option number (1–24) or `Q` to quit.  
   Digite o número da opção (1–24) ou `Q` para sair.
4. Outputs are displayed on screen; commands and timestamps are appended to `support-tool.log`.  
   Saídas aparecem na tela; comandos e horários são gravados em `support-tool.log`.

### Linux/macOS (Shell)
1. Open Terminal. For operations that need elevated privileges, use `sudo` when prompted.  
   Abra o Terminal. Para operações que exigem privilégios elevados, use `sudo` quando solicitado.
2. Make the script executable: `chmod +x support_helper.sh`.  
   Torne o script executável: `chmod +x support_helper.sh`.
3. Run the script: `./support_helper.sh`.  
   Execute o script: `./support_helper.sh`.
4. Enter an option number (1–24) or `Q` to quit.  
   Digite o número da opção (1–24) ou `Q` para sair.
5. Output is shown on screen and logged to `support-tool.log` in the script directory.  
   A saída é exibida na tela e registrada em `support-tool.log` no diretório do script.

---

## Windows Menu (English)

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

---

## Menu do Windows (Português-BR)

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

---

## Unix Menu (Linux/macOS) / Menu Unix (Linux/macOS)

Below are cross-platform equivalents. Some commands vary by OS/distro.  
Abaixo estão os equivalentes multiplataforma. Alguns comandos variam por SO/distro.

1) IP config (detailed) — Linux: `ip a` or `ifconfig -a` (if installed); macOS: `ifconfig`  
   Configuração de IP (detalhado) — Linux: `ip a` ou `ifconfig -a` (se instalado); macOS: `ifconfig`

2) Flush DNS — Linux: `systemd-resolve --flush-caches` or `sudo /etc/init.d/dns-clean restart` (Ubuntu legacy) or restart `nscd`; macOS: `sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder`  
   Limpar DNS — Linux: `systemd-resolve --flush-caches` ou `sudo /etc/init.d/dns-clean restart` (Ubuntu legado) ou reiniciar `nscd`; macOS: `sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder`

3) Ping host — `ping -c 6 <host>`  
   Ping em host — `ping -c 6 <host>`

4) Traceroute to host — Linux/macOS: `traceroute <host>` (use `sudo` if needed); alternative: `tracepath <host>` (Linux)  
   Traceroute para host — Linux/macOS: `traceroute <host>` (use `sudo` se necessário); alternativa: `tracepath <host>` (Linux)

5) DNS lookup — `dig <host>` or `nslookup <host>`  
   Consulta DNS — `dig <host>` ou `nslookup <host>`

6) Netstat active connections (all) — `ss -tulpn` or `netstat -tulpn` (if installed)  
   Conexões ativas (netstat) — `ss -tulpn` ou `netstat -tulpn` (se instalado)

7) Listening ports — `ss -ltnp` (TCP) and `ss -lunp` (UDP); or `lsof -Pi -sTCP:LISTEN`  
   Portas em escuta — `ss -ltnp` (TCP) e `ss -lunp` (UDP); ou `lsof -Pi -sTCP:LISTEN`

8) System info — Linux: `uname -a && lsb_release -a` (if available) or `/etc/os-release`; macOS: `uname -a && sw_vers`  
   Info do sistema — Linux: `uname -a && lsb_release -a` (se disponível) ou `/etc/os-release`; macOS: `uname -a && sw_vers`

9) Hardware inventory — Linux: `sudo lshw -short` or `lspci`, `lsusb`, `lsblk`, `dmidecode`; macOS: `system_profiler SPHardwareDataType`  
   Inventário de hardware — Linux: `sudo lshw -short` ou `lspci`, `lsusb`, `lsblk`, `dmidecode`; macOS: `system_profiler SPHardwareDataType`

10) Filesystem check (integrity examples) — Linux: `sudo debsums` (Debian-based) or `rpm -Va` (RPM-based); macOS: `diskutil verifyVolume /`  
    Verificação de sistema de arquivos (exemplos de integridade) — Linux: `sudo debsums` (Debian) ou `rpm -Va` (RPM); macOS: `diskutil verifyVolume /`

11) System repair (package/db health examples) — Linux: `sudo apt -f install && sudo dpkg --configure -a` (Debian-based) or `sudo dnf check && sudo dnf distro-sync` (RPM-based); macOS: run `softwareupdate -ia --verbose`  
    Reparos de sistema (saúde de pacotes/exemplos) — Linux: `sudo apt -f install && sudo dpkg --configure -a` (Debian) ou `sudo dnf check && sudo dnf distro-sync` (RPM); macOS: `softwareupdate -ia --verbose`

12) Process tools — list: `ps aux` or `top/htop`; kill by PID: `kill -9 <pid>` (caution)  
    Processos — listar: `ps aux` ou `top/htop`; matar por PID: `kill -9 <pid>` (cuidado)

13) Driver/modules — Linux: `lsmod` + `modinfo <module>`; macOS: `kextstat`  
    Drivers/módulos — Linux: `lsmod` + `modinfo <module>`; macOS: `kextstat`

14) Services — Linux (systemd): `systemctl list-units --type=service --all`; macOS: `launchctl list`  
    Serviços — Linux (systemd): `systemctl list-units --type=service --all`; macOS: `launchctl list`

15) Route table — `ip route` (Linux) or `netstat -nr` (macOS)  
    Tabela de rotas — `ip route` (Linux) ou `netstat -nr` (macOS)

16) ARP cache — `ip neigh` (Linux) or `arp -a` (macOS)  
    Cache ARP — `ip neigh` (Linux) ou `arp -a` (macOS)

17) Pathping equivalent — Linux: `mtr -rw <host>` (install mtr); macOS: `mtr <host>` or `traceroute -q 1 -w 2 <host>`  
    Equivalente ao Pathping — Linux: `mtr -rw <host>` (instalar mtr); macOS: `mtr <host>` ou `traceroute -q 1 -w 2 <host>`

18) Display DNS cache — Linux: `sudo systemd-resolve --statistics` (limited) or inspect `nscd` cache; macOS: `sudo killall -INFO mDNSResponder` then check logs  
    Exibir cache DNS — Linux: `sudo systemd-resolve --statistics` (limitado) ou inspecionar cache do `nscd`; macOS: `sudo killall -INFO mDNSResponder` e verificar logs

19) Wi‑Fi profiles — Linux: `nmcli connection show` or `sudo grep -r SSID /etc/NetworkManager/system-connections`; macOS: `networksetup -listpreferredwirelessnetworks <device>`  
    Perfis Wi‑Fi — Linux: `nmcli connection show` ou `sudo grep -r SSID /etc/NetworkManager/system-connections`; macOS: `networksetup -listpreferredwirelessnetworks <device>`

20) Wi‑Fi drivers/capabilities — Linux: `iw dev`, `iw list`, `nmcli device wifi list`; macOS: `system_profiler SPAirPortDataType`  
    Drivers/capacidades Wi‑Fi — Linux: `iw dev`, `iw list`, `nmcli device wifi list`; macOS: `system_profiler SPAirPortDataType`

21) Firewall status — Linux: `sudo ufw status` or `sudo firewall-cmd --state` (RPM-based); macOS: `socketfilterfw --getglobalstate`  
    Status do firewall — Linux: `sudo ufw status` ou `sudo firewall-cmd --state` (RPM); macOS: `socketfilterfw --getglobalstate`

22) Network shares — Linux: `showmount -e <server>` (NFS), `smbclient -L //<server>` (SMB); macOS: `mount` or `smbutil view //<server>`  
    Compartilhamentos de rede — Linux: `showmount -e <servidor>` (NFS), `smbclient -L //<servidor>` (SMB); macOS: `mount` ou `smbutil view //<servidor>`

23) Installed updates — Linux: `grep "upgrade " /var/log/dpkg.log` (Debian-based), `rpm -qa --last` (RPM-based); macOS: `softwareupdate --history`  
    Atualizações instaladas — Linux: `grep "upgrade " /var/log/dpkg.log` (Debian) , `rpm -qa --last` (RPM); macOS: `softwareupdate --history`

24) Recent system events (20) — Linux: `journalctl -p 0..4 -n 20 --system`; macOS: `log show --style syslog --last 1d | tail -n 200 | grep -E "kernel|error|fault" | tail -n 20`  
    Eventos de sistema recentes (20) — Linux: `journalctl -p 0..4 -n 20 --system`; macOS: `log show --style syslog --last 1d | tail -n 200 | grep -E "kernel|error|fault" | tail -n 20`

Q) Quit — `q` or `Ctrl+C`  
Q) Sair — `q` ou `Ctrl+C`

---

## Inputs & Prompts / Entradas & Perguntas

- Hostname/IP prompts for network tests (ping, traceroute/mtr, pathping, nslookup/dig).  
- Confirmation prompts for long/elevated operations (Windows: SFC/DISM; Linux/macOS: package repairs, filesystem checks).  
- Wi‑Fi device selection on macOS may require interface name (e.g., `en0`).  

- Solicitação de hostname/IP para testes de rede (ping, traceroute/mtr, pathping, nslookup/dig).  
- Confirmação para operações longas/elevadas (Windows: SFC/DISM; Linux/macOS: reparos de pacotes, verificação de sistema de arquivos).  
- Em macOS, pode ser necessário informar o nome da interface Wi‑Fi (ex.: `en0`).

---

## Logging / Registro

- File: `support-tool.log` in the script directory (Windows and Unix).  
- Format: `[date time] <command>` per execution, plus selected output excerpts.  
- On Unix, the script uses `tee` or `>>` to append outputs; on Windows, batch appends via `>>` and PowerShell cmdlets.

- Arquivo: `support-tool.log` no diretório do script (Windows e Unix).  
- Formato: `[data hora] <comando>` por execução, com trechos selecionados de saída.  
- Em Unix, o script usa `tee` ou `>>` para anexar saídas; no Windows, o batch utiliza `>>` e cmdlets do PowerShell.

---

## Requirements / Requisitos

- Windows:
  - PowerShell available (default on modern Windows) for hardware/hotfix/event queries.
  - Admin rights recommended for SFC/DISM and some service/firewall operations.

- Linux:
  - Recommended packages: `traceroute`, `mtr`, `lshw`, `lsof`, `iw`, `nmcli` (NetworkManager), `lsb-release`, `systemd` tools (`journalctl`, `systemd-resolve`).
  - Use `sudo` for certain inventory and service commands.

- macOS:
  - Uses built-in `system_profiler`, `networksetup`, and `log`.
  - `mtr` and `dig` may require installation via Homebrew (`brew install mtr bind`).

- Windows:
  - PowerShell disponível (padrão no Windows moderno) para consultas de hardware/hotfix/eventos.
  - Direitos de administrador recomendados para SFC/DISM e algumas operações de serviço/firewall.

- Linux:
  - Pacotes recomendados: `traceroute`, `mtr`, `lshw`, `lsof`, `iw`, `nmcli` (NetworkManager), `lsb-release`, ferramentas do `systemd` (`journalctl`, `systemd-resolve`).
  - Use `sudo` para certos inventários e comandos de serviço.

- macOS:
  - Usa `system_profiler`, `networksetup` e `log` embutidos.
  - `mtr` e `dig` podem exigir instalação via Homebrew (`brew install mtr bind`).

---

## Notes / Observações

- Windows SFC/DISM require elevated Command Prompt.  
- Unix: some commands vary by distro or need installation; the script attempts to detect availability and suggest alternatives.  
- Network tests prompt for hostnames/IPs where applicable.  
- PowerShell is invoked with `-NoProfile -ExecutionPolicy Bypass` for inventory, hotfix, and event queries (Windows).  
- Unix logging avoids sensitive data; review logs before sharing.

- Windows: SFC/DISM exigem Prompt de Comando elevado.  
- Unix: alguns comandos variam por distro ou precisam de instalação; o script tenta detectar disponibilidade e sugerir alternativas.  
- Testes de rede solicitam hostnames/IPs quando aplicável.  
- PowerShell é chamado com `-NoProfile -ExecutionPolicy Bypass` para inventário, hotfixes e eventos (Windows).  
- Logs em Unix evitam dados sensíveis; revise antes de compartilhar.

---

## Disclaimer / Aviso

Use at your own risk. Review commands before running in production environments.  
Use por sua conta e risco. Revise os comandos antes de usar em ambientes de produção.

---

## Files / Arquivos

- Windows Batch script — `support_helper.bat`  
- Unix Shell script — `support_helper.sh`  
- Shared log file — `support-tool.log`

- Script Batch para Windows — `support_helper.bat`  
- Script Shell para Unix — `support_helper.sh`  
- Arquivo de log compartilhado — `support-tool.log`

---

## Quick Reference Maps / Mapas de Referência Rápida

- Tracert (Windows) ≈ traceroute/tracepath (Unix)  
- Pathping (Windows) ≈ mtr (Unix)  
- Netstat (Windows) ≈ ss/netstat/lsof (Unix)  
- Systeminfo (Windows) ≈ uname + os-release/lsb_release + system_profiler (Unix/macOS)  
- Driverquery (Windows) ≈ lsmod/modinfo/kextstat (Unix/macOS)  
- Services (sc) (Windows) ≈ systemctl/launchctl (Unix/macOS)  
- Firewall (netsh) (Windows) ≈ ufw/firewalld/socketfilterfw (Unix/macOS)  
- Wi‑Fi profiles/drivers (netsh) ≈ nmcli/iw/system_profiler/networksetup (Unix/macOS)

- Tracert (Windows) ≈ traceroute/tracepath (Unix)  
- Pathping (Windows) ≈ mtr (Unix)  
- Netstat (Windows) ≈ ss/netstat/lsof (Unix)  
- Systeminfo (Windows) ≈ uname + os-release/lsb_release + system_profiler (Unix/macOS)  
- Driverquery (Windows) ≈ lsmod/modinfo/kextstat (Unix/macOS)  
- Serviços (sc) (Windows) ≈ systemctl/launchctl (Unix/macOS)  
- Firewall (netsh) (Windows) ≈ ufw/firewalld/socketfilterfw (Unix/macOS)  
- Perfis/drivers Wi‑Fi (netsh) ≈ nmcli/iw/system_profiler/networksetup (Unix/macOS)

---
