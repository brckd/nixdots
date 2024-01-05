{ config, ... }:

{
  imports = [ ../../home/default.nix ];

  config.modules = {
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
}
