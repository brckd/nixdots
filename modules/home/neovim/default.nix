{ config, lib, pkgs, ... }:


with lib;
let
  cfg = config.programs.neovim;
  lua = script:
    if hasInfix "\n" script then ''
      lua << EOF
        ${script}
      EOF
    '' else "lua ${script}";
in {
  config = mkIf cfg.enable {
    programs.neovim = {
      viAlias = mkDefault true;
      vimAlias = mkDefault true;
      extraLuaConfig = mkDefault (builtins.readFile ./init.lua);

      coc.enable = mkDefault true;
      plugins = with pkgs.vimPlugins; mkDefault [
        vim-nix
        plenary-nvim
      ];
    };
  };
}
