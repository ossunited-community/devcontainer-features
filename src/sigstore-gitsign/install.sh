#!/usr/bin/env bash
set -euo pipefail

# Usage: ./install.sh [version]
# If no version is provided, defaults to 'latest'.
VERSION="${1:-latest}"

# Install dependencies
apt-get update && apt-get install -y curl jq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Ensure /usr/local/bin exists
mkdir -p /usr/local/bin

if [ "$VERSION" = "latest" ]; then
  # Get latest version tag from GitHub API
  VERSION=$(curl -s https://api.github.com/repos/sigstore/gitsign/releases/latest | jq -r .tag_name)
fi

GITSIGN_URL="https://github.com/sigstore/gitsign/releases/download/${VERSION}/gitsign_${VERSION#v}_linux_amd64"

echo "Downloading gitsign from $GITSIGN_URL"
curl -L "$GITSIGN_URL" -o /usr/local/bin/gitsign
chmod +x /usr/local/bin/gitsign

echo "gitsign $VERSION installed successfully."
