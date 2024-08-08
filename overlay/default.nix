# ./overlays/default.nix
{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    # Add nixgl
    (final: prev: {
      nixgl = {
        url = "github:guibou/nixGL";
      };
    })
  ];
}