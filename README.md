# BlackArchTools_On_Arch

## Install all BlackArch tools on Arch-based Linux

This guide shows the most reliable way to install the **BlackArch repository on top of an existing Arch Linux or Arch-based system** and then install **all currently available BlackArch packages**.

> **Important:** No guide can honestly guarantee a "100% no-fail" install for *all* BlackArch tools, because package availability, upstream changes, mirror state, file conflicts, disk space, RAM, and network issues can change over time. This guide is written to maximize success and minimize common failures.

## What this guide does

- Adds the official BlackArch repository to your system using the official `strap.sh` method.
- Updates your Arch package databases and system packages.
- Installs all BlackArch tools available through the repository.
- Includes checks and recovery steps for the most common failure points.

## Best recommendation before you start

Installing **every** BlackArch package is very large and can take a long time. It may also pull in many dependencies you do not need.

If you only need specific tool classes, it is often better to install by category:

```bash
sudo pacman -Sg | grep blackarch
sudo pacman -S blackarch-<category>
```

If you still want **everything**, follow the full procedure below.

---

## Requirements

Before installing, make sure your system has:

- A working Arch Linux or Arch-based installation
- Stable internet access
- `sudo` access
- Plenty of free disk space
- Updated keyrings and package databases
- `multilib` enabled if your system needs it

## Step 1: Fully update your Arch system first

Run:

```bash
sudo pacman -Syu
```

If this updates core packages like `pacman`, `glibc`, or keyrings, reboot once before continuing:

```bash
sudo reboot
```

After reboot, re-run:

```bash
sudo pacman -Syu
```

Do not continue until your base system updates cleanly.

## Step 2: Enable multilib if it is disabled

Edit `/etc/pacman.conf` and make sure this section is enabled:

```ini
[multilib]
Include = /etc/pacman.d/mirrorlist
```

Then refresh package databases:

```bash
sudo pacman -Syu
```

## Step 3: Download and verify the official BlackArch strap script

Download the script:

```bash
curl -O https://blackarch.org/strap.sh
```

Verify its SHA1 checksum:

```bash
echo 00688950aaf5e5804d2abebb8d3d3ea1d28525ed strap.sh | sha1sum -c
```

If the checksum does **not** match, stop and download it again.

Make it executable:

```bash
chmod +x strap.sh
```

## Step 4: Add the BlackArch repository

Run:

```bash
sudo ./strap.sh
```

This sets up the BlackArch repository and signing keys on your system.

If keyring-related problems appear later, try:

```bash
sudo pacman-key --init
sudo pacman-key --populate archlinux blackarch
```

## Step 5: Refresh and fully sync packages

Run:

```bash
sudo pacman -Syyu
```

This forces a fresh sync of repository databases and upgrades packages.

## Step 6: Confirm the BlackArch repository is available

List BlackArch groups:

```bash
sudo pacman -Sg | grep blackarch
```

List all BlackArch packages:

```bash
sudo pacman -Sgg | grep blackarch | cut -d' ' -f2 | sort -u
```

Count them:

```bash
sudo pacman -Sgg | grep blackarch | cut -d' ' -f2 | sort -u | wc -l
```

## Step 7: Install all BlackArch tools

### Option A: Install the meta group directly

Try this first:

```bash
sudo pacman -S blackarch
```

### Option B: If you hit file-conflict or partial-upgrade style issues

Use the more forceful official-style recovery approach:

```bash
sudo pacman -Syyu --needed --overwrite='*' blackarch
```

This is the most practical command when package file conflicts block installation.

## Step 8: If installing `blackarch` group is incomplete, install all listed packages explicitly

Generate the package list and install everything:

```bash
sudo pacman -Sgg | grep blackarch | cut -d' ' -f2 | sort -u > blackarch-package-list.txt
sudo pacman -S --needed --overwrite='*' $(cat blackarch-package-list.txt)
```

If your shell complains that the argument list is too long, use batching:

```bash
cat blackarch-package-list.txt | xargs -r sudo pacman -S --needed --overwrite='*'
```

## Recommended safer install flow

For better reliability on many systems, use this order:

```bash
sudo pacman -Syu
curl -O https://blackarch.org/strap.sh
echo 00688950aaf5e5804d2abebb8d3d3ea1d28525ed strap.sh | sha1sum -c
chmod +x strap.sh
sudo ./strap.sh
sudo pacman -Syyu
sudo pacman -S --needed --overwrite='*' blackarch
```

If that does not install everything:

```bash
sudo pacman -Sgg | grep blackarch | cut -d' ' -f2 | sort -u > blackarch-package-list.txt
cat blackarch-package-list.txt | xargs -r sudo pacman -S --needed --overwrite='*'
```

---

## Troubleshooting

### 1. Keyring or signature errors

Try:

```bash
sudo pacman-key --init
sudo pacman-key --populate archlinux blackarch
sudo pacman -Syyu
```

### 2. File exists / failed to commit transaction

Try:

```bash
sudo pacman -Syyu --needed --overwrite='*' blackarch
```

Or for all packages:

```bash
cat blackarch-package-list.txt | xargs -r sudo pacman -S --needed --overwrite='*'
```

### 3. Mirror sync or download failures

- Wait a few minutes and retry.
- Make sure your normal Arch mirrors are healthy.
- Refresh again:

```bash
sudo pacman -Syy
```

### 4. Out-of-date Arch base system

If the install keeps failing, first make sure the base system is fully current:

```bash
sudo pacman -Syu
```

Then retry the BlackArch installation.

### 5. Not enough disk space

Installing all BlackArch tools can consume a very large amount of storage. Free space before retrying:

```bash
df -h
```

### 6. One or a few packages fail

Sometimes a small number of packages may fail because of temporary upstream issues. To identify them, install from the generated package list in smaller batches:

```bash
split -l 50 blackarch-package-list.txt blackarch-batch-
for f in blackarch-batch-*; do
  echo "Installing $f"
  cat "$f" | xargs -r sudo pacman -S --needed --overwrite='*'
done
```

This helps isolate problem packages instead of stopping the whole install.

---

## Verify installation

Search for BlackArch packages:

```bash
pacman -Qs blackarch
```

Check if common categories are visible:

```bash
pacman -Sg | grep blackarch
```

Check whether a tool is installed:

```bash
pacman -Q <package_name>
```

---

## Reality check

If your goal is a practical and stable security workstation, installing **all** BlackArch tools is usually not the best choice. A better approach is:

1. Add the BlackArch repo
2. Install only the categories you actually need
3. Keep the system updated with:

```bash
sudo pacman -Syu
```

---

## Official references used for this guide

This README is based on the official BlackArch installation and guide pages, including:

- the official install/download instructions
- the BlackArch installation tutorial
- the official guide/quick-guide references

## Quick copy-paste version

```bash
sudo pacman -Syu
curl -O https://blackarch.org/strap.sh
echo 00688950aaf5e5804d2abebb8d3d3ea1d28525ed strap.sh | sha1sum -c
chmod +x strap.sh
sudo ./strap.sh
sudo pacman -Syyu
sudo pacman -S --needed --overwrite='*' blackarch
```

If needed:

```bash
sudo pacman -Sgg | grep blackarch | cut -d' ' -f2 | sort -u > blackarch-package-list.txt
cat blackarch-package-list.txt | xargs -r sudo pacman -S --needed --overwrite='*'
```
