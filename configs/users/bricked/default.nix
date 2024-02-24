{ config, nix-colors, ... }:

{
  imports = [ ../../../modules/home ];

  config = {
    home = {
      username = "bricked";
      homeDirectory = "/home/bricked";
    };

    colorScheme = nix-colors.colorSchemes.catppuccin-mocha;
    modules = {
      zsh.enable = true;
      starship.enable = true;
      hyprland.enable = true;
      rofi.enable = true;
      rofi.keybind.enable = true;
      kitty.enable = true;
      neovim.enable = true;
      librewolf.enable = true;
      fastfetch.enable = true;
      spotify-player.enable = true;
      cava.enable = true;
      theseus.enable = true;
      discord.enable = true;
    };
  };
}
