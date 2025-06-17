{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.helix;
in {
  config = mkIf cfg.enable {
    programs.helix = {
      settings = {
        editor = {
          auto-format = false;
          cursor-shape.insert = "bar";
          file-picker.hidden = false;
          whitespace.render.tab = "all";
        };
      };

      languages = {
        language-server = {
          astro-ls = {
            command = "astro-ls";
            args = ["--stdio"];
            config = {
              typescript.tsdk = "${pkgs.typescript}/lib/node_modules/typescript/lib";
              environment = "node";
            };
          };

          vscode-json-language-server = {
            config.json.schemas = [
              {
                fileMatch = ["tsconfig.json"];
                url = "https://json.schemastore.org/tsconfig";
              }
            ];
          };

          nixd = {
            command = "nixd";
          };

          rust-analyzer = {
            config.check.command = "clippy";
          };

          tinymist = {
            command = "tinymist";
          };

          yaml-language-server = {
            config.yaml.schemas = {
              "https://json.schemastore.org/github-workflow.json" = ".github/workflows/*.{yml, yaml}";
            };
          };
        };

        language =
          [
            {
              name = "astro";
              language-servers = ["astro-ls"];
            }
            {
              name = "nix";
              language-servers = ["nixd"];
              formatter.command = "alejandra";
            }
            {
              name = "toml";
              formatter = {
                command = "taplo";
                args = ["fmt" "-"];
              };
            }
            {
              name = "typst";
              language-servers = ["tinymist"];
              formatter.command = "typstyle";
            }
          ]
          ++ map (
            {
              name,
              extension ? name,
            }: {
              inherit name;
              formatter = {
                command = "biome";
                args = ["format" "--stdin-file-path" "stdin.${extension}" "--indent-style" "space"];
              };
            }
          ) [
            {
              name = "javascript";
              extension = "js";
            }
            {
              name = "typescript";
              extension = "ts";
            }
            {
              name = "jsx";
            }
            {
              name = "tsx";
            }
            {
              name = "json";
            }
          ];
      };
    };

    home.packages = with pkgs; [
      astro-language-server
      vscode-langservers-extracted # HTML, CSS, JSON
      marksman # Markdown
      nixd
      alejandra
      python313Packages.python-lsp-server
      rust-analyzer
      clippy # Rust linter
      taplo # TOML formatter
      tinymist # Typst
      typstyle
      typescript
      typescript-language-server
      biome
      yaml-language-server
    ];
  };
}
