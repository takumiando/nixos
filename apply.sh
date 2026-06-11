#!/bin/sh
set -eu

cd "$(dirname "$0")" || exit 1

HOST="$(hostname)"
if [ -n "${1:-}" ]; then
    HOST="$1"
fi

OPT=""
if [ "$HOST" = nixos ]; then
    # Fresh installs usually still import /etc/nixos/hardware-configuration.nix.
    OPT="--impure"
fi

# Make this script work before the target system has enabled flakes in nix.conf.
sudo env NIX_CONFIG="experimental-features = nix-command flakes" \
    nixos-rebuild switch --flake ".#$HOST" $OPT
