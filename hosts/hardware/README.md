# Hardware configurations

When we install NixOS, hardware-specific configurations are generated as
``/etc/nixos/hardware-configuration.nix``.

Unless there is a special reason, you should not edit this file manually.

## Steps to manage hardware configurations

1. Install NixOS

2. Copy the file here using the hostname

```shell
$ cp /etc/nixos/hardware-configuration.nix "${HOSTNAME}.nix"
```

3. Commit this

## FAQ

Q. Wouldn’t it be possible to simply import ``/etc/nixos/hardware-configuration.nix`` and avoid managing it with Git?

A. It is possible, but doing so would make the configuration impure, which goes against the philosophy of Nix.
If you really want to do this, you can run ``nix-build`` with the ``--impure`` flag.
