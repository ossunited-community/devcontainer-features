#!/usr/bin/env bash
set -euo pipefail

# Test: sigstore-gitsign feature

echo "[test] Checking if gitsign is installed..."
if ! command -v gitsign >/dev/null 2>&1; then
  echo "[error] gitsign is not installed!"
  exit 1
fi

echo "[test] gitsign is installed. Version info:"
gitsign --version || echo "[warn] Could not get gitsign version."

echo "[test] sigstore-gitsign feature test passed."
