{pkgs, ...}: {
  system.stateVersion = "23.11";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  environment.packages = with pkgs; [zsh];
  user.shell = "${pkgs.zsh}/bin/zsh";

  stylix = {
    enable = true;
    autoEnable = false;
    targets.terminal.enable = true;
  };
}
