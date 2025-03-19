{
  self,
  pkgs,
  ...
}: {
  imports = [self.homeModules.all];

  nixpkgs.config.allowUnfree = true;

  home = {
    stateVersion = "25.05";
    username = "bricked";
    homeDirectory = "/home/bricked";
  };

  programs.home-manager.enable = true;
  stylix.enable = true;
  themix = {
    enable = true;
    themes.adwaita.enable = true;
  };

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
    signing.format = "openpgp";
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
  programs.comma = {
    enable = true;
    package = null;
  };
  programs.nix-index-database.comma.enable = true;
  programs.nix-index = {
    enable = true;
    enableFishIntegration = false;
    enableZshIntegration = false;
    enableBashIntegration = false;
  };
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
