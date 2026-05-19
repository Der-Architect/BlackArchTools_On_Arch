# BlackArchTools_On_Arch

> **Educational / authorized use only.** Use BlackArch tools only on systems, networks, and data you own or are explicitly permitted to test. Misuse may be illegal and unethical.

A practical guide for adding the BlackArch repository to an Arch-based Linux system and installing the available BlackArch packages as reliably as possible.

## What this repository provides

- A straightforward BlackArch installation guide for Arch-based Linux
- A safer full-install workflow
- Recovery steps for common `pacman`, mirror, signature, and conflict problems
- Quick commands for users who already know what they are doing

## Important note

No guide can honestly guarantee a **100% no-fail install of every BlackArch package** at all times. Upstream package changes, mirror lag, keyring issues, broken dependencies, local system state, disk space, and network problems can all affect results.

This README is written to maximize success on a fully updated Arch-based system.

---

## Recommended approach

If you do **not** truly need every package, install only the categories you need:

```bash
sudo pacman -Sg | grep blackarch
sudo pacman -S blackarch-<category>
```

If you still want the full toolset, use the procedure below.

## Requirements

Before starting, make sure you have:

- An Arch Linux or Arch-based Linux system
- `sudo` privileges
- Stable internet access
- Plenty of free disk space
- An updated base system
- `multilib` enabled if required by your setup

## Step 1: Update the base system

```bash
sudo pacman -Syu
```

If major packages were updated, reboot once:

```bash
sudo reboot
```

Then update again:

```bash
sudo pacman -Syu
```

## Step 2: Enable `multilib` if needed

In `/etc/pacman.conf`, ensure this section is enabled:

```ini
[multilib]
Include = /etc/pacman.d/mirrorlist
```

Then refresh:

```bash
sudo pacman -Syu
```

## Step 3: Download and verify the BlackArch bootstrap script

```bash
curl -O https://blackarch.org/strap.sh
echo 00688950aaf5e5804d2abebb8d3d3ea1d28525ed strap.sh | sha1sum -c
chmod +x strap.sh
```

If checksum verification fails, do **not** continue.

## Step 4: Add the BlackArch repository

```bash
sudo ./strap.sh
```

If keyring issues appear later, run:

```bash
sudo pacman-key --init
sudo pacman-key --populate archlinux blackarch
```

## Step 5: Force-refresh package databases

```bash
sudo pacman -Syyu
```

## Step 6: Confirm BlackArch is visible

```bash
sudo pacman -Sg | grep blackarch
sudo pacman -Sgg | grep blackarch | cut -d' ' -f2 | sort -u | wc -l
```

## Step 7: Install all BlackArch packages

Try the normal group install first:

```bash
sudo pacman -S blackarch
```

If conflicts block installation, use:

```bash
sudo pacman -Syyu --needed --overwrite='*' blackarch
```

## Step 8: Fallback method if the group install is incomplete

```bash
sudo pacman -Sgg | grep blackarch | cut -d' ' -f2 | sort -u > blackarch-package-list.txt
cat blackarch-package-list.txt | xargs -r sudo pacman -S --needed --overwrite='*'
```

If you need to isolate failures in smaller batches:

```bash
split -l 50 blackarch-package-list.txt blackarch-batch-
for f in blackarch-batch-*; do
  echo "Installing $f"
  cat "$f" | xargs -r sudo pacman -S --needed --overwrite='*'
done
```

---

## Quick install

```bash
sudo pacman -Syu
curl -O https://blackarch.org/strap.sh
echo 00688950aaf5e5804d2abebb8d3d3ea1d28525ed strap.sh | sha1sum -c
chmod +x strap.sh
sudo ./strap.sh
sudo pacman -Syyu
sudo pacman -S --needed --overwrite='*' blackarch
```

---

## Troubleshooting

### Keyring or signature issues

```bash
sudo pacman-key --init
sudo pacman-key --populate archlinux blackarch
sudo pacman -Syyu
```

### File conflict errors

```bash
sudo pacman -Syyu --needed --overwrite='*' blackarch
```

### Mirror/database issues

```bash
sudo pacman -Syy
```

Then retry the install.

### Disk space check

```bash
df -h
```

### Verify packages

```bash
pacman -Qs blackarch
pacman -Sg | grep blackarch
pacman -Q <package_name>
```

---

## Disclaimer and ethical use

This repository and guide are for:

- security research
- lab environments
- defensive testing
- education
- authorized penetration testing

Do **not** use these tools against systems or services without explicit permission.

---

## Suggested next improvements

- Add a dedicated `docs/full-install-guide.md`
- Add screenshots or terminal examples
- Add category-based install examples
- Add a small verification script for post-install checks
