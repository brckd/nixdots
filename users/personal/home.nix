{self, ...}: {
  imports = [self.homeModules.all];

  nixpkgs.config.allowUnfree = true;

  home = {
    stateVersion = "25.05";
    username = "personal";
    homeDirectory = "/home/personal";
  };

  programs.home-manager.enable = true;
  stylix.enable = true;

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
  programs.gh.enable = true;

  # Editor
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };

  # Apps
  programs.librewolf.enable = true;
  programs.spicetify.enable = true;
}
