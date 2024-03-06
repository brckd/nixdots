{
  config,
  lib,
  pkgs,
  nixvim,
  ...
}:
with lib; let
  cfg = config.programs.nixvim;
in {
  imports = [nixvim.homeManagerModules.nixvim];

  config = {
    home.packages = with pkgs; [(mkIf cfg.plugins.telescope.enable fd)];

    programs.nixvim = {
      viAlias = true;
      vimAlias = true;

      options = {
        # Tabs
        smartindent = true;
        tabstop = 2;
        shiftwidth = 2;

        # Line numbers
        relativenumber = true;
        number = true;
      };

      keymaps = let
        options = {
          silent = true;
        };
      in [
        {
          action = "<cmd>Telescope find_files<CR>";
          key = "<C-f>";
          inherit options;
        }
        {
          action = "<cmd>Telescope live_grep<CR>";
          key = "<C-g>";
          inherit options;
        }
        {
          action = "<cmd>NvimTreeToggle<CR>";
          key = "<C-n>";
          inherit options;
        }
      ];

      plugins = {
        treesitter.enable = true;
        lsp = {
          enable = true;
          servers = {
            nil_ls.enable = true;
            tsserver.enable = true;
            eslint.enable = true;
            rust-analyzer = {
              enable = true;
              installCargo = true;
              installRustc = true;
            };
            lua-ls.enable = true;
            astro.enable = true;
          };
        };
        luasnip.enable = true;

        nvim-cmp = {
          enable = true;
          autoEnableSources = true;
          sources = [
            {name = "treesitter";}
            {name = "nvim_lsp";}
            {name = "buffer";}
            {name = "luasnip";}
          ];
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = {
              action = ''
                function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif luasnip.expandable() then
                    luasnip.expand()
                  elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                  elseif check_backspace() then
                    fallback()
                  else
                    fallback()
                  end
                end
              '';
              modes = ["i" "s"];
            };
          };
        };

        indent-blankline.enable = true;
        nvim-autopairs.enable = true;

        telescope.enable = true;
        nvim-tree.enable = true;
        lualine.enable = true;
        which-key.enable = true;
      };
    };
  };
}
