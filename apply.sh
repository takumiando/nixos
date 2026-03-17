#!/bin/sh

cd "$(dirname "$0")" || exit 1

HOST="$(hostname)"
if [ -n "$1" ]; then
    HOST="$1"
fi

case "$HOST" in
    nixos)
        OPT=--impure
        ;;
    *)
        ;;
esac

case "$HOST" in
    machu)
        SWITCH_CMD="nix-on-droid"
        ;;
    *)
        SWITCH_CMD="nixos-rebuild"
        ;;
esac

sudo "$SWITCH_CMD" switch --flake .#"$HOST" $OPT

home-manager switch --extra-experimental-features nix-command --flake .#takumi
