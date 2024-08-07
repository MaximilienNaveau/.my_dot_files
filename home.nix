{ config, pkgs, specialArgs, lib, ... }:

{
  targets.genericLinux.enable = true;
  
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "mnaveau";
  home.homeDirectory = "/home/mnaveau";

  # This value determines the Home Manager release that your configuration is compatible with.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = [];

  # Importing other configurations.
  imports = [ ./programs.nix ];

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
  };

  programs.fish = {
    enable = true;
    # interactiveShellInit = ''
    #   set fish_greeting # Disable greeting
    # '';
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
