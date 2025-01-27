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
    let
      system = builtins.head (builtins.attrNames nixpkgs.legacyPackages);
      pkgs = nixpkgs.legacyPackages.${system};
    in
    flake-utils.lib.eachDefaultSystem (system: {
      apps.install = {
        type = "app";
        program = toString (nixpkgs.legacyPackages.${system}.writeShellScript "install" ''
          ${nixpkgs.legacyPackages.${system}.home-manager}/bin/home-manager switch --flake .#jason
        '');
      };
    }) // {
      homeConfigurations.jason = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/home.nix ];
      };
    };
}
