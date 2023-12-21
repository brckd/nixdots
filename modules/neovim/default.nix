{ config, pkgs, lib, ... }:


with lib;
let setup = module: configs: ''
  lua << EOF
  require('${module}').setup{${configs}}
  EOF
'';
in {
  options.modules.neovim = { enable = mkEnableOption "neovim"; };

  config = mkIf config.modules.kitty.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      extraLuaConfig = ''
        vim.wo.relativenumber = true
      '';

      coc.enable = true;
      plugins = with pkgs.vimPlugins; [
        vim-nix
        plenary-nvim
        {
          plugin = lualine-nvim;
          config = setup "lualine" "";
        }
        {
          plugin = telescope-nvim;
          config = setup "telescope" "";
        }
        {
          plugin = which-key-nvim;
          config = setup "which-key" "";
        }
        {
          plugin = nvim-treesitter;
          config = setup "nvim-treesitter.configs" "";
        }
        {
          plugin = nvim-autopairs;
          config = setup "nvim-autopairs" "";
        }
        {
          plugin = indent-blankline-nvim;
          config = setup "ibl" "";
        }
      ];
    };
  };
}
