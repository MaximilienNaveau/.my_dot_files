{
  description = "Home Manager configuration for mnaveau";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-system-graphics = {
      url = "github:soupglasses/nix-system-graphics";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, system-manager, nix-system-graphics, ... }:
    let 
      system = "x86_64-linux";
      username = "mnaveau";
      # pkgs = nixpkgs.legacyPackages.${system};
      pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
    in {
      defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
      defaultPackage.x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;

      systemConfigs.default = system-manager.lib.makeSystemConfig {
        modules = [
          nix-system-graphics.systemModules.default
          ({
            config = {
              nixpkgs.hostPlatform = "${system}";
              system-manager.allowAnyDistro = true;
              system-graphics.enable = true;
              # system-graphics.package = pkgs.linuxPackages.nvidia_x11.override { libsOnly = true; kernel = null; };
              system-graphics.package = pkgs.linuxKernel.packages.linux_libre.nvidia_x11_legacy535.override { libsOnly = true; kernel = null; };
            };
          })
        ];
      };

      homeConfigurations = {
        "${username}" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };
    };
}