{
  heroic-theme,
  pkgs,
  config,
  ...
}: {
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
  programs.spicetify.enable = true;
  programs.heroic = {
    enable = false;
    settings = {
      general = {
        defaultSettings = {
          customThemesPath = "${heroic-theme}/themes";
        };
        version = "v0";
      };
      store = {
        userHome = config.home.homeDirectory;
        language = "en";
        theme = "catpuccin-mocha.css";
      };
    };
  };
  home.packages = with pkgs; [heroic];
}
