{ nix-colors, ... }:

{
  home = {
    username = "bricked";
    homeDirectory = "/home/bricked";
  };

  colorScheme = nix-colors.colorSchemes.catppuccin-mocha;

  # Terminal
  programs.zsh.enable = true;
  programs.starship.enable = true;
  programs.kitty.enable = true;
  programs.fastfetch.enable = true;

  # Desktop environment
  wayland.windowManager.hyprland = {
    enable = true;
    settings.input.kb_layout = "de";
  };
  programs.rofi = {
    enable = true;
    keybind.enable = true;
  };

  # Editor
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Music
  programs.spotify-player.enable = true;
  programs.cava.enable = true;

  # Apps
  programs.librewolf.enable = true;
  programs.theseus.enable = true;
  programs.vesktop.enable = true;
}