#!/usr/bin/env bash
# =========================================================================
# SYSTEM BOOTSTRAP AUTO-RUNNER FOR UNIVERSAL PRE-HARDENING STAGE 1
# =========================================================================
set -e

# Ensure the execution environment is a root context
if [ "$EUID" -ne 0 ]; then
    echo "[-] ERROR: This bootstrap configuration script must be run as root (sudo)." >&2
    exit 1
fi

echo "[+] Detecting host live environment distribution tracking layers..."
if [ -f /etc/os-release ]; then
    . /etc/os-release
    HOST_OS=$ID
    HOST_LIKE=$ID_LIKE
else
    echo "[-] FATAL: /etc/os-release tracking parameters missing from media." >&2
    exit 1
fi

echo "[+] Host OS Identified: $HOST_OS"

# Synchronize host storage packages and deploy the core engine
case "$HOST_OS" in
    arch|archlinux)
        echo "[+] Tooling: Synchronizing pacman packages on Arch live platform..."
        pacman -Sy --noconfirm --needed ansible-core arch-install-scripts debootstrap parted cryptsetup btrfs-progs
        ;;
    debian|ubuntu)
        echo "[+] Tooling: Synchronizing apt packages on Debian/Ubuntu live platform..."
        apt-get update
        apt-get install -y ansible debootstrap parted cryptsetup btrfs-progs arch-install-scripts git make
        ;;
    fedora)
        echo "[+] Tooling: Synchronizing dnf packages on Fedora live platform..."
        dnf install -y ansible debootstrap parted cryptsetup btrfs-progs arch-install-scripts git make
        ;;
    opensuse*|suse)
        echo "[+] Tooling: Synchronizing zypper packages on openSUSE live platform..."
        zypper refresh
        zypper install -y ansible debootstrap parted cryptsetup btrfs-progs arch-install-scripts git make
        ;;
    *)
        # Fallback tracking logic for system variations
        if [[ "$HOST_LIKE" == *"debian"* ]]; then
            apt-get update && apt-get install -y ansible debootstrap parted cryptsetup btrfs-progs arch-install-scripts
        elif [[ "$HOST_LIKE" == *"rhel"* || "$HOST_LIKE" == *"fedora"* ]]; then
            dnf install -y ansible debootstrap parted cryptsetup btrfs-progs arch-install-scripts
        else
            echo "[-] FATAL: Live environment distribution matrix support unavailable." >&2
            exit 1
        fi
        ;;
esac

echo "[+] Success: Host deployment engine is fully hydrated with required tools."
echo "[+] Starting local Ansible orchestration loop..."

# Execute the playbook using the standard fallback password prompt
ansible-playbook -i hosts.ini Universal-Linux-PreHardening.yml --ask-become-pass

