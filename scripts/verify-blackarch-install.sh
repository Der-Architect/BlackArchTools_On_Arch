#!/usr/bin/env bash
set -euo pipefail

pass() { echo "[PASS] $*"; }
warn() { echo "[WARN] $*"; }
fail() { echo "[FAIL] $*"; exit 1; }

command -v pacman >/dev/null 2>&1 || fail "pacman was not found. This script must be run on an Arch-based system."
pass "pacman is available"

if grep -Eq '^\s*\[blackarch\]' /etc/pacman.conf; then
  pass "BlackArch repository entry found in /etc/pacman.conf"
else
  warn "BlackArch repository entry was not found in /etc/pacman.conf"
fi

echo "[INFO] Verifying BlackArch repository visibility..."
if ! pacman -Sg | grep -q '^blackarch'; then
  fail "BlackArch groups not found. The repository may not be configured correctly or package databases may need refresh."
fi
pass "BlackArch groups are visible"

echo "[INFO] Counting visible BlackArch packages..."
count=$(pacman -Sgg | grep blackarch | cut -d' ' -f2 | sort -u | wc -l)
echo "[INFO] Visible BlackArch packages: ${count}"

echo "[INFO] Showing a few available BlackArch groups..."
pacman -Sg | grep '^blackarch' | head -n 20 || true

echo "[INFO] Checking for installed BlackArch packages..."
installed=$(pacman -Qs blackarch | wc -l)
echo "[INFO] Installed package query lines: ${installed}"

if [[ "${installed}" -eq 0 ]]; then
  warn "No installed BlackArch packages were found by pacman -Qs blackarch"
  warn "The repository may be configured, but packages may not be installed yet."
else
  pass "BlackArch packages appear to be installed"
fi

for pkg in nmap sqlmap nikto hashcat; do
  if pacman -Q "$pkg" >/dev/null 2>&1; then
    pass "Package installed: $pkg"
  else
    warn "Package not installed: $pkg"
  fi
done

pass "Verification complete"
