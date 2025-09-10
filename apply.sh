#!/bin/sh

cd "$(dirname "$0")" || exit 1

HOST="$(hostname)"
if [ -n "$1" ]; then
    HOST="$1"
fi

sudo nixos-rebuild switch --flake .#"$HOST"

home-manager switch --extra-experimental-features nix-command --flake .#takumi
