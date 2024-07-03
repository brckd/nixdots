{
  config,
  lib,
  pkgs,
  nixos-symbolic,
  ...
}:
with lib; let
  cfg = config.programs.ags;
in {
  config = mkIf cfg.enable {
    programs.ags = {
      configDir = pkgs.buildNpmPackage {
        name = "ags-dots";
        src = ./.;
        npmDepsHash = "sha256-0Phl7IrrKSd8j4yQ3nefJ4xT/QgrvDnlN68G7bDHCfE=";

        nativeBuildInputs = with pkgs; [bun];
        postPatch = ''
          cp ${nixos-symbolic} ./assets/nixos-symbolic.svg
        '';
        installPhase = ''
          mkdir -p $out
          cp -r config.js assets $out
        '';
      };
      extraPackages = with pkgs; [libdbusmenu-gtk3];
    };
    gtk = {
      enable = true;
      iconTheme = {
        name = "MoreWaita";
        package = pkgs.morewaita-icon-theme;
      };
    };
    wayland.windowManager.hyprland.settings.exec = ["ags --quit; ags"];
    home.packages = with pkgs; [bun prefetch-npm-deps gnome.adwaita-icon-theme morewaita-icon-theme];
  };
}
