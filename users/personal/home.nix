{
  self,
  pkgs,
  ...
}: {
  imports = [self.homeModules.all];

  nixpkgs.config.allowUnfree = true;

  home = {
    stateVersion = "25.05";
    username = "personal";
    homeDirectory = "/home/personal";
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
  programs.fastfetch.enable = true;
  programs.git = {
    enable = true;
    extraConfig = {
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
  };
  services.gnome-keyring.enable = true;
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-gnome3;
  };
  programs.gh.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Editor
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };
  programs.vscode.enable = true;

  # Apps
  programs.librewolf.enable = true;
  programs.spicetify.enable = true;

  home.packages = with pkgs; [vesktop];
}
