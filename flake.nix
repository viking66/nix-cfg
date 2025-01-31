{
  description = "Jason's system configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, home-manager, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: {
      apps.install = {
        type = "app";
        program = toString (nixpkgs.legacyPackages.${system}.writeShellScript "install" ''
          ${nixpkgs.legacyPackages.${system}.home-manager}/bin/home-manager switch --flake .#jason
        '');
      };

      legacyPackages.homeConfigurations.jason = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ ./home/home.nix ];
      };
    });
}
