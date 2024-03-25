{ config, lib, pkgs, ... }:
{
  # Using overlay to override the package
    nixpkgs.overlays = [
    (final: prev: {
        python3 = prev.python3.override {
        packageOverrides = pfinal: pprev: {
            debugpy = pprev.debugpy.overrideAttrs (oldAttrs: {
            pytestCheckPhase = "true";
            });
        };
        };
        python3Packages = final.python3.pkgs;
    })
    ];
}