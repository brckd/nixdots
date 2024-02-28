{ pkgs, ... }:

{
  system.stateVersion = "23.05";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  environment.packages = with pkgs; [
    git
    gh
	  zsh
	];

	user.shell = "${pkgs.zsh}/bin/zsh";
}
