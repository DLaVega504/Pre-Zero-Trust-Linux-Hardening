### Universal Interactive Turn-Key Linux Pre-Hardening Framework (Stage 1)

A foundational system orchestration framework designed to deploy an advanced, fully encrypted base storage architecture prior to applying active host-hardening policies. This framework guarantees raw partition security, builds optimized volume management layers, and prepares the operational substrate across **Arch Linux**, **Debian**, **Fedora**, and **openSUSE** deployment targets. 

### 🚀 Purpose & Architecture

This framework establishes physical and foundational data security from a clean slate or fresh install scenario. It focuses strictly on storage layout containment, cryptographic volume constraints, and system bootstrap preparation. 

### Core Foundation Layers

* **Layer 1: Partition & Hard Drive Layout** — Structures raw hardware devices, establishing primary, boot, and extended operational boundaries cleanly.
* **Layer 2: Cryptographic Containerization (LUKS)** — Provisions robust, full-disk encryption algorithms (utilizing argon2id iterations) to safeguard raw data layers from physical extraction attempts.
* **Layer 3: Logical Volume Management (LVM)** — Abstracts the underlying encrypted space into isolated, dynamically resizable volume pools to optimize resource tracking.
* **Layer 4: Advanced Subvolume Hierarchy** — Establishes secure storage containment parameters, including granular tracking paths like @secure=/vault for absolute host containment.
* **Layer 5: Hybrid Memory Allocation** — Calculates and mounts standardized system swap layers aligned with custom biometric guidelines (RAM < 8GB maps to RAM × 2; RAM ≥ 8GB maps to RAM × 1.5).

### 📋 System Blueprint & Storage Layout

Stage 1 maps out strict partition boundaries on physical hardware arrays (e.g., your primary hard drive /dev/sda) to balance boot validation compatibility with data isolation rules: 

### Standard Hardware Allocation

1. **/dev/sda1 (Secure Boot Bootloader)** — A 1GB standalone, password-protected /boot layout paired with custom bootloader markers (grub-mkpasswd) for structural authentication.
2. **/dev/sda2 (Encrypted Core Partition)** — The primary workspace containing an encapsulated LUKS container which unifies your system volumes, subvolumes, and swap assets under a single master boot passphrase challenge.
3. **/dev/sda3 (Sensitive Data Vault)** — An optional, completely detached 30GB storage vault or secondary partition block dedicated entirely to containing independent cryptographic keys and high-security file trees.

### 🛠️ Usage & Verification Protocols

### Privilege Escalation Requirement

Because this framework orchestrates low-level storage modifications natively on localhost, **you must append the --ask-become-pass (or -K) flag** to every execution command. This explicitly satisfies your local host runner's sudo privileges independently from the interactive asset passphrases gathered inside the playbook task loop. Recent versions of the Ansible core engine enforce strict process detachment when executing locally, meaning cached host credentials are bypassed. 

### 1. Pre-Flight Storage Check (Simulation Mode)

Before simulating block modifications or initializing filesystems on raw hardware devices, validate playbook structural paths, drive identification strings, and variable logic arrays: 

bash

ansible-playbook -i hosts.ini Universal-Linux-PreHardening.yml --check --ask-become-pass --skip-tags=integrity

Use code with caution.

* *Caution: Dry-running tasks that manage raw disks or disk partitioning configurations will skip underlying filesystem writes, allowing safe structure parsing checks before commit loops.*

### 2. Live Bootstrapping Initialization

To permanently commit partition sectors, execute cryptographic containerization scripts, and mount target filesystem hierarchies on deployment hosts: 

bash

ansible-playbook -i hosts.ini Universal-Linux-PreHardening.yml --ask-become-pass

Use code with caution.

### 📋 Interactive Prompt Input Sequence

When you launch the command script, your terminal window will process input strings in this exact chronological matrix: 

1. **BECOME password:** Enter your **local executing machine's standard sudo password** to unlock the process loop.
2. **[?] Enter target disk...** Input your physical block storage identifier path (e.g., /dev/sda).
3. **[?] Enter secure vault sizing...** Input the target size parameter for the decoupled data vault.
4. **Secure Hidden Prompts:** Provide your newly desired LUKS passphrases, root credentials, and target user account data. The terminal will intentionally suppress mirroring your typed characters or cursor movements for absolute security.

### 🔄 Next Steps in the Lifecycle

Once Stage 1 successfully completes and verifies your baseline storage encryption architecture, the system is prepared to pass control cleanly onto the next phase of deployment: 

* **Stage 1 (This Step):** Physical boundary layout, LUKS container construction, and volume mapping.
* **Stage 2 (Next Step):** Automated execution of your **Universal Zero-Trust Linux Hardening Framework** to apply kernel optimization baselines, host daemon shielding, and defensive system configurations.
