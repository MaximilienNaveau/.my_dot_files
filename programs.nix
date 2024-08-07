{ config, pkgs, specialArgs, lib, ... }:
let
  helpers = import ./helpers.nix {
    inherit pkgs lib config specialArgs;
  };

  nixGLMesaWrap = pkg:
    pkgs.runCommand "${pkg.name}-nixgl-wrapper" { } ''
      mkdir $out
      ln -s ${pkg}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${pkg}/bin/*; do
      wrapped_bin=$out/bin/$(basename $bin)
      echo "exec ${
        lib.getExe pkgs.nixgl.nixGLIntel
      } $bin \$@" > $wrapped_bin
      chmod +x $wrapped_bin
      done
    '';
in {
  home.packages = [
    # Some guy config over the internet
    # pkgs.etcher
    # pkgs.chromium
    # pkgs.firefox
    # pkgs.onlyoffice-bin
    # pkgs.inkscape
    # pkgs.gimp
    pkgs.pywal
    pkgs.wpgtk
    pkgs.syncthing
    pkgs.xorg.xinput
    pkgs.gammastep
    pkgs.autotiling
    pkgs.dmenu-rs
    pkgs.feh
    pkgs.eza
    pkgs.dunst
    pkgs.arandr

    # (helpers.nixGLVulkanMesaWrap pkgs.picom)
    # (helpers.nixGLMesaWrap pkgs.kitty)
    # (helpers.nixGLMesaWrap pkgs.ytfzf)

    # Adds the 'cowsay' command to your environment.
    pkgs.cowsay
    # Tells you your daily fortune message.
    pkgs.fortune
    # Monitor the cpu and memory load.
    pkgs.htop    
    # Adds the 'ponysay' command to your environment.
    (pkgs.ponysay.overrideAttrs { 
      patches = [
        (pkgs.fetchpatch {
          url = "https://github.com/erkin/ponysay/pull/313.patch";
          hash = "sha256-394drlO4sNH02Ej77cI6H/v15c91zm5Fo3g5A3xWkx4=";
        })
      ];
    })
    
    # Text editor.
    pkgs.emacs
    
    # Package manager.
    pkgs.git
    
    # Versatile IDE.
    # pkgs.vscode

    # Fancy shell. To activate globally on linux:
    (nixGLMesaWrap pkgs.kitty)
    pkgs.fish

    # It is sometimes useful to fine-tune packages, for example, by applying overrides.
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # You can also create simple shell scripts directly inside your configuration.
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
}
