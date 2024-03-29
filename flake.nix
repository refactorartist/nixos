{
  description = "Simple Nix Flakes/Home Manager";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    devenv.url = "github:cachix/devenv/latest";
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
            # Copy from /etc/nixos/configuration.nix
            ./hosts/virtualbox/configuration.nix
            ./system/flake_settings.nix
            # Move users from configuration.nix to users.nix  
            ./system/users.nix
            # Additional Modules
            ./system/one_password.nix
            ./system/docker.nix
          ];
        };
        khalid-work = lib.nixosSystem {
          inherit system;
          modules = [
            # Copy from /etc/nixos/configuration.nix
            ./hosts/khalid-work/configuration.nix
            ./hosts/khalid-work/users.nix
            ./system/flake_settings.nix  
            # Additional Modules
            ./system/one_password.nix
            ./system/docker.nix
            ./system/devenv.nix
          ];
        };
      };
      homeConfigurations = {
        khalid = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
            ./user/pydebug_override.nix
          ];
        };
        # For other users copy from above
      };
    };
}
