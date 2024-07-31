{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mnaveau";
  home.homeDirectory = "/home/mnaveau";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # Adds the 'cowsay' command to your environment.
    # It prints a cow saying somethings.
    pkgs.cowsay
    # Tells you your daily fortune message.
    pkgs.fortune
    # Monitor the cpu and memory load.
    pkgs.htop    
    # Adds the 'ponysay' command to your environment.
    # It prints a My Little Pony character saying somethings.
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
    # Terminal emulator
    pkgs.fish

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # Git setup
    ".gitignore".source = git/gitignore;
    ".gitconfig".source = git/gitconfig;
    ".gitconfig_perso".source = git/gitconfig_perso;
    ".gitconfig_toward".source = git/gitconfig_toward;

    # Bash
    ".bashrc".source = bash/bashrc;
    ".bash_aliases".source = bash/bash_aliases;

    # Fish setup
    # ".config/fish/functions/fish_prompt.fish".source = fish/fish_prompt.fish;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/mnaveau/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "emacs -nw";
  };

  # shell aliases:
  home.shellAliases = {
    gitl = "git plog";
    gits = "git status";
  };

  # Activate the fish terminal emulator.
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
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

  # Startup fish on all terminal using bash.
  programs.bash = {
    initExtra = "fish";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
