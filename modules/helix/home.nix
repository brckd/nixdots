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
    programs.helix.languages = {
      language-server = {
        astro-ls = {
          command = "astro-ls";
          args = ["--stdio"];
          config = {
            typescript.tsdk = "${pkgs.typescript}/lib/node_modules/typescript/lib";
            environment = "node";
          };
        };

        nixd = {
          command = "nixd";
          formatting.command = ["alejandra"];
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

      language = [
        {
          name = "astro";
          language-servers = ["astro-ls"];
        }
        {
          name = "nix";
          language-servers = ["nixd"];
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
        }
      ];
    };

    home.packages = with pkgs; [
      astro-language-server
      vscode-langservers-extracted # HTML, CSS, JSON
      marksman # Markdown
      nixd
      python313Packages.python-lsp-server
      rust-analyzer
      clippy # Rust linter
      taplo # TOML formatter
      tinymist # Typst
      typescript
      typescript-language-server
      yaml-language-server
    ];
  };
}
