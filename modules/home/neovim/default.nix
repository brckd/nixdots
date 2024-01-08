{ config, pkgs, lib, ... }:


with lib;
let lua = script:
  if hasInfix "\n" script then ''
    lua << EOF
      ${script}
    EOF
  '' else "lua ${script}";
in {
  options.modules.neovim = {
    enable = mkEnableOption "Enable Neovim editor.";
  };

  config = mkIf config.modules.kitty.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      extraLuaConfig = builtins.readFile ./init.lua;

      coc.enable = true;
      plugins = with pkgs.vimPlugins; [
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
