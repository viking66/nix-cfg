{
  description = "Jason's system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: 
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      homeConfigurations.jason = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/home.nix ];
      };

      apps.${system} = {
        install = {
          type = "app";
          program = toString (pkgs.writeShellScript "install" ''
            ${pkgs.home-manager}/bin/home-manager switch --flake .#jason
          '');
        };
      };
    };
}
