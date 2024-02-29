{ pkgs, ... }:

{
  system.stateVersion = "23.11";

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
