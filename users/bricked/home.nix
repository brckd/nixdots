{
  self,
  pkgs,
  ...
}: {
  imports = [self.homeModules.all];

  nixpkgs.config.allowUnfree = true;

  home = {
    stateVersion = "25.11";
    username = "bricked";
    homeDirectory = "/home/bricked";
  };

  programs.home-manager.enable = true;

  # Theming
  stylix.enable = true;
  themix = {
    enable = true;
    themes.adwaita.enable = true;
  };
  services.mithril-shell.enable = true;

  # Terminal
  programs.fish.enable = true;
  programs.starship.enable = true;
  programs.direnv.enable = true;
  programs.ghostty.enable = true;
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
  programs.gh.enable = true;
  programs.zoxide.enable = true;
  programs.nix-index.enable = true;
  programs.nix-your-shell.enable = true;

  # Editor
  programs.helix = {
    enable = true;
    defaultEditor = true;
  };
  programs.vscode.enable = true;

  # Apps
  programs.librewolf.enable = true;
  programs.spicetify.enable = true;

  xdg.desktopEntries.adwaitaDemo = {
    name = "Adwaita Demo";
    exec = "adwaita-1-demo";
    icon = "org.gnome.Adwaita1.Demo-symbolic";
    terminal = false;
    categories = ["Development"];
  };

  home.packages = [pkgs.riffdiff pkgs.libadwaita.devdoc];
}
