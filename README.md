# BlackArchTools_On_Arch

![Platform](https://img.shields.io/badge/platform-Arch%20Linux-blue)
![Repo status](https://img.shields.io/badge/status-active-brightgreen)
![License](https://img.shields.io/badge/license-not%20specified-lightgrey)
![Docs](https://img.shields.io/badge/docs-available-blueviolet)

> **Educational / authorized use only.** Use BlackArch tools only on systems, networks, and data you own or are explicitly permitted to test. Misuse may be illegal and unethical.

A practical guide for adding the BlackArch repository to an Arch-based Linux system and installing the available BlackArch packages as reliably as possible.

## What this repository provides

- A straightforward BlackArch installation guide for Arch-based Linux
- A safer full-install workflow
- Recovery steps for common `pacman`, mirror, signature, and conflict problems
- Quick commands for users who already know what they are doing
- Links to fuller documentation and verification steps

## Quick start

```bash
sudo pacman -Syu
curl -O https://blackarch.org/strap.sh
echo 00688950aaf5e5804d2abebb8d3d3ea1d28525ed strap.sh | sha1sum -c
chmod +x strap.sh
sudo ./strap.sh
sudo pacman -Syyu
sudo pacman -S --needed --overwrite='*' blackarch
```

## More documentation

- Full guide: `docs/full-install-guide.md`
- Verification script: `scripts/verify-blackarch-install.sh`

## Important note

No guide can honestly guarantee a **100% no-fail install of every BlackArch package** at all times. Upstream package changes, mirror lag, keyring issues, broken dependencies, local system state, disk space, and network problems can all affect results.

This repository is written to maximize success on a fully updated Arch-based system.

## Category-based installation examples

List categories:

```bash
sudo pacman -Sg | grep blackarch
```

Install a specific category:

```bash
sudo pacman -S blackarch-<category>
```

Examples:

```bash
sudo pacman -S blackarch-webapp
sudo pacman -S blackarch-networking
sudo pacman -S blackarch-reversing
sudo pacman -S blackarch-forensic
sudo pacman -S blackarch-crypto
```

## Disclaimer and ethical use

This repository and guide are for:

- security research
- lab environments
- defensive testing
- education
- authorized penetration testing

Do **not** use these tools against systems or services without explicit permission.
