#!/usr/bin/env bash
# =========================================================================
# SYSTEM EXCLUSIVE HYBRID LOCAL/REMOTE DEPLOYMENT MANAGER (STAGE 1 COMPLETE)
# =========================================================================
set -eo pipefail

# 1. ENFORCE ROOT CONTEXT FOR LOCAL ORCHESTRATION TASKS
if [ "$EUID" -ne 0 ]; then
    echo "[-] CRITICAL ERROR: Superuser privilege credentials required ($EUID found)." >&2
    echo "    Please re-execute using: sudo ./deploy.sh" >&2
    exit 1
fi

clear
echo "==========================================================================="
echo "        PRE-FLIGHT DEPENDENCY ENGINE: CHECKING ISO ENVIRONMENT              "
echo "==========================================================================="

# Detect host distribution type cleanly
if [ -f /etc/arch-release ] || grep -q -i "arch" /etc/os-release 2>/dev/null; then
    HOST_DISTRO="Archlinux"
elif grep -q -i "debian" /etc/os-release 2>/dev/null; then
    HOST_DISTRO="Debian"
elif grep -q -i "fedora" /etc/os-release 2>/dev/null; then
    HOST_DISTRO="RedHat"
elif grep -q -i "suse" /etc/os-release 2>/dev/null; then
    HOST_DISTRO="Suse"
else
    HOST_DISTRO="Unknown"
fi

echo "[+] Detected live orchestration host tracking profile: $HOST_DISTRO"

# Automatically update and install missing engine tools into the live environment's RAM
if ! command -v ansible-playbook >/dev/null 2>&1; then
    echo "[!] WARNING: Ansible orchestration binaries missing from live environment memory rings."
    echo "[+] Hydrating live node framework with dependencies..."
    
    if [ "$HOST_DISTRO" = "Archlinux" ]; then
        pacman -Sy --noconfirm
        pacman -S --noconfirm --needed python python-pip gptfdisk ansible
    elif [ "$HOST_DISTRO" = "Debian" ]; then
        apt-get update -y
        apt-get install -y ansible python3 python3-pip gdisk
    elif [ "$HOST_DISTRO" = "RedHat" ]; then
        dnf install -y ansible python3 python3-pip gdisk --nogpgcheck
    elif [ "$HOST_DISTRO" = "Suse" ]; then
        zypper --non-interactive install ansible python3 python3-pip gptfdisk
    fi
else
    echo "[✔] Framework tools, Python compilers, and execution binaries verified active."
fi

# 2. INTERACTIVE DEPLOYMENT INTERFACE
clear
echo "==========================================================================="
echo "          PRE-ZERO-TRUST BARE-METAL INFRASTRUCTURE IaC ENGINE              "
echo "==========================================================================="
echo "  Target Distributions: Arch Linux, Debian, Fedora, openSUSE Tumbleweed"
echo "==========================================================================="
echo ""
echo "Select Deployment Execution Mode Channel:"
echo "  1. Local Physical Installation (This Machine)"
echo "  2. Remote Network Over-the-Air Installation"
echo ""
read -rp "[?] Enter selection number (1 or 2) [Default: 1]: " EXEC_MODE
EXEC_MODE=${EXEC_MODE:-1}

# 3. CACHE VALID SUDO CREDENTIALS TO PREVENT TIMEOUT FREEZING
echo "[+] Hydrating administrative token ring context..."
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# 4. ROUTE PLAYBOOK INVOCATIONS MATCHING ENVIROMENT STRATEGY
case "$EXEC_MODE" in
    1)
        echo ""
        echo "[+] Initializing Local Physical Staging Engine Loop..."
        echo "[+] Launching Stage 1 Core Provisioning Playbook..."
        ansible-playbook -i hosts Stage#1-Pre-Hardening.yml --connection=local

        echo ""
        echo "[+] Launching Autonomous Substrate Post-Install Security Audit..."
        ansible-playbook -i hosts Stage#1-Verification.yml --connection=local
        ;;
    2)
        echo ""
        echo "[+] Initializing Remote Network Over-the-Air Deployment Channel..."
        echo "[!] Ensure targets are active and ssh-keys are cached inside 'hosts'."
        echo "[+] Launching Stage 1 Core Provisioning Playbook..."
        ansible-playbook -i hosts Stage#1-Pre-Hardening.yml -l remote_targets -K

        echo ""
        echo "[+] Launching Autonomous Substrate Post-Install Security Audit..."
        ansible-playbook -i hosts Stage#1-Verification.yml -l remote_targets -K
        ;;
    *)
        echo "[-] ERROR: Invalid execution target selection boundary parameters." >&2
        exit 1
        ;;
esac

echo ""
echo "==========================================================================="
echo "             STAGE 1 DEPLOYMENT PIPELINE ENVELOPE FINISHED                 "
echo "==========================================================================="
echo " [✔] If all audit metrics present a clean success card verification matrix:"
echo "     You are ready to issue the terminal command: sudo reboot"
echo "==========================================================================="

