{self, ...}: {
  imports = [self.homeModules.all];

  nixpkgs.config.allowUnfree = true;

  home = {
    stateVersion = "25.05";
    username = "nix-on-droid";
    homeDirectory = "/data/data/com.termux.nix/files/home";
  };

  programs.home-manager.enable = true;

  stylix = {
    enable = true;
    autoEnable = false;
    targets = {
      nixvim.enable = true;
      fish.enable = true;
    };
  };

  # Terminal
  programs.zsh.enable = true;
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
