{self, ...}: {
  imports = [self.homeModules.all];
  nixpkgs.config.allowUnfree = true;

  home = {
    stateVersion = "25.05";
    username = "john";
    homeDirectory = "/home/john";
  };

  programs.home-manager.enable = true;
  stylix.enable = true;
  themix = {
    enable = true;
    themes.adwaita.enable = true;
  };

  # Terminal
  programs.zsh.enable = true;
  programs.starship.enable = true;
  programs.kitty.enable = true;
  programs.git.enable = true;

  # Editor
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };

  # Apps
  programs.librewolf.enable = true;
  programs.spicetify.enable = true;
}
