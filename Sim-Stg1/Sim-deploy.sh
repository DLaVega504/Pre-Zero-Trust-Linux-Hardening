#!/usr/bin/env bash
# =========================================================================
# PRE-ZERO-TRUST HARDENING: INTERACTIVE SANDBOX DEPLOYMENT MANAGER
# =========================================================================
set -eo pipefail

# 1. ENFORCE ROOT SYSTEM ACCESS FOR STORAGE MOUNT HOOKS
if [ "$EUID" -ne 0 ]; then
    echo "[-] CRITICAL ERROR: Superuser privilege credentials required ($EUID found)." >&2
    echo "    Please re-execute using: sudo ./Sim-deploy.sh" >&2
    exit 1
fi

clear
echo "==========================================================================="
echo "        PRE-ZERO-TRUST BARE-METAL INFRASTRUCTURE SIMULATION ENGINE         "
echo "==========================================================================="
echo " RUNNING PROFILE: VIRTUAL INTERACTIVE SANDBOX"
echo " WORKING TARGET.: Isolated 75 GB /tmp/sim_disk.img Storage Matrix"
echo " ENVIRONMENT....: 100% Interactive Sub-Chamber Prompts Active"
echo "==========================================================================="
echo ""

# 2. AUTOMATED HOST DEPENDENCY INJECTION MATRIX (sgdisk, pacstrap, debootstrap)
echo "[+] HOST AUDIT: Verifying local system architecture prerequisites..."
if command -v pacman &> /dev/null; then
    # Host is Arch Linux: Ensure gdisk, arch-install-scripts, and debootstrap exist
    pacman -Sy --needed --noconfirm gptfdisk arch-install-scripts debootstrap
elif command -v apt-get &> /dev/null; then
    # Host is Debian/Ubuntu: Ensure gdisk and debootstrap exist
    apt-get update && apt-get install -y gdisk debootstrap
elif command -v dnf &> /dev/null; then
    # Host is Fedora/RHEL: Ensure gdisk and debootstrap exist
    dnf install -y gdisk debootstrap
elif command -v zypper &> /dev/null; then
    # Host is openSUSE: Ensure gptfdisk and debootstrap exist
    zypper --non-interactive install gptfdisk debootstrap
else
    echo "[!] WARNING: Unknown host package manager. Ensure gdisk/debootstrap are present." >&2
fi

# 3. FORCE INTEGRITY TEARDOWN OF STALE SYSTEM STATES BEFORE EACH RUN
echo "[+] Sweeping and purging dangling cryptographic device contexts..."
sudo umount -R /mnt/target 2>/dev/null || true
sudo umount -R /mnt/staging_root 2>/dev/null || true
sudo cryptsetup close cryptroot 2>/dev/null || true
sudo cryptsetup close secure_vault 2>/dev/null || true

# 4. HYDRO-AUTHENTICATION DAEMON SIMULATION RESILIENCE
echo "[+] Hydrating administrative token ring context..."
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# 5. TRIGGER LOCALIZED SIMULATION PIPELINE
echo "[+] Launching Stage 1 Core Provisioning Playbook..."
ansible-playbook -i hosts Sim-Stage#1-Pre-Hardening.yml --connection=local -e "force_simulation=true"

echo ""
echo "[+] Launching Autonomous Substrate Post-Install Security Audit..."
ansible-playbook -i hosts ../Stage#1-Verification.yml --connection=local

echo ""
echo "==========================================================================="
echo "             STAGE 1 SIMULATION RUN COMPLETE - ALL SAFE                    "
echo "==========================================================================="

