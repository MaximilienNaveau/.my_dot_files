{ ... }:
{
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # Git setup
    ".gitignore".source = ./git/gitignore;
    ".gitconfig".source = ./git/gitconfig;
    ".gitconfig_perso".source = ./git/gitconfig_perso;
    ".gitconfig_toward".source = ./git/gitconfig_toward;

    # Bash
    ".bashrc".source = ./bash/bashrc;
    ".bash_aliases".source = ./bash/bash_aliases;

    # Fish setup
    # "./.config/fish/functions/fish_prompt.fish".source = ./fish/fish_prompt.fish;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
}