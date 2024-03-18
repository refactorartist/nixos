{ config, pkgs, ... }: 
let 
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
in 
{
  imports = [
    (import "${home-manager}/nixos")
  ]; 

  virtualisation.docker.enable = true;
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["khalid"];
  };

  home-manager.users.khalid = {
    home.stateVersion = "23.11";
    
    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
      google-chrome
      insomnia
      git
      meslo-lgs-nf
      asdf-vm
      docker-compose
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
        system-update = "sudo nixos-rebuild switch";
      };
    };

    programs.starship.enable = true;

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.ssh = {
      enable = true;
      extraConfig = ''
        Host *
          IdentitiesOnly=yes
          IdentityAgent ~/.1password/agent.sock
      '';
    };


    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        ms-python.python
        ms-python.vscode-pylance
        ms-python.isort
        ms-python.black-formatter
        charliermarsh.ruff
        vscode-icons-team.vscode-icons
        github.copilot-chat
        gitlab.gitlab-workflow
        dotenv.dotenv-vscode
      ];
    };
  };
}
