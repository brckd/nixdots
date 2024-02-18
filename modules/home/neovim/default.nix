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
        {
          plugin = nvim-treesitter.withPlugins (
            plugins: with plugins; [
              yuck
            ]
          );
          config = lua "require('nvim-treesitter.configs').setup{}";
        }
        {
          plugin = lualine-nvim;
          config = lua "require('lualine').setup{}";
        }
        {
          plugin = telescope-nvim;
          config = lua "require('telescope').setup{}";
        }
        {
          plugin = which-key-nvim;
          config = lua "require('which-key').setup{}";
        }
        {
          plugin = nvim-autopairs;
          config = lua "require('nvim-autopairs').setup{}";
        }
        {
          plugin = indent-blankline-nvim;
          config = lua "require('ibl').setup{}";
        }
      ];
    };
  };
}
