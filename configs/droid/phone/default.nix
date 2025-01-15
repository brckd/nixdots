{pkgs, ...}: {
  system.stateVersion = "24.05";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  environment.packages = with pkgs; [zsh git];

  stylix = {
    enable = true;
    autoEnable = false;
    targets.terminal.enable = true;
  };
  user.shell = "${pkgs.zsh}/bin/zsh";
}
