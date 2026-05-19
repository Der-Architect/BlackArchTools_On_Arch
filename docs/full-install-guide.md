# Full BlackArch Installation Guide for Arch-Based Linux

> **Educational / authorized use only.** Use BlackArch tools only on systems, networks, and data you own or are explicitly permitted to test.

This document provides a more complete guide for adding the BlackArch repository to an Arch-based Linux system and installing all available BlackArch packages as reliably as possible.

## Before you start

Make sure you have:

- An Arch Linux or Arch-based Linux installation
- `sudo` privileges
- Stable internet access
- Enough free disk space for a very large package set
- A fully updated base system

## Step 1: Fully update the system

```bash
sudo pacman -Syu
```

If major core packages changed, reboot once and update again:

```bash
sudo reboot
sudo pacman -Syu
```

## Step 2: Enable multilib if required

Edit `/etc/pacman.conf` and ensure:

```ini
[multilib]
Include = /etc/pacman.d/mirrorlist
```

Then refresh:

```bash
sudo pacman -Syu
```

## Step 3: Download and verify `strap.sh`

```bash
curl -O https://blackarch.org/strap.sh
echo 00688950aaf5e5804d2abebb8d3d3ea1d28525ed strap.sh | sha1sum -c
chmod +x strap.sh
```

If checksum verification fails, stop and re-download.

## Step 4: Add the BlackArch repository

```bash
sudo ./strap.sh
```

## Step 5: Refresh package databases

```bash
sudo pacman -Syyu
```

## Step 6: Confirm repository availability

```bash
sudo pacman -Sg | grep blackarch
sudo pacman -Sgg | grep blackarch | cut -d' ' -f2 | sort -u | wc -l
```

## Step 7: Install the full BlackArch group

```bash
sudo pacman -S blackarch
```

If conflicts occur:

```bash
sudo pacman -Syyu --needed --overwrite='*' blackarch
```

## Step 8: Fallback full package-list install

```bash
sudo pacman -Sgg | grep blackarch | cut -d' ' -f2 | sort -u > blackarch-package-list.txt
cat blackarch-package-list.txt | xargs -r sudo pacman -S --needed --overwrite='*'
```

## Category-based install examples

Instead of everything, you can install by category.

List categories:

```bash
sudo pacman -Sg | grep blackarch
```

Examples:

```bash
sudo pacman -S blackarch-webapp
sudo pacman -S blackarch-networking
sudo pacman -S blackarch-reversing
sudo pacman -S blackarch-forensic
sudo pacman -S blackarch-wireless
sudo pacman -S blackarch-exploitation
sudo pacman -S blackarch-malware
sudo pacman -S blackarch-crypto
```

## Troubleshooting

### Keyring issues

```bash
sudo pacman-key --init
sudo pacman-key --populate archlinux blackarch
sudo pacman -Syyu
```

### File conflicts

```bash
sudo pacman -Syyu --needed --overwrite='*' blackarch
```

### Mirror or database sync problems

```bash
sudo pacman -Syy
```

### Low disk space

```bash
df -h
```

### Install in batches to isolate failures

```bash
split -l 50 blackarch-package-list.txt blackarch-batch-
for f in blackarch-batch-*; do
  echo "Installing $f"
  cat "$f" | xargs -r sudo pacman -S --needed --overwrite='*'
done
```

## Verification

```bash
pacman -Qs blackarch
pacman -Sg | grep blackarch
pacman -Q <package_name>
```

## Reality check

Installing all BlackArch packages is often unnecessary. A better approach for most users is:

1. Add the repository
2. Install only the categories you need
3. Keep the system updated

```bash
sudo pacman -Syu
```
