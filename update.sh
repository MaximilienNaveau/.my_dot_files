home-manager switch --flake .
sudo env "PATH=$PATH" "NIXPKGS_ALLOW_UNFREE=1" nix run 'github:numtide/system-manager' -- switch --flake '.'