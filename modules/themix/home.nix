{
  config,
  lib,
  pkgs,
  inputs,
  self,
  ...
}: let
  inherit (builtins) toJSON;
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

    (mkIf cfg.themes.material.enable (mkMerge [
      (mkIf cfg.targets.colors.enable {
        stylix.override =
          if cfg.polarity == "light"
          then {
            base00 = "f2f2f2";
            base01 = "fafafa";
            base02 = "fafafa";
            base03 = "ffffff";
            base04 = "ffffff";
            base05 = "000000";

            base08 = "f44336";
            base0F = "f06202";
            base07 = "ba68c8";
            base0D = "3281ea";
            base0C = "4db6ac";
            base0B = "66bb6a";
            base0A = "fbc02d";
            base09 = "fb8c00";
          }
          else {
            base00 = "212121";
            base01 = "242424";
            base02 = "2c2c2c";
            base03 = "3c3c3c";
            base04 = "464646";
            base05 = "f5f5f5";

            base08 = "e53935";
            base0F = "ec407a";
            base07 = "ab47bc";
            base0D = "1a73e8";
            base0C = "009688";
            base0B = "4caf50";
            base0A = "ffd600";
            base09 = "f57c00";
          };
      })

      (mkIf cfg.targets.wallpaper.enable {
        stylix.image = mkForcable "${inputs.orchis-theme}/wallpaper/4k.jpg";
      })

      (mkIf cfg.targets.gtk.enable {
        gtk.theme = {
          package = mkForcable (pkgs.orchis-theme.overrideAttrs {
            tweaks = ["solid" "primary"];
            border-radius = 12;
          });
          name = mkForcable "Orchis-${toSentenceCase cfg.polarity}";
        };
        stylix.targets.gtk.flatpakSupport.enable = mkForcable false;
      })

      (mkIf cfg.targets.shell.enable (let
        extensions = with pkgs.gnomeExtensions; [user-themes];
      in {
        home.packages = extensions;
        dconf.settings = {
          "org/gnome/shell/extensions/user-theme" = {
            name = mkForcable "Orchis-${toSentenceCase cfg.polarity}";
          };
          "org/gnome/shell" = {
            enabled-extensions = map (e: e.extensionUuid) extensions;
          };
        };
      }))
    ]))

    (mkIf cfg.themes.windows.enable (mkMerge [
      (mkIf cfg.targets.icons.enable {
        stylix.iconTheme = {
          package = mkForcable self.packages.${pkgs.system}.win11-icon-theme;
          light = mkForcable "Win11";
          dark = mkForcable "Win11";
        };
      })

      (mkIf cfg.targets.cursor.enable {
        stylix.cursor = {
          package = mkForcable pkgs.vanilla-dmz;
          name = mkForcable "DMZ-White";
        };
      })

      (mkIf cfg.targets.gtk.enable {
        gtk.theme = {
          package = mkForcable (pkgs.fluent-gtk-theme.overrideAttrs {
            tweaks = ["blur" "square"];
          });
          name = mkForcable "Fluent-${toSentenceCase cfg.polarity}";
        };
        stylix.targets.gtk.flatpakSupport.enable = mkForcable false;
      })

      (mkIf cfg.targets.wallpaper.enable {
        stylix.image =
          mkForcable
          {
            light = pkgs.fetchurl {
              url = "https://4kwallpapers.com/images/wallpapers/windows-11-blue-stock-white-background-light-official-3840x2160-5616.jpg";
              sha256 = "1nkgrbz6gf7b7il49qvcah4bjsjmaaa7jrja827zxdrw2k6h6i36";
            };
            dark = pkgs.fetchurl {
              url = "https://4kwallpapers.com/images/wallpapers/windows-11-dark-mode-blue-stock-official-3840x2160-5630.jpg";
              sha256 = "140zz2csz4lkr3fhs3m9gbyfmwmw61sgflw5mj3n6r3fqhd51sc7";
            };
          }
          .${
            cfg.polarity
          };
      })

      (mkIf cfg.targets.colors.enable {
        stylix.override =
          {
            light = rec {
              base00 = "f2f2f2";
              base01 = "ffffff";
              base02 = "ffffff";
              base03 = "1e333a";
              base04 = base03;
              base05 = "000000";
              base06 = base0F;
              base07 = base0E;
              base08 = "e53935";
              base09 = "f57c00";
              base0A = "fbc02d";
              base0B = "4caf50";
              base0C = "009688";
              base0D = "1a73e8";
              base0E = "ab47bc";
              base0F = "ec407a";
            };
            dark = rec {
              base00 = "333333";
              base01 = "3c3c3c";
              base02 = "2b2b2b";
              base03 = "303030";
              base04 = base03;
              base05 = "ffffff";

              base06 = base0F;
              base07 = base0E;
              base08 = "f44336";
              base09 = "fb8c00";
              base0A = "ffd600";
              base0B = "66bb6a";
              base0C = "26a69a";
              base0D = "3281ea";
              base0E = "ba68c8";
              base0F = "f06292";
            };
          }
          .${
            cfg.polarity
          };
      })

      (mkIf cfg.targets.shell.enable (let
        extensions = with pkgs.gnomeExtensions; [
          blur-my-shell
          user-themes
          dash-to-panel
          arc-menu
          desktop-icons-ng-ding
          date-menu-formatter
          appindicator
        ];
        panelSize = 48;
        iconPadding = 8;
      in {
        home.packages = extensions;
        dconf.settings = {
          "org/gnome/shell/extensions/user-theme" = {
            name = mkForcable "Fluent-${toSentenceCase cfg.polarity}";
          };
          "org/gnome/desktop/wm/preferences" = {
            button-layout = "appmenu:minimize,maximize,close";
          };
          "org/gnome/shell" = {
            enabled-extensions = map (e: e.extensionUuid) extensions;
          };
          "org/gnome/shell/extensions/appindicator" = {
            icon-opacity = 255;
          };
          "org/gnome/shell/extensions/arcmenu" = {
            button-padding = 5;
            custom-menu-button-icon = "distributor-logo-windows";
            custom-menu-button-icon-size = panelSize - iconPadding + 0.0;
            force-menu-location = "BottomCentered";
            menu-button-icon = "Custom_Icon";
            menu-layout = "Eleven";
          };
          "org/gnome/shell/extensions/blur-my-shell/panel" = {
            brightness = 1.0;
            override-background = false;
            pipeline = "pipeline_default";
            sigma = 60;
            static-blur = false;
          };
          "org/gnome/shell/extensions/dash-to-panel" = {
            appicon-margin = 0;
            appicon-padding = iconPadding;
            dot-style-focused = "DASHES";
            dot-style-unfocused = "DASHES";
            hide-overview-on-startup = true;
            panel-element-positions =
              toJSON
              {
                "0" = [
                  {
                    "element" = "showAppsButton";
                    "visible" = false;
                    "position" = "stackedTL";
                  }
                  {
                    "element" = "activitiesButton";
                    "visible" = false;
                    "position" = "stackedTL";
                  }
                  {
                    "element" = "leftBox";
                    "visible" = true;
                    "position" = "centerMonitor";
                  }
                  {
                    "element" = "taskbar";
                    "visible" = true;
                    "position" = "centerMonitor";
                  }
                  {
                    "element" = "centerBox";
                    "visible" = true;
                    "position" = "stackedBR";
                  }
                  {
                    "element" = "rightBox";
                    "visible" = true;
                    "position" = "stackedBR";
                  }
                  {
                    "element" = "systemMenu";
                    "visible" = true;
                    "position" = "stackedBR";
                  }
                  {
                    "element" = "dateMenu";
                    "visible" = true;
                    "position" = "stackedBR";
                  }
                  {
                    "element" = "desktopButton";
                    "visible" = true;
                    "position" = "stackedBR";
                  }
                ];
              };
            panel-lengths = toJSON {
              "0" = 100;
            };
            panel-sizes = toJSON {
              "0" = panelSize;
            };
            primary-monitor = 0;
            tray-padding = 4;
            tray-size = 16;
          };
          "org/gnome/shell/extensions/date-menu-formatter" = {
            pattern = "HH:mm\\ndd MMM yy";
            text-align = "center";
            update-level = 1;
          };
        };
      }))
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
          rec {
            base06 = base0F;
            base07 = base0E;
            base08 = "ed5f5d";
            base09 = "f3ba4b";
            base0A = "f3ba4b";
            base0B = "79b757";
            base0D = "257cf7";
            base0E = "9a57a3";
            base0F = "e55e9c";
          }
          // {
            light = {
              base00 = "ffffff";
              base01 = "f5f5f5";
              base02 = "f1f1f1";
              base03 = "1e333a";
              base04 = "1e333a";
              base05 = "363636";
            };
            dark = {
              base00 = "242424";
              base01 = "333333";
              base02 = "2a2a2a";
              base03 = "d9dce3";
              base04 = "d9dce3";
              base05 = "dadada";
            };
          }
          .${
            cfg.polarity
          };
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
          desktop-icons-ng-ding
          wiggle
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
