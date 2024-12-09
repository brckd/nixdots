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

      opts = {
        # Indentation
        smartindent = true; # Indent from prev. line and C syntax

        # Tabs
        expandtab = true; # Insert spaces instead of tabs
        list = true; # Highlight tabs
        tabstop = 2; # Tab display width
        shiftwidth = 0; # Same as tabstop

        # Line numbers
        number = true; # Enable line numbers
        relativenumber = true; # Relative to current line
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
        # Linting
        treesitter.enable = true;
        lsp = {
          enable = true;
          servers = {
            nil_ls.enable = true;
            ts_ls.enable = true;
            eslint.enable = true;
            rust_analyzer = {
              enable = true;
              installCargo = true;
              installRustc = true;
            };
            gopls.enable = true;
            lua_ls.enable = true;
            astro.enable = true;
            emmet_ls = {
              enable = true;
              filetypes = ["html" "css" "scss" "astro"];
            };
          };
        };

        # Autocompletion
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            sources = [
              {name = "treesitter";}
              {name = "nvim_lsp";}
              {name = "luasnip";}
              {name = "buffer";}
              {name = "emoji";}
            ];
            mapping = {
              "<C-Space>" = "cmp.mapping.complete()";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            };
          };
        };

        # Editing
        luasnip.enable = true;
        comment.enable = true;
        ts-context-commentstring.enable = true;
        nvim-autopairs.enable = true;

        # Preview
        markview = {
          enable = true;
          settings = {
            buf_ignore = [];
            hybrid_modes = ["i" "r"];
            modes = ["n" "x"];
          };
        };

        # UI
        web-devicons.enable = true;
        dashboard = {
          enable = true;
          settings = {
            config = {
              header = [
                "    _   _______  ___    ________  ___"
                "   / | / /  _/ |/ / |  / /  _/  |/  /"
                "  /  |/ // / |   /| | / // // /|_/ / "
                " / /|  // / /   | | |/ // // /  / /  "
                "/_/ |_/___//_/|_| |___/___/_/  /_/   "
                "                                     "
              ];
              footer = ["" "Cooonfiguring to infinity and beyond 🚀"];

              shortcut = [
                {
                  action = {
                    __raw = "function(path) vim.cmd('Telescope find_files') end";
                  };
                  desc = "Files";
                  group = "Label";
                  icon = " ";
                  icon_hl = "@variable";
                  key = "f";
                }
              ];
            };
          };
        };
        telescope.enable = true;
        nvim-tree.enable = true;
        lualine.enable = true;
        which-key.enable = true;
        colorizer.enable = true;
        indent-blankline = {
          enable = true;
          settings.exclude.filetypes = ["dashboard"];
        };
      };
    };
  };
}
