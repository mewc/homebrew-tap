#!/bin/bash
# Usage: ./bump.sh input-stats 0.2.3  — rewrites version + sha256 from the GitHub release asset and commits.
set -euo pipefail
cask="$1"; version="$2"
url="https://github.com/mewc/input-stats/releases/download/v${version}/InputStats.zip"
sha=$(curl -sL "$url" | shasum -a 256 | awk '{print $1}')
sed -i '' -e "s/^  version \".*\"/  version \"${version}\"/" -e "s/^  sha256 \".*\"/  sha256 \"${sha}\"/" "Casks/${cask}.rb"
brew style --cask "Casks/${cask}.rb" >/dev/null 2>&1 || true
git add "Casks/${cask}.rb" && git commit -m "${cask} ${version}" && git push
