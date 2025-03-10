{
  config,
  lib,
  pkgs,
  ...
}:
with builtins;
with lib; let
  cfg = config.programs.vscode;
in {
  config = mkIf cfg.enable {
    programs.vscode = {
      package = pkgs.vscodium;
      mutableExtensionsDir = false;
      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
          dbaeumer.vscode-eslint
          astro-build.astro-vscode
          rust-lang.rust-analyzer
          golang.go
          sumneko.lua
          esbenp.prettier-vscode
          ms-python.python
          visualstudiotoolsforunity.vstuc
          unifiedjs.vscode-mdx
        ];
        userSettings = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
          "prettier.proseWrap" = "always";
          "[rust]"."editor.defaultFormatter" = "rust-lang.rust-analyzer";
          "git.confirmSync" = false;
          "git.suggestSmartCommit" = false;
          "git.autofetch" = true;
        };
      };
    };
  };
}
