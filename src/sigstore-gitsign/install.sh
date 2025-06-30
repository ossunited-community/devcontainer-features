#!/usr/bin/env bash
set -euo pipefail

# Install dependencies
apt-get update && apt-get install -y curl tar \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Ensure /usr/local/bin exists
mkdir -p /usr/local/bin

# Get latest gitsign release info from GitHub
GITSIGN_URL=$(curl -s https://api.github.com/repos/sigstore/gitsign/releases/latest \
  | grep browser_download_url \
  | grep linux_amd64.tar.gz | cut -d '"' -f 4)

if [ -z "$GITSIGN_URL" ]; then
  echo "Failed to fetch gitsign release URL from GitHub." >&2
  exit 1
fi

# Download and extract
echo "Downloading gitsign from $GITSIGN_URL"
curl -L "$GITSIGN_URL" -o /tmp/gitsign.tar.gz

tar -xzf /tmp/gitsign.tar.gz -C /usr/local/bin gitsign
chmod +x /usr/local/bin/gitsign

# Clean up
rm /tmp/gitsign.tar.gz

echo "gitsign installed successfully."
