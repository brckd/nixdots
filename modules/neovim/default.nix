{ config, pkgs, lib, ... }:

with lib; {
  options.modules.neovim = { enable = mkEnableOption "neovim"; };

  config = mkIf config.modules.kitty.enable {
    home.packages = with pkgs; [ neovim ];
  };
}
