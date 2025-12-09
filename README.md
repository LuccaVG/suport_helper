# suport_helper / Tech Support Quick Commands

Bilingual README (English / Português‑BR) documenting Windows Batch and Unix Shell menus with quick diagnostic/remediation actions.

Repo languages: Shell (~54.3%), Batchfile (~45.7%).  
Idiomas do repositório: Shell (~54,3%), Batch (~45,7%).

Use the index below to jump to your language:
- English: [Full Documentation (English)](#full-documentation-english)
- Português‑BR: [Documentação Completa (Português‑BR)](#documentação-completa-português-br)

---

## Full Documentation (English)

### Table of Contents
- [Overview](#overview)
- [Usage](#usage)
  - [Windows (Batch)](#windows-batch)
  - [Linux/macOS (Shell)](#linuxmacos-shell)
- [Menus](#menus)
  - [Windows Menu](#windows-menu)
  - [Unix Menu (Linux/macOS)](#unix-menu-linuxmacos)
- [Inputs & Prompts](#inputs--prompts)
- [Logging](#logging)
- [Requirements](#requirements)
- [Notes](#notes)
- [Disclaimer](#disclaimer)
- [Files](#files)
- [Quick Reference Maps](#quick-reference-maps)

---

### Overview

- Cross‑platform support:
  - Windows: Batch script with numeric menu (1–24 + Q) for common support commands.
  - Linux/macOS: Shell script with numeric menu (1–24 + Q) offering equivalent diagnostics.
- Logging:
  - Windows: logs every executed command to `support-tool.log` in the script directory.
  - Unix: logs to `support-tool.log` (same directory) using `tee`/redirections.
- Interactive prompts:
  - Host inputs where needed (ping, traceroute/tracert, pathping, nslookup/dig).
  - Safety prompts for long/elevated operations (SFC/DISM on Windows; integrity checks on Unix).
- PowerShell on Windows for richer hardware inventory and hotfix/event listing.
- Cross‑platform alternatives for hardware and updates on Unix (lshw, lspci, lsusb, dmidecode, journalctl, system_profiler).

---

### Usage

#### Windows (Batch)
1. Open Command Prompt (recommended: “Run as administrator” for SFC/DISM).
2. Run the `.bat` file from its folder; a menu will appear.
3. Enter an option number (1–24) or `Q` to quit.
4. Outputs are displayed on screen; commands and timestamps are appended to `support-tool.log`.

#### Linux/macOS (Shell)
1. Open Terminal. For operations that need elevated privileges, use `sudo` when prompted.
2. Make the script executable: `chmod +x support_helper.sh`.
3. Run the script: `./support_helper.sh`.
4. Enter an option number (1–24) or `Q` to quit.
5. Output is shown on screen and logged to `support-tool.log` in the script directory.

---

### Menus

#### Windows Menu
1) IP config (detailed) — `ipconfig /all`  
2) Flush DNS — `ipconfig /flushdns`  
3) Ping host — `ping -n 6 <host>`  
4) Tracert to host — `tracert <host>`  
5) DNS lookup — `nslookup <host>`  
6) Netstat active connections (all) — `netstat -ano`  
7) Netstat listening ports — `netstat -ano | findstr LISTENING`  
8) System info — `systeminfo`  
9) Hardware inventory (CIM) — PowerShell `Get-CimInstance Win32_ComputerSystem, Win32_OperatingSystem, Win32_Processor | Format-List *`  
10) SFC scan — `sfc /scannow` (elevated)  
11) DISM restore health — `DISM /Online /Cleanup-Image /RestoreHealth` (elevated)  
12) Process tools — list (`tasklist`) or kill by PID (`taskkill /PID <pid> /F`)  
13) Driver list — `driverquery /v`  
14) Services (all) — `sc query type=service state=all`  
15) Route table — `route print`  
16) ARP cache — `arp -a`  
17) Pathping to host — `pathping <host>`  
18) Display DNS cache — `ipconfig /displaydns`  
19) Wi‑Fi profiles — `netsh wlan show profiles`  
20) Wi‑Fi drivers/capabilities — `netsh wlan show drivers`  
21) Firewall status (all profiles) — `netsh advfirewall show allprofiles`  
22) Network shares — `net share`  
23) Installed updates (hotfixes) — PowerShell `Get-HotFix | Sort-Object InstalledOn`  
24) Recent System event log (20 entries) — PowerShell `Get-EventLog -LogName System -Newest 20`  
Q) Quit

#### Unix Menu (Linux/macOS)
Cross‑platform equivalents. Some commands vary by OS/distro.

1) IP config (detailed) — Linux: `ip a` or `ifconfig -a` (if installed); macOS: `ifconfig`  
2) Flush DNS — Linux (systemd): `sudo systemd-resolve --flush-caches`; Ubuntu legacy: `sudo /etc/init.d/dns-clean restart`; with NSCD: `sudo service nscd restart`. macOS: `sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder`  
3) Ping host — `ping -c 6 <host>`  
4) Traceroute to host — `traceroute <host>` (use `sudo` if needed); alternative: Linux `tracepath <host>`  
5) DNS lookup — `dig <host>` or `nslookup <host>`  
6) Netstat active connections (all) — `ss -tulpn` or `netstat -tulpn` (if installed)  
7) Listening ports — `ss -ltnp` (TCP) and `ss -lunp` (UDP); or `lsof -Pi -sTCP:LISTEN`  
8) System info — Linux: `uname -a && lsb_release -a` (if available) or `cat /etc/os-release`; macOS: `uname -a && sw_vers`  
9) Hardware inventory — Linux: `sudo lshw -short` or `lspci`, `lsusb`, `lsblk`, `dmidecode`; macOS: `system_profiler SPHardwareDataType`  
10) Filesystem/integrity check — Linux: `sudo debsums` (Debian‑based) or `rpm -Va` (RPM‑based); macOS: `diskutil verifyVolume /`  
11) System repair (package/db health) — Linux (Debian‑based): `sudo apt -f install && sudo dpkg --configure -a`; Linux (RPM‑based): `sudo dnf check && sudo dnf distro-sync`; macOS: `softwareupdate -ia --verbose`  
12) Process tools — list: `ps aux` or `top/htop`; kill by PID: `kill -9 <pid>` (use with caution)  
13) Driver/modules — Linux: `lsmod` + `modinfo <module>`; macOS: `kextstat`  
14) Services — Linux (systemd): `systemctl list-units --type=service --all`; macOS: `launchctl list`  
15) Route table — `ip route` (Linux) or `netstat -nr` (macOS)  
16) ARP cache — `ip neigh` (Linux) or `arp -a` (macOS)  
17) Pathping equivalent — Linux: `mtr -rw <host>` (requires `mtr`); macOS: `mtr <host>` or `traceroute -q 1 -w 2 <host>`  
18) Display DNS cache — Linux: limited via `sudo systemd-resolve --statistics` or inspect NSCD cache; macOS: `sudo killall -INFO mDNSResponder` then check system logs  
19) Wi‑Fi profiles — Linux: `nmcli connection show` or `sudo grep -r SSID /etc/NetworkManager/system-connections`; macOS: `networksetup -listpreferredwirelessnetworks <device>`  
20) Wi‑Fi drivers/capabilities — Linux: `iw dev`, `iw list`, `nmcli device wifi list`; macOS: `system_profiler SPAirPortDataType`  
21) Firewall status — Linux: `sudo ufw status` or `sudo firewall-cmd --state` (RPM‑based); macOS: `sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate`  
22) Network shares — Linux: `showmount -e <server>` (NFS), `smbclient -L //<server>` (SMB); macOS: `mount` or `smbutil view //<server>`  
23) Installed updates — Linux: `grep "upgrade " /var/log/dpkg.log` (Debian‑based), `rpm -qa --last` (RPM‑based); macOS: `softwareupdate --history`  
24) Recent system events (20) — Linux: `journalctl -p 0..4 -n 20 --system`; macOS: `log show --style syslog --last 1d | grep -E "kernel|error|fault" | tail -n 20`  
Q) Quit — `q` or `Ctrl+C`

---

### Inputs & Prompts
- Hostname/IP prompts for network tests (ping, traceroute/mtr, pathping, nslookup/dig).
- Confirmation prompts for long/elevated operations (Windows: SFC/DISM; Linux/macOS: package repairs, filesystem checks).
- Wi‑Fi device selection on macOS may require interface name (e.g., `en0`).

---

### Logging
- File: `support-tool.log` in the script directory (Windows and Unix).
- Format: `[date time] <command>` per execution, plus selected output excerpts.
- On Unix, the script uses `tee` or `>>` to append outputs; on Windows, batch appends via `>>` and PowerShell cmdlets.

---

### Requirements
- Windows:
  - PowerShell available (default on modern Windows) for hardware/hotfix/event queries.
  - Admin rights recommended for SFC/DISM and some service/firewall operations.
- Linux:
  - Recommended packages: `traceroute`, `mtr`, `lshw`, `lsof`, `iw`, `nmcli` (NetworkManager), `lsb-release`, systemd tools (`journalctl`, `systemd-resolve`).
  - Use `sudo` for certain inventory and service commands.
- macOS:
  - Uses built‑in `system_profiler`, `networksetup`, and `log`.
  - `mtr` and `dig` may require installation via Homebrew (`brew install mtr bind`).

---

### Notes
- Windows SFC/DISM require elevated Command Prompt.
- Unix: some commands vary by distro or need installation; the script attempts to detect availability and suggest alternatives.
- Network tests prompt for hostnames/IPs where applicable.
- PowerShell is invoked with `-NoProfile -ExecutionPolicy Bypass` for inventory, hotfix, and event queries (Windows).
- Unix logging avoids sensitive data; review logs before sharing.

---

### Disclaimer
Use at your own risk. Review commands before running in production environments.

---

### Files
- Windows Batch script — `support_helper.bat`
- Unix Shell script — `support_helper.sh`
- Shared log file — `support-tool.log`

---

### Quick Reference Maps
- Tracert (Windows) ≈ traceroute/tracepath (Unix)
- Pathping (Windows) ≈ mtr (Unix)
- Netstat (Windows) ≈ ss/netstat/lsof (Unix)
- Systeminfo (Windows) ≈ uname + os‑release/lsb_release + system_profiler (Unix/macOS)
- Driverquery (Windows) ≈ lsmod/modinfo/kextstat (Unix/macOS)
- Services (sc) (Windows) ≈ systemctl/launchctl (Unix/macOS)
- Firewall (netsh) (Windows) ≈ ufw/firewalld/socketfilterfw (Unix/macOS)
- Wi‑Fi profiles/drivers (netsh) ≈ nmcli/iw/system_profiler/networksetup (Unix/macOS)

---

## Documentação Completa (Português‑BR)

### Índice
- [Visão geral](#visão-geral)
- [Como usar](#como-usar)
  - [Windows (Batch)](#windows-batch-1)
  - [Linux/macOS (Shell)](#linuxmacos-shell-1)
- [Menus](#menus-1)
  - [Menu do Windows](#menu-do-windows)
  - [Menu Unix (Linux/macOS)](#menu-unix-linuxmacos)
- [Entradas & Perguntas](#entradas--perguntas)
- [Registro](#registro)
- [Requisitos](#requisitos)
- [Observações](#observações)
- [Aviso](#aviso)
- [Arquivos](#arquivos)
- [Mapas de Referência Rápida](#mapas-de-referência-rápida)

---

### Visão geral
- Suporte multiplataforma:
  - Windows: script Batch com menu numérico (1–24 + Q) para comandos comuns de suporte.
  - Linux/macOS: script Shell com menu numérico (1–24 + Q) oferecendo diagnósticos equivalentes.
- Registro:
  - Windows: registra cada comando executado em `support-tool.log` no diretório do script.
  - Unix: registra em `support-tool.log` (mesmo diretório) usando `tee`/redirecionamentos.
- Prompts interativos:
  - Entradas de host quando necessário (ping, traceroute/tracert, pathping, nslookup/dig).
  - Confirmações para operações longas/elevadas (SFC/DISM no Windows; verificações de integridade no Unix).
- PowerShell no Windows para inventário de hardware e listagem de hotfix/eventos.
- Alternativas multiplataforma para hardware e atualizações no Unix (lshw, lspci, lsusb, dmidecode, journalctl, system_profiler).

---

### Como usar

#### Windows (Batch)
1. Abra o Prompt de Comando (recomendado: “Executar como administrador” para SFC/DISM).
2. Execute o arquivo `.bat` na sua pasta; o menu será exibido.
3. Digite o número da opção (1–24) ou `Q` para sair.
4. As saídas aparecem na tela; comandos e horários são gravados em `support-tool.log`.

#### Linux/macOS (Shell)
1. Abra o Terminal. Para operações que exigem privilégios elevados, use `sudo` quando solicitado.
2. Torne o script executável: `chmod +x support_helper.sh`.
3. Execute o script: `./support_helper.sh`.
4. Digite o número da opção (1–24) ou `Q` para sair.
5. A saída é exibida na tela e registrada em `support-tool.log` no diretório do script.

---

### Menus

#### Menu do Windows
1) IP config (detalhado) — `ipconfig /all`  
2) Limpar DNS — `ipconfig /flushdns`  
3) Ping em host — `ping -n 6 <host>`  
4) Tracert para host — `tracert <host>`  
5) Consulta DNS — `nslookup <host>`  
6) Conexões ativas (netstat) — `netstat -ano`  
7) Portas em escuta — `netstat -ano | findstr LISTENING`  
8) Info do sistema — `systeminfo`  
9) Inventário de hardware (CIM) — PowerShell `Get-CimInstance Win32_ComputerSystem, Win32_OperatingSystem, Win32_Processor | Format-List *`  
10) Verificação SFC — `sfc /scannow` (elevado)  
11) DISM restaurar imagem — `DISM /Online /Cleanup-Image /RestoreHealth` (elevado)  
12) Processos — listar (`tasklist`) ou matar por PID (`taskkill /PID <pid> /F`)  
13) Lista de drivers — `driverquery /v`  
14) Serviços (todos) — `sc query type=service state=all`  
15) Tabela de rotas — `route print`  
16) Cache ARP — `arp -a`  
17) Pathping para host — `pathping <host>`  
18) Exibir cache DNS — `ipconfig /displaydns`  
19) Perfis Wi‑Fi — `netsh wlan show profiles`  
20) Drivers/capacidades Wi‑Fi — `netsh wlan show drivers`  
21) Status do firewall (perfis) — `netsh advfirewall show allprofiles`  
22) Compartilhamentos de rede — `net share`  
23) Atualizações instaladas (hotfixes) — PowerShell `Get-HotFix | Sort-Object InstalledOn`  
24) Log de eventos do Sistema (20 mais recentes) — PowerShell `Get-EventLog -LogName System -Newest 20`  
Q) Sair

#### Menu Unix (Linux/macOS)
Equivalentes multiplataforma. Alguns comandos variam por SO/distro.

1) Configuração de IP (detalhado) — Linux: `ip a` ou `ifconfig -a` (se instalado); macOS: `ifconfig`  
2) Limpar DNS — Linux (systemd): `sudo systemd-resolve --flush-caches`; Ubuntu legado: `sudo /etc/init.d/dns-clean restart`; com NSCD: `sudo service nscd restart`. macOS: `sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder`  
3) Ping em host — `ping -c 6 <host>`  
4) Traceroute para host — `traceroute <host>` (use `sudo` se necessário); alternativa Linux: `tracepath <host>`  
5) Consulta DNS — `dig <host>` ou `nslookup <host>`  
6) Conexões ativas (netstat) — `ss -tulpn` ou `netstat -tulpn` (se instalado)  
7) Portas em escuta — `ss -ltnp` (TCP) e `ss -lunp` (UDP); ou `lsof -Pi -sTCP:LISTEN`  
8) Info do sistema — Linux: `uname -a && lsb_release -a` (se disponível) ou `cat /etc/os-release`; macOS: `uname -a && sw_vers`  
9) Inventário de hardware — Linux: `sudo lshw -short` ou `lspci`, `lsusb`, `lsblk`, `dmidecode`; macOS: `system_profiler SPHardwareDataType`  
10) Verificação de sistema de arquivos/integridade — Linux: `sudo debsums` (Debian) ou `rpm -Va` (RPM); macOS: `diskutil verifyVolume /`  
11) Reparos de sistema (saúde de pacotes/banco) — Linux (Debian): `sudo apt -f install && sudo dpkg --configure -a`; Linux (RPM): `sudo dnf check && sudo dnf distro-sync`; macOS: `softwareupdate -ia --verbose`  
12) Processos — listar: `ps aux` ou `top/htop`; matar por PID: `kill -9 <pid>` (usar com cautela)  
13) Drivers/módulos — Linux: `lsmod` + `modinfo <module>`; macOS: `kextstat`  
14) Serviços — Linux (systemd): `systemctl list-units --type=service --all`; macOS: `launchctl list`  
15) Tabela de rotas — `ip route` (Linux) ou `netstat -nr` (macOS)  
16) Cache ARP — `ip neigh` (Linux) ou `arp -a` (macOS)  
17) Equivalente ao Pathping — Linux: `mtr -rw <host>` (requer `mtr`); macOS: `mtr <host>` ou `traceroute -q 1 -w 2 <host>`  
18) Exibir cache DNS — Linux: limitado via `sudo systemd-resolve --statistics` ou inspecionar cache do NSCD; macOS: `sudo killall -INFO mDNSResponder` e verificar logs do sistema  
19) Perfis Wi‑Fi — Linux: `nmcli connection show` ou `sudo grep -r SSID /etc/NetworkManager/system-connections`; macOS: `networksetup -listpreferredwirelessnetworks <device>`  
20) Drivers/capacidades Wi‑Fi — Linux: `iw dev`, `iw list`, `nmcli device wifi list`; macOS: `system_profiler SPAirPortDataType`  
21) Status do firewall — Linux: `sudo ufw status` ou `sudo firewall-cmd --state` (RPM); macOS: `sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate`  
22) Compartilhamentos de rede — Linux: `showmount -e <servidor>` (NFS), `smbclient -L //<servidor>` (SMB); macOS: `mount` ou `smbutil view //<servidor>`  
23) Atualizações instaladas — Linux: `grep "upgrade " /var/log/dpkg.log` (Debian), `rpm -qa --last` (RPM); macOS: `softwareupdate --history`  
24) Eventos de sistema recentes (20) — Linux: `journalctl -p 0..4 -n 20 --system`; macOS: `log show --style syslog --last 1d | grep -E "kernel|error|fault" | tail -n 20`  
Q) Sair — `q` ou `Ctrl+C`

---

### Entradas & Perguntas
- Solicitação de hostname/IP para testes de rede (ping, traceroute/mtr, pathping, nslookup/dig).
- Confirmação para operações longas/elevadas (Windows: SFC/DISM; Linux/macOS: reparos de pacotes, verificação de sistema de arquivos).
- Em macOS, pode ser necessário informar o nome da interface Wi‑Fi (ex.: `en0`).

---

### Registro
- Arquivo: `support-tool.log` no diretório do script (Windows e Unix).
- Formato: `[data hora] <comando>` por execução, com trechos selecionados de saída.
- Em Unix, o script usa `tee` ou `>>` para anexar saídas; no Windows, o batch utiliza `>>` e cmdlets do PowerShell.

---

### Requisitos
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

### Observações
- Windows: SFC/DISM exigem Prompt de Comando elevado.
- Unix: alguns comandos variam por distro ou precisam de instalação; o script tenta detectar disponibilidade e sugerir alternativas.
- Testes de rede solicitam hostnames/IPs quando aplicável.
- PowerShell é chamado com `-NoProfile -ExecutionPolicy Bypass` para inventário, hotfixes e eventos (Windows).
- Logs em Unix evitam dados sensíveis; revise antes de compartilhar.

---

### Aviso
Use por sua conta e risco. Revise os comandos antes de usar em ambientes de produção.

---

### Arquivos
- Script Batch para Windows — `support_helper.bat`
- Script Shell para Unix — `support_helper.sh`
- Arquivo de log compartilhado — `support-tool.log`

---

### Mapas de Referência Rápida
- Tracert (Windows) ≈ traceroute/tracepath (Unix)
- Pathping (Windows) ≈ mtr (Unix)
- Netstat (Windows) ≈ ss/netstat/lsof (Unix)
- Systeminfo (Windows) ≈ uname + os‑release/lsb_release + system_profiler (Unix/macOS)
- Driverquery (Windows) ≈ lsmod/modinfo/kextstat (Unix/macOS)
- Serviços (sc) (Windows) ≈ systemctl/launchctl (Unix/macOS)
- Firewall (netsh) (Windows) ≈ ufw/firewalld/socketfilterfw (Unix/macOS)
- Perfis/drivers Wi‑Fi (netsh) ≈ nmcli/iw/system_profiler/networksetup (Unix/macOS)

---
