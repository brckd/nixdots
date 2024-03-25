{...}: {
  home = {
    username = "bricked";
    homeDirectory = "/home/bricked";
  };

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
  programs.wpaperd.enable = true;
  programs.rofi = {
    enable = true;
    keybind.enable = true;
  };
  services.cliphist.enable = true;

  # Editor
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };

  # Apps
  programs.librewolf.enable = true;
}
