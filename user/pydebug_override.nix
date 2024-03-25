{ config, pkgs, ... }:
{
    pkgs.python311.debugpy.overrideAttrs (self: super: {
        pytestCheckPhase = ''true'';
    });    
}