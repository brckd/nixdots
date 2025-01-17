{
  pkgs,
  config,
  lib,
  ...
}: {
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  environment.packages = with pkgs; [zsh git];

  user.shell = "${pkgs.zsh}/bin/zsh";
  stylix.enable = true;
}
