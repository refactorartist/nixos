{ config, lib, pkgs, ... }:
{
  # Using overlay to override the package
    nixpkgs.overlays = [
    (final: prev: {
        _1password-gui = prev._1password-gui.override {
          polkitPolicyOwners = [ "khalid" ];
        };
    })
    ];
}