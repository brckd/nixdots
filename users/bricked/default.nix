{ config, lib, ...}:

{
  imports = [ ../../modules/default.nix ];

  config.modules =  {
    hyprland.enable = true;
    kitty.enable = true;
    neovim.enable = true;
    librewolf.enable = true;
    fastfetch.enable = true;
    spotify-player.enable = true;
    cava.enable = true;
  };
}
