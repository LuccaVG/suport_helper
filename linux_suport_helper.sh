#!/usr/bin/env bash
set -euo pipefail

LOG="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/linux_suport_helper.log"

logrun() {
  echo "[$(date '+%F %T')] $*" >>"$LOG"
}

cmd_exists() {
  command -v "$1" >/dev/null 2>&1
}

pause() {
  read -rp "Press Enter to continue..." _
}

while true; do
  clear
  cat <<'EOF'
================================
  Linux Support Helper (1-24)
================================
 1) IP config (ip addr)
 2) Flush DNS cache (best effort)
 3) Ping host
 4) Traceroute / tracepath
 5) DNS lookup (dig/nslookup/host)
 6) Listening sockets (ss -tulpn)
 7) Active TCP (ss -tan)
 8) System info (kernel/distro)
 9) Hardware inventory (lshw/lspci/lsusb/lscpu)
10) Disk usage (df -h)
11) Memory/swap (free -h)
12) Top CPU procs (ps sorted)
13) Kill process by PID
14) Services (systemctl/service)
15) Route table (ip route)
16) ARP/neighbor table (ip neigh)
17) Path quality (mtr/tracepath)
18) DNS cache stats (resolvectl/systemd-resolve)
19) Firewall status (ufw/firewall-cmd/iptables/nft)
20) Network mounts/shares (mount)
21) Installed packages (summary)
22) Recent errors (journalctl -p err -n 50)
23) Syslog/messages tail (100 lines)
24) Time sync status (timedatectl)
 Q) Quit
EOF
  read -rp "Select (1-24 or Q): " opt
  case "$opt" in
    [Qq]) echo "Log: $LOG"; exit 0 ;;
    1)
      logrun ip a
      ip a
      pause
      ;;
    2)
      echo "Flushing DNS cache (best effort)..."
      if cmd_exists systemd-resolve; then
        logrun sudo systemd-resolve --flush-caches
        sudo systemd-resolve --flush-caches
      elif cmd_exists resolvectl; then
        logrun sudo resolvectl flush-caches
        sudo resolvectl flush-caches
      elif cmd_exists rndc; then
        logrun sudo rndc flush
        sudo rndc flush
      elif systemctl is-active --quiet nscd 2>/dev/null; then
        logrun sudo systemctl restart nscd
        sudo systemctl restart nscd
      else
        echo "No known DNS cache service detected to flush."
      fi
      pause
      ;;
    3)
      read -rp "Host/IP to ping: " host
      [[ -z "${host:-}" ]] && continue
      logrun ping -c 6 "$host"
      ping -c 6 "$host"
      pause
      ;;
    4)
      read -rp "Host/IP to trace: " host
      [[ -z "${host:-}" ]] && continue
      if cmd_exists traceroute; then
        logrun traceroute "$host"
        traceroute "$host"
      else
        logrun tracepath "$host"
        tracepath "$host"
      fi
      pause
      ;;
    5)
      read -rp "Hostname to query (default example.com): " host
      host="${host:-example.com}"
      if cmd_exists dig; then
        logrun dig "$host"
        dig "$host"
      elif cmd_exists nslookup; then
        logrun nslookup "$host"
        nslookup "$host"
      else
        logrun host "$host"
        host "$host"
      fi
      pause
      ;;
    6)
      logrun ss -tulpn
      ss -tulpn
      pause
      ;;
    7)
      logrun ss -tan
      ss -tan
      pause
      ;;
    8)
      logrun "uname -a && lsb_release -a (if available)"
      uname -a
      if cmd_exists lsb_release; then lsb_release -a; else echo "lsb_release not available"; fi
      pause
      ;;
    9)
      echo "Hardware inventory (may need sudo)..."
      if cmd_exists lshw; then
        logrun sudo lshw -short
        sudo lshw -short
      else
        if cmd_exists lscpu; then logrun lscpu; lscpu; fi
        if cmd_exists lspci; then logrun lspci; lspci; fi
        if cmd_exists lsusb; then logrun lsusb; lsusb; fi
        if cmd_exists lsblk; then logrun lsblk; lsblk; fi
      fi
      pause
      ;;
    10)
      logrun df -h
      df -h
      pause
      ;;
    11)
      logrun free -h
      free -h
      pause
      ;;
    12)
      logrun "ps -eo pid,cmd,%cpu,%mem --sort=-%cpu | head -20"
      ps -eo pid,cmd,%cpu,%mem --sort=-%cpu | head -20
      pause
      ;;
    13)
      read -rp "PID to kill: " pid
      [[ -z "${pid:-}" ]] && continue
      logrun sudo kill -9 "$pid"
      sudo kill -9 "$pid"
      pause
      ;;
    14)
      if cmd_exists systemctl; then
        logrun systemctl list-units --type=service --all
        systemctl list-units --type=service --all
      else
        logrun service --status-all
        service --status-all
      fi
      pause
      ;;
    15)
      logrun ip route
      ip route
      pause
      ;;
    16)
      logrun ip neigh
      ip neigh
      pause
      ;;
    17)
      read -rp "Host/IP to test (mtr/tracepath): " host
      [[ -z "${host:-}" ]] && continue
      if cmd_exists mtr; then
        logrun sudo mtr -rw "$host"
        sudo mtr -rw "$host"
      else
        logrun tracepath "$host"
        tracepath "$host"
      fi
      pause
      ;;
    18)
      if cmd_exists resolvectl; then
        logrun resolvectl statistics
        resolvectl statistics
      elif cmd_exists systemd-resolve; then
        logrun systemd-resolve --statistics
        systemd-resolve --statistics
      else
        echo "No resolvectl/systemd-resolve available for DNS cache stats."
      fi
      pause
      ;;
    19)
      if cmd_exists ufw; then
        logrun sudo ufw status verbose
        sudo ufw status verbose
      elif cmd_exists firewall-cmd; then
        logrun sudo firewall-cmd --state
        sudo firewall-cmd --state
        logrun sudo firewall-cmd --list-all
        sudo firewall-cmd --list-all
      elif cmd_exists iptables; then
        logrun sudo iptables -L -n -v
        sudo iptables -L -n -v
      elif cmd_exists nft; then
        logrun sudo nft list ruleset
        sudo nft list ruleset
      else
        echo "No firewall tooling detected."
      fi
      pause
      ;;
    20)
      logrun mount
      mount | column -t
      pause
      ;;
    21)
      if cmd_exists dpkg; then
        logrun "dpkg -l | head -40"
        dpkg -l | head -40
      elif cmd_exists rpm; then
        logrun "rpm -qa | head -40"
        rpm -qa | head -40
      else
        echo "No dpkg/rpm package manager detected."
      fi
      pause
      ;;
    22)
      if cmd_exists journalctl; then
        logrun journalctl -p err -n 50
        journalctl -p err -n 50
      else
        echo "journalctl not available."
      fi
      pause
      ;;
    23)
      if [[ -f /var/log/syslog ]]; then
        logrun "tail -n 100 /var/log/syslog"
        tail -n 100 /var/log/syslog
      elif [[ -f /var/log/messages ]]; then
        logrun "tail -n 100 /var/log/messages"
        tail -n 100 /var/log/messages
      else
        echo "No syslog/messages file found."
      fi
      pause
      ;;
    24)
      if cmd_exists timedatectl; then
        logrun timedatectl
        timedatectl
      else
        logrun date
        date
      fi
      pause
      ;;
    *)
      echo "Invalid choice."
      pause
      ;;
  esac
done
