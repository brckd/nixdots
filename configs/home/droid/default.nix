{ ... }:

{
  # Terminal
  programs.zsh.enable = true;
  programs.starship.enable = true;
  programs.fastfetch.enable = true;

  # Editor
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
