{ config, pkgs, ... }:

{
  home.username = "khalid";
  home.homeDirectory = "/home/khalid";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.google-chrome
    pkgs.insomnia
    pkgs.git
    pkgs.meslo-lgs-nf
    pkgs.discord
    pkgs.slack
    pkgs.asdf-vm
    pkgs.docker-compose
  ];

  programs.zsh = {
    enable = true;
    initExtra = ''
      . "${pkgs.asdf-vm}/share/asdf-vm/asdf.sh"
    '';
    enableCompletion = true; 
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      home-updates = ''
        cd ~/.dotfiles &&\
        git pull &&\
        home-manager switch --flake ~/.dotfiles &&\
        git commit -am 'Automated update' &&\
        git push
      '';
    };
  };

  programs.starship.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      ms-python.python
      ms-python.vscode-pylance
      ms-python.isort
      ms-python.black-formatter
      charliermarsh.ruff
      vscode-icons-team.vscode-icons
      github.copilot-chat
      gitlab.gitlab-workflow
      dotenv.dotenv-vscode
      mechatroner.rainbow-csv
    ];
  };


  home.file = {
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
}
