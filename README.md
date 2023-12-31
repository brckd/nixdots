# NixDots

[![license](https://custom-icon-badges.demolab.com/github/license/brckd/nixdots?logo=law)](LICENSE.md)

Dotfiles for NixOS using Home Manager.

## Usage

1. [Install NixOS](https://nixos.org/manual/nixos/stable/index.html#ch-installation) with root access

2. [Enable Flakes](https://nix-community.github.io/home-manager#sec-flakes-prerequisites)

3. Enter the repository

```bash
git clone --depth 1 https://github.com/brckd/nixdots
cd nixdots
```

4. Build and activate the configuration

```bash
sudo nixos-rebuild switch --flake .
```

## Acknowledgements

Special thanks to these project that heavily inspired me!

- [Home Manager](https://nix-community.github.io/home-manager)
- [Notusknot's dotfiles](https://github.com/notusknot/dotfiles-nix)
- [Misterio77's starter-configs](https://github.com/Misterio77/nix-starter-configs)
- [NvChad](https://github.com/NvChad/NvChad)
