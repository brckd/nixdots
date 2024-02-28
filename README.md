# NixDots

[![license](https://custom-icon-badges.demolab.com/github/license/brckd/nixdots?logo=law)](LICENSE.md)

Dotfiles for Nix-on-droid using Home Manager.

## Usage

1. [Install Nix-on-droid](https://github.com/nix-community/nix-on-droid) with flakes

2. Enter the repository

```bash
git clone --depth 1 https://github.com/brckd/nixdots
cd nixdots
```

3. Build and activate the home configuration

```bash
nix run home-manager/master -- switch --flake .
```

4. Build and activate the system configuration

```bash
nix-on-droid switch --flake .
```

## Acknowledgements

Special thanks to these project that heavily inspired me!

- [Home Manager](https://nix-community.github.io/home-manager)
- [ez-configs](https://github.com/ehllie/ez-configs)
- [Nix-on-droid](https://github.com/nix-community/nix-on-droid)
- [Notusknot's dotfiles](https://github.com/notusknot/dotfiles-nix)
- [Misterio77's starter-configs](https://github.com/Misterio77/nix-starter-configs)
- [NvChad](https://github.com/NvChad/NvChad)
