{
  description = "Simple Nix Flakes/Home Manager";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  }; 

  outputs = { self, nixpkgs, ... }:
    let 
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./system/one_password.nix
            ./system/users.nix
            ./system/flake_settings.nix
          ];
        };
      };
    };
}
