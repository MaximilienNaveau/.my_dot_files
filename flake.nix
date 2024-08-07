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
    nixgl = {
      url = "github:guibou/nixGL";
    };
  };

  outputs = { nixpkgs, home-manager, nixgl, ... }: 
    let
      system = "x86_64-linux";
      overlays = [ nixgl.overlay ];
      pkgs = import nixpkgs {
        inherit system overlays;
      };
    in {
      homeConfigurations.mnaveau = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };
}