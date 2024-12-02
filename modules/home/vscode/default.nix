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
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        dbaeumer.vscode-eslint
        astro-build.astro-vscode
        rust-lang.rust-analyzer
        golang.go
        sumneko.lua
        esbenp.prettier-vscode
      ];
      userSettings = {
        "editor.fontFamily" = "'JetBrainsMono Nerd Font Mono'";
        "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font Mono'";
        "workbench.colorTheme" = "Stylix";
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "prettier.proseWrap" = "always";
        "[rust]"."editor.defaultFormatter" = "rust-lang.rust-analyzer";
        "git.confirmSync" = false;
        "git.suggestSmartCommit" = false;
        "git.autofetch" = true;
      };
    };
  };
}
