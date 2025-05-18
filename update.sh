#!/bin/sh

cd "$(dirname "$0")" || exit 1


HOST="$(hostname)"
if [ -n "$1" ]; then
    HOST="$1"
fi

nix flake update

if [ -n "$(git diff -- flake.lock)" ]; then
    DATETIME="$(date '+%Y-%m-%d %H:%M:%S')"
    git add flake.lock
    git commit --signoff -m "flake.lock: Update $DATETIME"
fi

./apply.sh "$HOST"
