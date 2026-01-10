{
  description = "Chloe's personal dotfiles/NixOS config";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";

        # manage userspace with nix
        home-manager = {
          type = "github";
          owner = "nix-community";
          repo = "home-manager";
          inputs.nixpkgs.follows = "nixpkgs";
        };

        # bring all the mess together with flake-parts
        flake-parts = {
          type = "github";
          owner = "hercules-ci";
          repo = "flake-parts";
          inputs.nixpkgs-lib.follows = "nixpkgs";
        };

        tuxedo-nixos = {
            url = "github:blitz/tuxedo-nixos";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, nixos-hardware, tuxedo-nixos, home-manager, ... }@inputs: {
        nixosConfigurations.chloe-tuxedo = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                nixos-hardware.nixosModules.common-cpu-amd
                nixos-hardware.nixosModules.common-cpu-amd-pstate
                nixos-hardware.nixosModules.common-cpu-amd-zenpower
                nixos-hardware.nixosModules.common-gpu-amd
                nixos-hardware.nixosModules.common-hidpi
                nixos-hardware.nixosModules.common-pc
                nixos-hardware.nixosModules.common-pc-laptop
                nixos-hardware.nixosModules.common-pc-ssd

                nixos-hardware.nixosModules.common-gpu-nvidia

                ./hosts/chloe-tuxedo
                tuxedo-nixos.nixosModules.default
            ];
        };
    };
}
