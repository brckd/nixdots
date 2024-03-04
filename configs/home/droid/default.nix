{ ... }:

{
  # Terminal
  programs.zsh.enable = true;
  programs.starship.enable = true;
  programs.fastfetch.enable = true;
	programs.git.enable = true;
	programs.gh.enable = true;

  # Editor
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };
}
