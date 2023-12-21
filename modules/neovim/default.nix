{ config, pkgs, lib, ... }:

with lib; {
  options.modules.neovim = { enable = mkEnableOption "neovim"; };

  config = mkIf config.modules.kitty.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      coc.enable = true;
    };
  };
}
