{ pkgs, ... }: 

{
  environment.systemPackages = with pkgs; [
    polkit_gnome
  ];

  security.polkit.enable = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;    
  };      
}