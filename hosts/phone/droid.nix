{
  self,
  pkgs,
  ...
}: {
  imports = [self.nixOnDroidModules.all];

  system.stateVersion = "24.05";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  user.shell = "${pkgs.fish}/bin/fish";
  stylix.enable = true;

  environment.packages = with pkgs; [zsh git];
}
