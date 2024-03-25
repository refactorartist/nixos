{ config, lib, pkgs, ... }:
{
  # Using overlay to override the package
  nixpkgs.overlays = [
    (self: super: {
      python3Packages = super.python3Packages // {
        pydebug = super.python3Packages.pydebug.overrideAttrs (oldAttrs: {
            pytestCheckPhase = "true";
        });
      };
    })
  ];
}