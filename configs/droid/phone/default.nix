{pkgs, ...}: {
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  environment.packages = with pkgs; [zsh git];

  user.shell = "${pkgs.fish}/bin/fish";
  stylix.enable = true;
}
