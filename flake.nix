{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, nixpkgs-unstable, home-manager, darwin, ... }:
    let
      linux = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [ ./home.nix ];
      };
      darwin = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules =
          [ home-manager.darwinModules.home-manager (import ./darwin.nix) ];
      };
    in {
      packages.x86_64-linux.homeConfigurations."luther@purple" = linux;
      packages.x86_64-linux.homeConfigurations."luther" = linux;
      packages.aarch64-darwin.darwinConfigurations."luther-macbookpro" = darwin;
    };
}
