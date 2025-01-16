{
  description = "takumiando's machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {

      ramona = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/common.nix
          ./hosts/ramona.nix
        ];
      };

      hazzard = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/common.nix
          ./hosts/hazzard.nix
        ];
      };

      vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/common.nix
          ./hosts/vm.nix
        ];
      };

    };
  };
}
