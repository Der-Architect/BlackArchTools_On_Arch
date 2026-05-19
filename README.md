# BlackArch Tools on Arch (Full Install Guide)

This guide installs the full BlackArch toolset on an Arch-based Linux system with a reliability-first workflow.

> ⚠️ Installing **all** BlackArch tools is very large and can take a long time.  
> Plan for strong internet, plenty of disk space, and a clean Arch base.

## 1) Pre-flight checks (do this first)

```bash
sudo pacman -Syu
sudo pacman -S --needed curl gnupg
```

Recommended minimums before full install:
- 150+ GB free disk space
- 8+ GB RAM
- stable internet connection

## 2) Add BlackArch repository safely

```bash
cd /tmp
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
sudo ./strap.sh
```

Then fully refresh package databases:

```bash
sudo pacman -Syyu
```

## 3) Install all BlackArch tools

```bash
sudo pacman -S --needed blackarch
```

## 4) Verify install

```bash
pacman -Qg blackarch | head
pacman -Q | grep '^blackarch-' | head
```

If package lists are returned, the repository and packages are installed correctly.

## 5) Failure-resistant troubleshooting

### Keyring/signature errors
```bash
sudo pacman -S --needed archlinux-keyring blackarch-keyring
sudo pacman -Syyu
```

### Mirror/package download failures
```bash
sudo pacman -S --needed blackarch-mirrorlist
sudo pacman -Syyu
```

### Partial/Interrupted install recovery
```bash
sudo pacman -Syyu
sudo pacman -S --needed blackarch
```

## 6) Optional: install by category (smaller and safer)

List categories:

```bash
pacman -Sg | grep '^blackarch-'
```

Install one category:

```bash
sudo pacman -S --needed blackarch-webapp
```

---

Use this order exactly (update → strap.sh → refresh → install) for the highest success rate.
