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
	programs.git.enable = true;

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
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };

  # Apps
  programs.librewolf.enable = true;
}
