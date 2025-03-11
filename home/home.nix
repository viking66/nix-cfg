{ config, pkgs, lib, ... }:
{
  home.username = "jason";
  home.homeDirectory = "/Users/jason";
  home.stateVersion = "24.05";
  home.sessionVariables = {
    NIX_SHELL_PRESERVE_PROMPT=1;
  };
  home.file = {
    ".config/atuin/config.toml".source = ../dotfiles/atuin.config.toml;
    ".dir_colors".source = ../dotfiles/dir_colors;
    ".config/fourmolu.yaml".source = ../dotfiles/fourmolu.yaml;
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
    ".ssh/gh_id_ed25519.pub".source = ../keys/gh_id_ed25519.pub;
  };
  home.activation = {
    decryptKeys = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD ${pkgs.age}/bin/age -d -i $HOME/.config/nix-cfg/key.txt -o $VERBOSE_ARG $HOME/.ssh/id_ed25519 ${../keys/id_ed25519.age}
      $DRY_RUN_CMD chmod 600 $VERBOSE_ARG $HOME/.ssh/id_ed25519
      
      $DRY_RUN_CMD ${pkgs.age}/bin/age -d -i $HOME/.config/nix-cfg/key.txt -o $VERBOSE_ARG $HOME/.ssh/id_rsa ${../keys/id_rsa.age}
      $DRY_RUN_CMD chmod 600 $VERBOSE_ARG $HOME/.ssh/id_rsa

      $DRY_RUN_CMD ${pkgs.age}/bin/age -d -i $HOME/.config/nix-cfg/key.txt -o $VERBOSE_ARG $HOME/.ssh/gh_id_ed25519 ${../keys/gh_id_ed25519.age}
      $DRY_RUN_CMD chmod 600 $VERBOSE_ARG $HOME/.ssh/gh_id_ed25519
      
      $DRY_RUN_CMD mkdir -p $VERBOSE_ARG $HOME/.config/sops/age
      $DRY_RUN_CMD ${pkgs.age}/bin/age -d -i $HOME/.config/nix-cfg/key.txt -o $VERBOSE_ARG $HOME/.config/sops/age/key.txt ${../keys/sops.key.txt.age}
      $DRY_RUN_CMD chmod 600 $VERBOSE_ARG $HOME/.config/sops/age/key.txt
    '';
  };
  home.packages = with pkgs; [
    age
    atuin
    bat
    comma
    coreutils
    delta
    direnv
    fd
    helix
    home-manager
    inconsolata
    moreutils
    ripgrep
    starship
    tree
    tmux
    xsel
    zellij
    zlib
  ];
}
