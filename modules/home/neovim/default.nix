{ config, pkgs, lib, ... }:


with lib;
let mkPlugin = { plugin, as ? null, config ? "{}", configs ? null, ... }: {
  plugin = if (builtins.typeOf plugin) == "string"
    then pkgs.vimPlugins.${plugin}
    else plugin;
  config = if as != null then ''
    lua << EOF
    local module = require('${as}')
    ${ if config != null then "module.setup${config}" else "" }
    ${ if configs != null
      then toString (mapAttrs
        (name: conf: "module.${name}.setup${configs}\n")
        configs)
      else ""
    }
    EOF
  '' else "";
};
in {
  options.modules.neovim = { enable = mkEnableOption "neovim"; };

  config = mkIf config.modules.kitty.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      extraLuaConfig = builtins.readFile ./init.lua;

      coc.enable = true;
      plugins = with pkgs.vimPlugins; map mkPlugin [
        {
          plugin = vim-nix;
        }
        {
          plugin = plenary-nvim;
        }
        {
          plugin = nvim-treesitter;
          as = "nvim-treesitter.configs";
        }
        {
          plugin = lualine-nvim;
          as = "lualine";
        }
        {
          plugin = telescope-nvim;
          as = "telescope";
        }
        {
          plugin = which-key-nvim;
          as = "which-key";
        }
        {
          plugin = nvim-autopairs;
          as = "nvim-autopairs";
        }
        {
          plugin = indent-blankline-nvim;
          as = "ibl";
        }
      ];
    };
  };
}
