{pkgs, ...}: {
  home = {
    username = "bricked";
    homeDirectory = "/home/bricked";
  };

  stylix.enable = true;

  # Terminal
  programs.zsh.enable = true;
  programs.starship.enable = true;
  programs.kitty.enable = true;
  programs.lf.enable = true;
  programs.fastfetch.enable = true;
  programs.git = {
    enable = true;
    userName = "bricked";
    userEmail = "git@bricked.dev";
    extraConfig = {
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
  };
  programs.gh.enable = true;

  # Desktop environment
  wayland.windowManager.hyprland = {
    enable = true;
    settings.input.kb_layout = "de";
  };
  programs.wpaperd.enable = true;
  programs.ags.enable = true;
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

  # Music
  programs.spotify-player.enable = true;
  programs.cava.enable = true;

  # Apps
  programs.librewolf.enable = true;
  programs.vesktop.enable = true;
  home.packages = with pkgs; [heroic];
}
