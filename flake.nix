{
  description = "takumiando's machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-hardware.url = "github:takumiando/nixos-hardware/thinkpad-x13-gen7";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware }: let
    system = "x86_64-linux";

    hosts = {
      nixos = {
        hostModule = ./hosts/default.nix;
        hardware = null;
      };
      emma = {
        hostModule = ./hosts/emma.nix;
        hardware = null;
      };
      ramona = {
        hostModule = ./hosts/ramona.nix;
        #hardware = nixos-hardware.nixosModules.lenovo-thinkpad-t14s-amd-gen4;
        hardware = nixos-hardware.nixosModules.lenovo-thinkpad-x13-intel-gen7;
      };
      zooey = {
        hostModule = ./hosts/zooey.nix;
        hardware = nixos-hardware.nixosModules.lenovo-thinkpad-x280;
      };
      hazzard = {
        hostModule = ./hosts/hazzard.nix;
        hardware = nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen5;
      };
    };

  in {
    nixosConfigurations = builtins.mapAttrs (name: cfg:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          cfg.hostModule
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
