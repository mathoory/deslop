#!/usr/bin/env bash
# One-time setup on Linux / macOS / Git Bash: fetch styles, point Vale here, add `delint` to the shell.
set -eu
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
command -v vale >/dev/null || { echo "Install Vale first: https://vale.sh/docs/install"; exit 1; }
chmod +x "$DIR/delint" "$DIR/install.sh"
vale --config "$DIR/.vale.ini" sync
RC="$HOME/.bashrc"; [ -n "${ZSH_VERSION:-}" ] && RC="$HOME/.zshrc"
for line in "export VALE_CONFIG_PATH=\"$DIR/.vale.ini\"" "alias delint=\"$DIR/delint\""; do
  grep -qxF "$line" "$RC" 2>/dev/null || echo "$line" >> "$RC"
done
echo "Done. Open a new shell, then: delint README.md"
