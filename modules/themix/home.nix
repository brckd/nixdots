{
  config,
  lib,
  pkgs,
  inputs,
  self,
  ...
}: let
  inherit (lib) mkIf mkMerge toSentenceCase;
  inherit (config.lib.themix) mkForcable;
  cfg = config.themix;
in {
  imports = [
    ./common.nix
    self.homeModules.stylix
  ];
  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.themes.adwaita.enable (mkMerge [
      (mkIf cfg.targets.icons.enable {
        stylix.iconTheme = {
          package = mkForcable pkgs.morewaita-icon-theme;
          light = mkForcable "MoreWaita";
          dark = mkForcable "MoreWaita";
        };
      })
    ]))

    (mkIf cfg.themes.macos.enable (mkMerge [
      (mkIf cfg.targets.fonts.enable {
        stylix.fonts = with inputs.apple-fonts.packages.${pkgs.system}; rec {
          sansSerif = {
            package = mkForcable sf-pro;
            name = mkForcable "SF Pro";
          };
          serif = sansSerif;
          monospace = {
            package = mkForcable sf-mono-nerd;
            name = mkForcable "SFMono Nerd Font";
          };
        };
      })
      (mkIf cfg.targets.colors.enable {
        stylix.override =
          {
            base08 = "ed5f5d";
            base09 = "f3ba4b";
            base0A = "f3ba4b";
            base0B = "79b757";
            base0D = "257cf7";
            base0E = "9a57a3";
            base0F = "e55e9c";
          }
          // (
            if cfg.polarity == "light"
            then rec {
              base00 = "ffffff";
              base01 = "f5f5f5";
              base02 = "f1f1f1";
              base03 = "1e333a";
              base04 = base03;
              base05 = "363636";
            }
            else rec {
              base00 = "242424";
              base01 = "333333";
              base02 = "2a2a2a";
              base03 = "d9dce3";
              base04 = base03;
              base05 = "dadada";
            }
          );
      })
      (mkIf cfg.targets.icons.enable {
        stylix.iconTheme = {
          package = mkForcable pkgs.whitesur-icon-theme;
          dark = mkForcable "WhiteSur-${cfg.polarity}";
        };
      })
      (mkIf cfg.targets.cursor.enable {
        stylix.cursor = {
          package = mkForcable pkgs.whitesur-cursors;
          name = mkForcable "WhiteSur-cursors";
        };
      })
      (mkIf cfg.targets.gtk.enable {
        gtk.theme = {
          package = mkForcable pkgs.whitesur-gtk-theme;
          name = mkForcable "WhiteSur-${toSentenceCase cfg.polarity}";
        };
        stylix.targets.gtk.flatpakSupport.enable = mkForcable false;
      })
      (mkIf cfg.targets.wallpaper.enable {
        stylix.image = mkForcable "${inputs.whitesur-wallpapers}/4k/WhiteSur-${cfg.polarity}.jpg";
      })
      (mkIf cfg.targets.shell.enable (let
        extensions = with pkgs.gnomeExtensions; [
          blur-my-shell
          user-themes
          dash-to-dock
          arc-menu
        ];
      in {
        home.packages = extensions;
        dconf.settings = {
          "org/gnome/shell/extensions/user-theme" = {
            name = mkForcable "WhiteSur-${toSentenceCase cfg.polarity}";
          };
          "org/gnome/desktop/wm/preferences" = {
            button-layout = "close,maximize,minimize:appmenu";
          };
          "org/gnome/shell" = {
            enabled-extensions = map (e: e.extensionUuid) extensions;
          };
          "org/gnome/shell/extensions/arcmenu" = {
            arc-menu-icon = 64;
            menu-layout = "GnomeOverview";
          };
          "org/gnome/shell/extensions/dash-to-dock" = {
            dash-max-icon-size = 64;
            dock-fixed = true;
            multi-monitur = true;
            scroll-action = "switch-workspace";
            show-show-apps-button = false;
          };
        };
      }))
    ]))
  ]);
}
