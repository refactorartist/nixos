{ pkgs, ... }: 

{
  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    libc
    zlib
    openssl
    bzip2
    ncurses
    readline
    xz
    sqlite
  ];
}