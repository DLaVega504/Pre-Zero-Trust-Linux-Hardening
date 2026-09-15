#!/usr/bin/env bash
# =========================================================================
# UNIVERSAL SYSTEM BOOTSTRAP AUTO-RUNNER (STAGE 1 INTEGRATED WRAPPER)
# =========================================================================
set -eo pipefail

# 1. ENFORCE ADMINISTRATIVE PRIVILEGES
if [ "$EUID" -ne 0 ]; then
    echo "[-] ERROR: This core configuration bootstrap must be run under root context (sudo)." >&2
    exit 1
fi

# 2. DYNAMIC HOST DISTRIBUTION RESOLUTION
echo "[+] Probing live media system tracking metadata layers..."
if [ -f /etc/os-release ]; then
    . /etc/os-release
    HOST_OS=$ID
    HOST_LIKE=$ID_LIKE
else
    echo "[-] FATAL ERROR: /etc/os-release parameter array missing from deployment media." >&2
    exit 1
fi

echo "[+] Target Host Environment Core OS Identified: ${HOST_OS^^}"

# 3. HYDRATE THE LOCAL CONNECTION PACKAGE SUITE NATIVELY
case "$HOST_OS" in
    arch|archlinux)
        echo "[+] Tooling Matrix: Synchronizing pacman catalogs on Arch Linux core..."
        pacman -Sy --noconfirm --needed ansible-core arch-install-scripts debootstrap parted cryptsetup btrfs-progs python
        ;;
    debian|ubuntu)
        echo "[+] Tooling Matrix: Hydrating apt dependency matrices on Debian core..."
        export DEBIAN_FRONTEND=noninteractive
        apt-get update
        apt-get install -y ansible debootstrap parted cryptsetup btrfs-progs arch-install-scripts git make python3
        ;;
    fedora)
        echo "[+] Tooling Matrix: Processing dnf package layers on Fedora core..."
        dnf install -y ansible debootstrap parted cryptsetup btrfs-progs arch-install-scripts git make python3
        ;;
    opensuse*|suse|sles)
        echo "[+] Tooling Matrix: Re-indexing zypper database maps on openSUSE core..."
        zypper --non-interactive refresh
        zypper --non-interactive install -y ansible debootstrap parted cryptsetup btrfs-progs arch-install-scripts git make python3
        ;;
    *)
        # Structural fallback routing matrix for variations
        if [[ "$HOST_LIKE" == *"debian"* ]]; then
            export DEBIAN_FRONTEND=noninteractive
            apt-get update && apt-get install -y ansible debootstrap parted cryptsetup btrfs-progs arch-install-scripts python3
        elif [[ "$HOST_LIKE" == *"rhel"* || "$HOST_LIKE" == *"fedora"* ]]; then
            dnf install -y ansible debootstrap parted cryptsetup btrfs-progs arch-install-scripts python3
        else
            echo "[-] FATAL ERROR: Host storage distribution tracking model unsupported." >&2
            exit 1
        fi
        ;;
esac

echo "[+] Success: Local environment is fully optimized and hydrated with required dependencies."
echo "[+] Initializing localized storage parameter safety cache structures..."

# 4. PRE-AUTHENTICATE THE PRIVILEGE ELEVATION ESCALATION HOOKS
# This caches permissions natively inside the active terminal execution pipeline space,
# ensuring Ansible passes through fact gathering without halting for password strings.
sudo -v

echo "[+] Executing Stage 1 Core Provisioning Orchestration Framework..."
# Enforces native connection controls directly via the wrapper runner execution call
ansible-playbook -i hosts.ini Universal-Linux-PreHardening.yml --connection=local

echo "[+] ==========================================================================="
echo "[+]                STAGE 1 DEPLOYMENT AUTOMATION COMPLETE                      "
echo "[+] ==========================================================================="
echo "[+] The underlying hardware framework layer has been successfully provisioned. "
echo "[+] Before issuing a system reboot, you may execute your tracking audit pass:   "
echo "[+] --> ansible-playbook -i hosts.ini Verification-Stage1.yml                  "

