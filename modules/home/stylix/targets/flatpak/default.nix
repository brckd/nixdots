{
  config,
  lib,
  pkgs,
  ...
}: {
  options.stylix.targets.flatpak.enable = config.lib.stylix.mkEnableTarget "Flatpak" true;

  config = lib.mkIf (config.stylix.enable && config.stylix.targets.flatpak.enable) {
    services.flatpak.overrides.global = {
      Context.filesystems = ["${config.home.homeDirectory}/.themes/${config.gtk.theme.name}"];
      Environment.GTK_THEME = config.gtk.theme.name;
    };

    home.file.".themes/${config.gtk.theme.name}".source = pkgs.stdenv.mkDerivation {
      name = "flattenedGtkTheme";
      src = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}";

      installPhase = ''
        mkdir $out
        cp -rL . $out

        config="${config.xdg.configFile."gtk-3.0/gtk.css".source}"
        cat "$config" >> $out/gtk-3.0/gtk.css
        cat "$config" >> $out/gtk-4.0/gtk.css
      '';
    };
  };
}
