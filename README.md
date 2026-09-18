# 🛠️ Universal Multi-Distro Linux Pre-Hardening Framework (Stage 1)

**Framework Architect:** Medardo Vega  
**Professional Title:** Self-Taught Linux Systems & SecOps Infrastructure Engineer  
**Profile Provenance:** [://github.com](https://://github.com)  
**Infrastructure Blueprint Standard:** PENTAGON LEVEL / FORTRESS SETUP TIER  

---

## ⚡ Core Operational Strategy

This repository houses the bare-metal bootstrap engine of the framework. Stage 1 operates entirely within live installation mediums or external deployment environments to carve out an un-falsifiable, cryptographically secured operating system foundation before the first system boot.

By translating manual, terminal-level systems engineering victories into automated Infrastructure-as-Code (IaC), this framework eliminates configuration drift and establishes immediate storage boundaries across **Arch Linux, Debian, Fedora, and openSUSE Tumbleweed**.

---

## 🧱 Architectural Hardening Capabilities

Stage 1 executes an aggressive, multi-layered partitioning and cryptographic strategy from the outside in:

* **Cryptographic Boundary Containment:** Wraps core system partitions inside high-security **LUKS2 containers** driven by hardware-optimized **Argon2id** key-derivation functions.
* **13-Subvolume Btrfs Storage Pool:** Slices your root filesystem pool into a complex, independent subvolume tree (including specialized `@swap`, `@log`, and `@cache` tracking targets) to isolate volatile data directories and stop local denial-of-service/storage exhaustion vectors natively.
* **Hidden Data Vault Controller:** Provisions an independent, encrypted secondary data partition mapped directly via a root-only random 32-byte keyfile signature (`/etc/secure/vault.key`). This features an automated mult-mount proof utility script (`vault open` / `vault close`) to ensure sensitive storage arrays are completely sealed from memory when not in use.
* **The Convenience Boot Guard:** Configures the system bootloader with an advanced `--unrestricted` class patch. Standard, day-to-day boot operations remain frictionless and prompt-free for authorized users, while manual kernel parameter manipulation attempts (`e`) are instantly locked by an administrative password wall.
* **Volatile Memory Optimization:** Automatically provisions a kernel-level compressed **LZ4 ZRAM storage pool** to prevent memory thrashing under heavy engineering workloads.
* **The Provenance Token Manifest:** Staps a permanent, machine-readable JSON certificate directly onto the encrypted drive blocks (`/etc/zero-trust-baseline.json`). This footprint authenticates your identity, professional title, and case-sensitive repository path before the partition tables are unmounted.

---

## 📊 Post-Install Verification & Posture Grading

The accompanying validation playbook (`Stage#1-Verification.yml`) functions as your continuous compliance auditor. It executes live shell scans directly against the hardware to verify that raw partition blocks and cryptographic signatures match your exact blueprint standard, automatically assigning a maturity ranking:

* **🥉 BRONZE LEVEL (FOUNDATION HARDENING ACTIVE):** Triggered when the validation engine successfully probes your raw disk blocks, matches the active `cryptroot` volume loop, and parses your verified `DlaVega504` identity token on the drive.
* **🥉 BRONZE LEVEL (FOUNDATION SIMULATION PASS):** Unlocked automatically during dry runs. It leverages built-in syntax simulation filters to validate code layout paths without risking state pollution on your host.

---

## 🛠️ Verified Engineering Toolkit

This framework is built upon a foundations of deep Linux internals combined with real-world operational security and offensive auditing tools:

* **Hardening & Storage Tools:** Btrfs Subvolume Architectures, LUKS1/LUKS2 Container Management, Snapper IaC Baseline Transaction Recovery Hooks, Systemd Core Units.
* **Automation Infrastructure:** Ansible Core, Jinja2 Variable Synthesis, Bash Automation Shell Wrappers (`deploy.sh`).
* **SecOps Auditing Foundations:** Wireless network boundary auditing (packet capturing, 4-way handshake manipulation, and hash decryption using `mdk4`, `aircrack-ng`, `hashcat`), web application authentication vulnerabilities (`wpscan` user enumeration and credential brute-forcing), and local mapping via `nmap`.

---

## 🚀 Execution and Pre-Flight Validation Strings

Both playbooks feature absolute check-mode fencing. Test your deployment files with zero risk to your live environment using these exact command strings:

```bash
# Execute Dry-Run Syntax Pass for the Stage 1 Installation Blueprint
ansible-playbook -i hosts Stage#1-Pre-Hardening.yml --check -K

# Execute Dry-Run Simulation Pass for the Stage 1 Post-Install Auditor
ansible-playbook -i hosts Stage#1-Verification.yml --check -K
```

---
*“The ultimate test of knowledge isn't a classroom certificate—it's production-grade code that works when the system is under pressure.”*

