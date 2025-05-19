{
  description = "takumiando's machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware }: let
    system = "x86_64-linux";

    hosts = {
      ramona = {
        hostModule = ./modules/hosts/ramona.nix;
        hardware = nixos-hardware.nixosModules.lenovo-thinkpad-t14s-amd-gen4;
      };
      zooey = {
        hostModule = ./modules/hosts/zooey.nix;
        hardware = nixos-hardware.nixosModules.lenovo-thinkpad-x280;
      };
      hazzard = {
        hostModule = ./modules/hosts/hazzard.nix;
        hardware = nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen5;
      };
      vm = {
        hostModule = ./modules/hosts/vm.nix;
        hardware = null;
      };
    };

  in {
    nixosConfigurations = builtins.mapAttrs (name: cfg:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./modules/common.nix
          cfg.hostModule
          ./modules/home-manager.nix
        ] ++ (if cfg.hardware != null then [ cfg.hardware ] else []);
        specialArgs = { inherit home-manager; };
      }
    ) hosts;

    homeConfigurations = {
      "takumi" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [
          ./home/takumi.nix
          ./home/gnome.nix
        ];
      };
    };
  };
}
