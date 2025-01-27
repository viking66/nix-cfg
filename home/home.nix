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

  # home.file = {
  #   ".config/ghostty/config".source = ../dotfiles/ghostty.config;
  #   ".zshrc".source = ../dotfiles/zshrc;
  #   "bin" = {
  #     source = ../bin;
  #     recursive = true;
  #     executable = true;
  #   };
  # };

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
