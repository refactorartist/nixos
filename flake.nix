{
  description = "Simple Nix Flakes/Home Manager";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  }; 

  outputs = { self, nixpkgs, home-manager, ... }:
    let 
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        virtualbox = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/virtualbox/configuration.nix
            ./system/flake_settings.nix
            ./system/users.nix
            ./system/one_password.nix
            ./system/docker.nix
          ];
        };
        nixos = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            ./system/flake_settings.nix
            ./system/users.nix
            ./system/one_password.nix
            ./system/docker.nix
          ];
        };
      };
      homeConfigurations = {
        khalid = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
          ];
        };
      };
    };
}
