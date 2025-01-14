{pkgs, ...}: {
  system.stateVersion = "24.05";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  environment.packages = with pkgs; [zsh];
  user.shell = "${pkgs.zsh}/bin/zsh";
}
