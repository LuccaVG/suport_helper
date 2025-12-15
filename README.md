# suport_helper / Tech Support Quick Commands

Bilingual README (English / Português‑BR) documenting Windows Batch and Linux Shell scripts with quick diagnostic/remediation actions.

Note: The Linux version is currently under active development and has a different feature set than the Windows version.

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
  - [Linux (Shell)](#linux-shell)
- [Menus](#menus)
  - [Windows Menu](#windows-menu)
  - [Linux Menu](#linux-menu)
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
  - Linux: Shell script with numeric menu (1–24 + Q) offering diagnostic commands. Note: The Linux version is under active development with a different feature set.
- Logging:
  - Windows: logs every executed command to `support-tool.log` in the script directory.
  - Linux: logs to `linux_suport_helper.log` in the script directory.
- Interactive prompts:
  - Host inputs where needed (ping, traceroute/tracert, pathping, nslookup/dig).
  - Safety prompts for long/elevated operations (SFC/DISM on Windows).
- PowerShell on Windows for richer hardware inventory and hotfix/event listing.

---

### Usage

#### Windows (Batch)
1. Open Command Prompt (recommended: “Run as administrator” for SFC/DISM).
2. Run the `.bat` file from its folder; a menu will appear.
3. Enter an option number (1–24) or `Q` to quit.
4. Outputs are displayed on screen; commands and timestamps are appended to `support-tool.log`.

#### Linux (Shell)
Note: The Linux version is under active development.

1. Open Terminal. For operations that need elevated privileges, use `sudo` when prompted.
2. Make the script executable: `chmod +x linux_suport_helper.sh`.
3. Run the script: `./linux_suport_helper.sh`.
4. Enter an option number (1–24) or `Q` to quit.
5. Output is shown on screen and logged to `linux_suport_helper.log` in the script directory.

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

#### Linux Menu
Note: The Linux version is under active development and currently implements the following features:

1) IP config (ip addr) — `ip a`  
2) Flush DNS cache (best effort) — Various methods depending on system configuration (systemd-resolve, resolvectl, rndc, nscd)  
3) Ping host — `ping -c 6 <host>`  
4) Traceroute / tracepath — `traceroute <host>` or `tracepath <host>` (if traceroute not available)  
5) DNS lookup (dig/nslookup/host) — `dig <host>`, `nslookup <host>`, or `host <host>` (depending on availability)  
6) Listening sockets — `ss -tulpn`  
7) Active TCP connections — `ss -tan`  
8) System info (kernel/distro) — `uname -a` and `lsb_release -a` (if available)  
9) Hardware inventory — `sudo lshw -short` or combination of `lscpu`, `lspci`, `lsusb`, `lsblk`  
10) Disk usage — `df -h`  
11) Memory/swap — `free -h`  
12) Top CPU processes — `ps -eo pid,cmd,%cpu,%mem --sort=-%cpu | head -20`  
13) Kill process by PID — `sudo kill -9 <pid>`  
14) Services — `systemctl list-units --type=service --all` or `service --status-all`  
15) Route table — `ip route`  
16) ARP/neighbor table — `ip neigh`  
17) Path quality — `sudo mtr -rw <host>` or `tracepath <host>`  
18) DNS cache stats — `resolvectl statistics` or `systemd-resolve --statistics`  
19) Firewall status — Various commands depending on system: `sudo ufw status verbose`, `sudo firewall-cmd --state`, `sudo iptables -L -n -v`, or `sudo nft list ruleset`  
20) Network mounts/shares — `mount | column -t`  
21) Installed packages (summary) — `dpkg -l | head -40` or `rpm -qa | head -40`  
22) Recent errors — `journalctl -p err -n 50`  
23) Syslog/messages tail — `tail -n 100 /var/log/syslog` or `tail -n 100 /var/log/messages`  
24) Time sync status — `timedatectl` or `date`  
Q) Quit — `q` or `Ctrl+C`

---

### Inputs & Prompts
- Hostname/IP prompts for network tests (ping, traceroute, nslookup/dig).
- Confirmation prompts for long/elevated operations (Windows: SFC/DISM).
- PID input for process termination.

---

### Logging
- Windows: File `support-tool.log` in the script directory. Format: `[date time] <command>` per execution.
- Linux: File `linux_suport_helper.log` in the script directory. Format: `[date time] <command>` per execution.

---

### Requirements
- Windows:
  - PowerShell available (default on modern Windows) for hardware/hotfix/event queries.
  - Admin rights recommended for SFC/DISM and some service/firewall operations.
- Linux:
  - Note: The Linux version is under active development.
  - Recommended packages vary by distribution and feature used: `traceroute`, `mtr`, `lshw`, `lsof`, `iw`, `nmcli`, `lsb-release`, systemd tools (`journalctl`, `systemd-resolve` or `resolvectl`).
  - Use `sudo` for certain inventory and service commands.

---

### Notes
- Windows SFC/DISM require elevated Command Prompt.
- Linux: The Linux version is under active development. Some commands vary by distribution or need installation; the script attempts to detect availability and suggest alternatives.
- Network tests prompt for hostnames/IPs where applicable.
- PowerShell is invoked with `-NoProfile -ExecutionPolicy Bypass` for inventory, hotfix, and event queries (Windows).

---

### Disclaimer
Use at your own risk. Review commands before running in production environments.

---

### Files
- Windows Batch script — `windows_suport_helper.bat`
- Linux Shell script (under development) — `linux_suport_helper.sh`
- Windows log file — `support-tool.log`
- Linux log file — `linux_suport_helper.log`

---

### Quick Reference Maps
Windows vs Linux equivalents (note: Linux version under development):
- Tracert (Windows) ≈ traceroute/tracepath (Linux)
- Pathping (Windows) ≈ mtr (Linux)
- Netstat (Windows) ≈ ss (Linux)
- Systeminfo (Windows) ≈ uname + lsb_release (Linux)
- Driverquery (Windows) ≈ lsmod/modinfo (Linux)
- Services (sc) (Windows) ≈ systemctl (Linux)
- Firewall (netsh) (Windows) ≈ ufw/firewalld/iptables/nft (Linux)

---

## Documentação Completa (Português‑BR)

### Índice
- [Visão geral](#visão-geral)
- [Como usar](#como-usar)
  - [Windows (Batch)](#windows-batch-1)
  - [Linux (Shell)](#linux-shell-1)
- [Menus](#menus-1)
  - [Menu do Windows](#menu-do-windows)
  - [Menu Linux](#menu-linux)
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
  - Linux: script Shell com menu numérico (1–24 + Q) oferecendo comandos de diagnóstico. Nota: A versão Linux está em desenvolvimento ativo com um conjunto de funcionalidades diferente.
- Registro:
  - Windows: registra cada comando executado em `support-tool.log` no diretório do script.
  - Linux: registra em `linux_suport_helper.log` no diretório do script.
- Prompts interativos:
  - Entradas de host quando necessário (ping, traceroute/tracert, pathping, nslookup/dig).
  - Confirmações para operações longas/elevadas (SFC/DISM no Windows).
- PowerShell no Windows para inventário de hardware e listagem de hotfix/eventos.

---

### Como usar

#### Windows (Batch)
1. Abra o Prompt de Comando (recomendado: “Executar como administrador” para SFC/DISM).
2. Execute o arquivo `.bat` na sua pasta; o menu será exibido.
3. Digite o número da opção (1–24) ou `Q` para sair.
4. As saídas aparecem na tela; comandos e horários são gravados em `support-tool.log`.

#### Linux (Shell)
Nota: A versão Linux está em desenvolvimento ativo.

1. Abra o Terminal. Para operações que exigem privilégios elevados, use `sudo` quando solicitado.
2. Torne o script executável: `chmod +x linux_suport_helper.sh`.
3. Execute o script: `./linux_suport_helper.sh`.
4. Digite o número da opção (1–24) ou `Q` para sair.
5. A saída é exibida na tela e registrada em `linux_suport_helper.log` no diretório do script.

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

#### Menu Linux
Nota: A versão Linux está em desenvolvimento ativo e atualmente implementa as seguintes funcionalidades:

1) Configuração de IP (ip addr) — `ip a`  
2) Limpar cache DNS (melhor esforço) — Vários métodos dependendo da configuração do sistema (systemd-resolve, resolvectl, rndc, nscd)  
3) Ping em host — `ping -c 6 <host>`  
4) Traceroute / tracepath — `traceroute <host>` ou `tracepath <host>` (se traceroute não disponível)  
5) Consulta DNS (dig/nslookup/host) — `dig <host>`, `nslookup <host>`, ou `host <host>` (dependendo da disponibilidade)  
6) Sockets em escuta — `ss -tulpn`  
7) Conexões TCP ativas — `ss -tan`  
8) Info do sistema (kernel/distro) — `uname -a` e `lsb_release -a` (se disponível)  
9) Inventário de hardware — `sudo lshw -short` ou combinação de `lscpu`, `lspci`, `lsusb`, `lsblk`  
10) Uso de disco — `df -h`  
11) Memória/swap — `free -h`  
12) Processos com maior uso de CPU — `ps -eo pid,cmd,%cpu,%mem --sort=-%cpu | head -20`  
13) Matar processo por PID — `sudo kill -9 <pid>`  
14) Serviços — `systemctl list-units --type=service --all` ou `service --status-all`  
15) Tabela de rotas — `ip route`  
16) Tabela ARP/vizinhos — `ip neigh`  
17) Qualidade do caminho — `sudo mtr -rw <host>` ou `tracepath <host>`  
18) Estatísticas de cache DNS — `resolvectl statistics` ou `systemd-resolve --statistics`  
19) Status do firewall — Vários comandos dependendo do sistema: `sudo ufw status verbose`, `sudo firewall-cmd --state`, `sudo iptables -L -n -v`, ou `sudo nft list ruleset`  
20) Montagens/compartilhamentos de rede — `mount | column -t`  
21) Pacotes instalados (resumo) — `dpkg -l | head -40` ou `rpm -qa | head -40`  
22) Erros recentes — `journalctl -p err -n 50`  
23) Syslog/messages (últimas linhas) — `tail -n 100 /var/log/syslog` ou `tail -n 100 /var/log/messages`  
24) Status de sincronização de tempo — `timedatectl` ou `date`  
Q) Sair — `q` ou `Ctrl+C`

---

### Entradas & Perguntas
- Solicitação de hostname/IP para testes de rede (ping, traceroute, nslookup/dig).
- Confirmação para operações longas/elevadas (Windows: SFC/DISM).
- Entrada de PID para terminação de processo.

---

### Registro
- Windows: Arquivo `support-tool.log` no diretório do script. Formato: `[data hora] <comando>` por execução.
- Linux: Arquivo `linux_suport_helper.log` no diretório do script. Formato: `[data hora] <comando>` por execução.

---

### Requisitos
- Windows:
  - PowerShell disponível (padrão no Windows moderno) para consultas de hardware/hotfix/eventos.
  - Direitos de administrador recomendados para SFC/DISM e algumas operações de serviço/firewall.
- Linux:
  - Nota: A versão Linux está em desenvolvimento ativo.
  - Pacotes recomendados variam por distribuição e funcionalidade usada: `traceroute`, `mtr`, `lshw`, `lsof`, `iw`, `nmcli`, `lsb-release`, ferramentas do `systemd` (`journalctl`, `systemd-resolve` ou `resolvectl`).
  - Use `sudo` para certos inventários e comandos de serviço.

---

### Observações
- Windows: SFC/DISM exigem Prompt de Comando elevado.
- Linux: A versão Linux está em desenvolvimento ativo. Alguns comandos variam por distribuição ou precisam de instalação; o script tenta detectar disponibilidade e sugerir alternativas.
- Testes de rede solicitam hostnames/IPs quando aplicável.
- PowerShell é chamado com `-NoProfile -ExecutionPolicy Bypass` para inventário, hotfixes e eventos (Windows).

---

### Aviso
Use por sua conta e risco. Revise os comandos antes de usar em ambientes de produção.

---

### Arquivos
- Script Batch para Windows — `windows_suport_helper.bat`
- Script Shell para Linux (em desenvolvimento) — `linux_suport_helper.sh`
- Arquivo de log do Windows — `support-tool.log`
- Arquivo de log do Linux — `linux_suport_helper.log`

---

### Mapas de Referência Rápida
Equivalentes Windows vs Linux (nota: versão Linux em desenvolvimento):
- Tracert (Windows) ≈ traceroute/tracepath (Linux)
- Pathping (Windows) ≈ mtr (Linux)
- Netstat (Windows) ≈ ss (Linux)
- Systeminfo (Windows) ≈ uname + lsb_release (Linux)
- Driverquery (Windows) ≈ lsmod/modinfo (Linux)
- Serviços (sc) (Windows) ≈ systemctl (Linux)
- Firewall (netsh) (Windows) ≈ ufw/firewalld/iptables/nft (Linux)

---
