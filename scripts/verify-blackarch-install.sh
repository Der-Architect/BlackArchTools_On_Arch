#!/usr/bin/env bash
set -euo pipefail

echo "[+] Verifying BlackArch repository visibility..."
if ! pacman -Sg | grep -q '^blackarch'; then
  echo "[-] BlackArch groups not found. The repository may not be configured correctly."
  exit 1
fi

echo "[+] Counting visible BlackArch packages..."
count=$(pacman -Sgg | grep blackarch | cut -d' ' -f2 | sort -u | wc -l)
echo "[+] Visible BlackArch packages: ${count}"

echo "[+] Checking a few common package groups..."
pacman -Sg | grep '^blackarch' | head -n 20 || true

echo "[+] Checking for installed BlackArch packages..."
installed=$(pacman -Qs blackarch | wc -l)
echo "[+] Installed package query lines: ${installed}"

if [[ "${installed}" -eq 0 ]]; then
  echo "[!] No installed BlackArch packages were found by pacman -Qs blackarch"
  echo "[!] The repository may be configured, but packages may not be installed yet."
else
  echo "[+] BlackArch packages appear to be installed."
fi

echo "[+] Verification complete."
