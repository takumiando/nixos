#!/bin/sh

cd "$(dirname "$0")" || exit 1

HOST="$(hostname)"
if [ -n "$1" ]; then
    HOST="$1"
fi

if [ "$HOST" = nixos ]; then
    OPT=--impure
fi

sudo nixos-rebuild switch --flake .#"$HOST" $OPT

home-manager switch --extra-experimental-features nix-command --flake .#takumi
