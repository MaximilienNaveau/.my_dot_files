{ config, pkgs, specialArgs, lib, ... }:
{
  targets.genericLinux.enable = true;
    
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "mnaveau";
  home.homeDirectory = "/home/mnaveau";

  # This value determines the Home Manager release that your configuration is compatible with.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Importing other configurations.
  imports = [ ./programs.nix ./files.nix ];

  # Home Manager can also manage your environment variables through 'home.sessionVariables'.
  home.sessionVariables = {
    EDITOR = "emacs";
    BROWSER = "firefox";
    TERMINAL = "kitty";
  };

  # Shell aliases:
  home.shellAliases = {
    gitl = "git plog";
    gits = "git status";
    ll = "ls -al";
    l = "ls";
    ".." = "cd ..";
    "..." = "cd ../..";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    shellInit = ''
      set -x LOCAL_USER_ID (id -u)
      set -x LOCAL_GROUP_ID (id -g)
      set -x LOCAL_GROUP_NAME (id -gn)
      fish_add_path ~/.local/bin
      fish_add_path ~/Application/pal_docker_utils/scripts/
      direnv hook fish | source
    '';
    # plugins = [
    #   # Enable a plugin (here grc for colorized command output) from nixpkgs
    #   { name = "grc"; src = pkgs.fishPlugins.grc.src; }
    #   { name = "done"; src = pkgs.fishPlugins.done.src; }
    #   { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
    #   { name = "forgit"; src = pkgs.fishPlugins.forgit.src; }
    #   { name = "hydro"; src = pkgs.fishPlugins.hydro.src; }
    #   # Manually packaging and enable a plugin
    #   {
    #     name = "z";
    #     src = pkgs.fetchFromGitHub {
    #       owner = "jethrokuan";
    #       repo = "z";
    #       rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
    #       sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
    #     };
    #   }
    # ];
  };

  # Activate the fish terminal emulator.
  programs.kitty = {
    enable = true;
    settings = {
      shell = "fish";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
