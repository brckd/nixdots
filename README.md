# NixDots

[![license](https://custom-icon-badges.demolab.com/github/license/brckd/nixdots?logo=law)](LICENSE.md)

Dotfiles for NixOS using Flakes. Contains modules and configurations for NixOS, nix-on-droid and Home Manager.

## Using existing configurations

1. Make sure to have [NixOS](https://nixos.org/manual/nixos/stable/index.html#ch-installation),
   [nix-on-droid](https://github.com/nix-community/nix-on-droid#try-it-out) or just
   [Nix](https://nixos.org/download#download-nix) properly installed.

2. [Enable Flakes](https://nixos.wiki/wiki/Flakes#Enable_flakes_temporarily) if you haven't already.

3. Enter the repository.

```bash
git clone --depth 1 https://github.com/brckd/nixdots
cd nixdots
```

4. Build and activate the home configuration.

```bash
nix run home-manager/master -- switch --flake .
```

5. Build and activate the system configuration, if one exists.

On NixOS (device specific)

```bash
sudo nixos-rebuild switch --flake .
```

On nix-on-droid

```bash
nix-on-droid switch --flake .
```

## Creating new Configurations

### On NixOS

1. Create a new directory at `./configurations/nixos/$HOSTNAME`.

2. Use `nixos-generate-config` to create a hardware configuration.

```bash
nixos-generate-config --dir ./configurations/nixos/$HOSTNAME
```

3. Create a `default.nix` module that imports `configuration.nix` to configure your system.

### On nix-on-droid

Just override the existing configuration in `./configurations/droid/default.nix`.

### On Home Manager

1. Create a new directory at `./configurations/home/$USERNAME`

2. Create a `default.nix` module to configure your user.

## Acknowledgements

Special thanks to these project that heavily inspired me!

- [ez-configs](https://github.com/ehllie/ez-configs)
- [Notusknot's dotfiles](https://github.com/notusknot/dotfiles-nix)
- [Misterio77's starter-configs](https://github.com/Misterio77/nix-starter-configs)
- [Vimjoyer's Nixvim Video](https://github.com/vimjoyer/nixvim-video)
- [NvChad](https://github.com/NvChad/NvChad)
