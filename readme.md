# Refactor's NixOs Dump 

## NixOS

This instllation is for NixOS 

### Clone the Repository

Create a new shell, with git and clone the repository

```sh
$ nix-shell -p git
nix-shell $ git clone REPOSITORY_URL
```

if it's one time, delete the .git folder 

```sh
nix-shell $ cd .dotfiles 
nix-shell $ rm -rf .git
```
and exit 

```sh
nix-shell $ exit
$ 
```

### Edit `configuration.nix`

```sh
$ sudoedit /etc/nixos/configuration.nix
```

change the your host name 

```
networking.hostName = "$HOSTNAME";
```

and save

### Rebuild and restart 

```
$ sudo nixos-rebuild switch 
$ sudo reboot now
```

### Copy configurations 

Navigate to the .dotfiles folder, and create your configuration folder (using $HOSTNAME used in configuration.nix)

```sh
$ cd ~/.dotfiles
$ mkdir -p hosts/$HOSTNAME
```

Copy the configuration files 

```
$ copy /etc/nixos/configuration.nix ~/.dotfiles/hosts/$HOSTNAME
$ copy /etc/nixos/hardware-cofniguration.nix ~/.dotfiles/hosts/$HOSTNAME
```

### Modify configuration.nix (Optional)

Remove the user related configurations and move them to `system/users.nix`


### Install home-manager 

Run the following commands, this will update nix-channels with home-manager repository

```sh
$ nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
$ nix-channel --update
```

Install home-manager 

```
$ nix-shell '<home-manager>' -A install
```

If you get an error, simply logoff/logon

### Rebuild and restart 

Update nix flake

```
$ nix flake update
$ sudo nixos-rebuild --flake ~/.dotfiles#$YOUR_HOST_NAME
$ home-manager switch --flake ~/.dotfiles
```








