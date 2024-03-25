# Refactor's NixOs Dump

## NixOS

This instllation is for NixOS

### Clone the Repository

Create a new shell, with git and clone the repository

```sh
$ nix-shell -p git
nix-shell $ git clone https://github.com/refactorartist/nixos.git
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

### Modify flake.nix (Optional)

In your flake.nix, create a new nixosConfiguration

```nix
      nixosConfigurations = {
        ...
        # ADD THE FOLLOWING
        $CHANGE_TO_YOUR_HOSTNAME = lib.nixosSystem {
          inherit system;
          modules = [
            # Copy from /etc/nixos/configuration.nix
            ./$CHANGE_TOYOUR_HOSTNAME/configuration.nix
            ./system/flake_settings.nix
            # Move users from configuration.nix to users.nix
            ./system/users.nix
            # Optional Modules
            # ./system/one_password.nix
            # ./system/docker.nix
          ];
        };
      };
```

and add a new homeConfiguration

```nix
      homeConfigurations = {
        ...
        YOUR_USERNAME = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
            ./user/pydebug_override.nix
          ];
        };
```

Make sure to use the same username found in configuration.nix or your host's configuration.nix (or if moved to system/users.nix)

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

## For Non-NixOs (Ubuntu)

### Install Dependencies

```sh
$ sudo apt-install curl git
```

### Clone the repository

```sh
$ git clone https://github.com/refactorartist/nixos.git
```

### Install nix

```sh
sh <(curl -L https://nixos.org/nix/install) --no-daemon
```

And edit your bashrc/zshrc and add the following line

```bash
. $HOME/.nix-profile/etc/profile.d/nix.sh
```

### (Optional) Modify home.nix

```nix
  home.username = "YOUR_USERNAME";
  home.homeDirectory = "/home/YOUR_USERNAME";
```

### Enable flake

Edit or create the file

```
$ touch ~/.config/nix/nix.conf
$ nano ~/.config/nix/nix.conf
```

Add the following

```bash
experimental-features = nix-command flake
```

### Install home-manager

```sh
$ nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
$ nix-channel --update
```

and run the installer

```sh
$ nix-shell '<home-manager>' -A install
```

### Enable your home profile

```sh
$ home-manager switch --flake ~/.dotfiles
```

You're good to go
