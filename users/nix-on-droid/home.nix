{self, ...}: {
  imports = [self.homeModules.all];

  home = {
    stateVersion = "25.05";
    username = "nix-on-droid";
    homeDirectory = "/data/data/com.termux.nix/files/home";
  };

  programs.home-manager.enable = true;
  stylix.enable = true;

  # Terminal
  programs.fish.enable = true;
  programs.starship.enable = true;
  programs.fastfetch.enable = true;
  programs.git.enable = true;
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

  # Misc
  dconf.enable = false;
}
