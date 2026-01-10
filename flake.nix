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
    };

    outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }@inputs: {
        nixosConfigurations.chloe-tuxedo = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./hosts/chloe-tuxedo/configuration.nix

                nixos-hardware.nixosModules.common-cpu-amd
                nixos-hardware.nixosModules.common-cpu-amd-pstate
                nixos-hardware.nixosModules.common-cpu-amd-zenpower
                nixos-hardware.nixosModules.common-gpu-amd
                nixos-hardware.nixosModules.common-hidpi
                nixos-hardware.nixosModules.common-pc
                nixos-hardware.nixosModules.common-laptop
                nixos-hardware.nixosModules.common-ssd

                nixos-hardware.nixosModules.common-gpu-nvidia
                nixos-hardware.nixosModules.common-gpu-nvidia-prime
                nixos-hardware.nixosModules.common-gpu-nvidia-ada-lovelace
            ];
        };
    };
}
