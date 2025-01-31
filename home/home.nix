{ config, pkgs, ... }:

{
  home.username = "jason";
  home.homeDirectory = "/Users/jason";
  home.stateVersion = "24.05";
  home.sessionVariables = {
    NIX_PATH = "nixpkgs=${pkgs.path}";
  };

  programs.home-manager.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.file = {
    ".config/atuin/config.toml".source = ../dotfiles/atuin.config.toml;
    ".dir_colors".source = ../dotfiles/dir_colors;
    ".config/fourmolu.yaml".source  = ../dotfiles/fourmolu.yaml;
    ".config/ghostty/config".source = ../dotfiles/ghostty.config;
    ".config/git/config".source = ../dotfiles/git.config;
    ".config/git/ignore".source = ../dotfiles/git.ignore;
    ".config/helix/config.toml".source = ../dotfiles/helix.config.toml;
    ".config/helix/languages.toml".source = ../dotfiles/helix.languages.toml;
    ".config/nix/nix.conf".source = ../dotfiles/nix.conf;
    ".ssh/config".source = ../dotfiles/ssh.config;
    ".config/starship.toml".source = ../dotfiles/starship.toml;
    ".config/tmux/tmux.conf".source = ../dotfiles/tmux.conf;
    ".zshrc".source = ../dotfiles/zshrc;

    "bin" = {
      source = ../bin;
      recursive = true;
      executable = true;
    };

    ".ssh/id_ed25519.pub".source = ../keys/id_ed25519.pub;
    ".ssh/id_rsa.pub".source = ../keys/id_rsa.pub;
  };

  home.packages = with pkgs; [
    age
    bat
    cachix
    comma
    coreutils
    direnv
    helix
    moreutils
    ripgrep
    starship
    tree
    tmux
    xsel
    zlib
  ];
}
# id_ed25519.age
# id_rsa.age
# sops.key.txt.age
