#!/bin/sh

cd "$(dirname "$0")" || exit 1

if [ "$(whoami)" != root ]; then
    printf "Please run as root\n"
    exit 1
fi

HOST="$(hostname)"
if [ -n "$1" ]; then
    HOST="$1"
fi

if [ -f ./modules/hosts/"$HOST".nix ]; then
    nixos-rebuild switch --flake .#"$HOST"
fi

home-manager switch --flake .#takumi
