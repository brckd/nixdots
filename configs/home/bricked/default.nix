{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  home = {
    username = "bricked";
    homeDirectory = "/home/bricked";
  };

  stylix.enable = true;

  # Terminal
  programs.zsh.enable = true;
  programs.fish.enable = true;
  programs.starship.enable = true;
  programs.direnv.enable = true;
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
      commit.gpgsign = true;
      pager = {
        diff = "riff";
        show = "riff";
        log = "riff";
      };
      interactive.diffFilter = "riff --color=on";
    };
  };
  services.gnome-keyring.enable = true;
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
  programs.gh.enable = true;
  programs.npm.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.nix-index-database.comma.enable = true;
  programs.nix-index.enable = true;
  programs.nix-your-shell.enable = true;

  # Editor
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };
  programs.vscode.enable = true;

  # Apps
  programs.librewolf.enable = true;
  programs.spicetify.enable = true;
  programs.cavalier = {
    enable = true;
    settings.general = {
      ShowControls = true;
      ColorProfiles = [
        {
          Name = "Default";
          FgColors = [
            "#ffed333b"
            "#ffffa348"
            "#fff8e45c"
            "#ff57e389"
            "#ff62a0ea"
            "#ffc061cb"
          ];
          BgColors = [
            "#ff1e1e2e"
          ];
          Theme = 1;
        }
      ];
      ActiveProfile = 0;
    };
  };
  home.packages = with pkgs; [vesktop riffdiff];
}
