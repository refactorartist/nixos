{ config, pkgs, ... }:
{
  programs.zsh.enable = true;
  users.users.khalid = {
    isNormalUser = true;
    description = "khalid";
    extraGroups = [ 
      "networkmanager" 
      "wheel" 
      "docker" 
      "onepassword" 
      "polkituser"
      "onepassword-cli"
    ];
    packages = with pkgs; [
    ];
    shell = pkgs.zsh;
  };
}
