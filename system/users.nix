{ config, pkgs, ... }:
{
  programs.zsh.enable = true;
  users.users.khalid = {
    isNormalUser = true;
    description = "Khalid Zubair";
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