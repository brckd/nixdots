{ config, nix-colors, ... }:

{
  imports = [ ../../../modules/home ];

  config = {
    colorScheme = nix-colors.colorSchemes.catppuccin-mocha;
    modules = {
      zsh.enable = true;
      starship.enable = true;
      hyprland.enable = true;
      kitty.enable = true;
      neovim.enable = true;
      librewolf.enable = true;
      fastfetch.enable = true;
      spotify-player.enable = true;
      cava.enable = true;
    };
  };
}
