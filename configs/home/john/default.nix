{
  nixpkgs.config.allowUnfree = true;
  home = {
    username = "john";
    homeDirectory = "/home/john";
  };

  stylix.enable = true;

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
