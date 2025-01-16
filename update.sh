#!/bin/sh

cd "$(dirname "$0")" || exit 1

HOST="$(hostname)"
if [ -n "$1" ]; then
    HOST="$1"
fi

if [ -f ./modules/hosts/"$HOST".nix ]; then
    sudo nixos-rebuild switch --flake .#"$HOST"
fi

home-manager switch --flake .#takumi
