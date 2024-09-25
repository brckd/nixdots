{
  config,
  lib,
  pkgs,
  ...
}:
with builtins;
with lib; let
  cfg = config.stylix.targets.spicetify;
  colors = with config.lib.stylix.colors; ''
    [base]
    text               = ${base05}
    subtext            = ${base05}
    main               = ${base00}
    main-elevated      = ${base02}
    highlight          = ${base02}
    highlight-elevated = ${base03}
    sidebar            = ${base01}
    player             = ${base05}
    card               = ${base04}
    shadow             = ${base00}
    selected-row       = ${base05}
    button             = ${base05}
    button-active      = ${base05}
    button-disabled    = ${base04}
    tab-active         = ${base02}
    notification       = ${base02}
    notification-error = ${base08}
    equalizer          = ${base0B}
    misc               = ${base02}
  '';
in {
  options.stylix.targets.spicetify.enable =
    config.lib.stylix.mkEnableTarget "Spicetify" true;

  config = mkIf (config.stylix.enable && cfg.enable) {
    programs.spicetify = {
      theme = {
        name = "stylix";
        src = pkgs.stdenv.mkDerivation {
          name = "stylix-spicetify-theme";
          unpackPhase = "true"; # Don't load any source
          buildPhase = ''
            cat << EOF > ./color.ini
            ${colors}
            EOF
          '';
          installPhase = ''
            mkdir -p $out
            cp ./color.ini $out
          '';
        };
        sidebarConfig = false;
      };
      colorScheme = "mocha";
    };
  };
}
