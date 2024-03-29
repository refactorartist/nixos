{ pkgs, ... }: 

{
  environment.systemPackages = with pkgs; [
    pkgs.devenv
  ];
}