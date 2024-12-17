{
  config,
  lib,
  pkgs,
  ...
}:
with builtins;
with lib; let
  cfg = config.dconf;
  extensions = with pkgs.gnomeExtensions; [
    launch-new-instance
    forge
    clipboard-indicator
    reboottouefi
  ];
  num-workspaces = 10;
in {
  config = mkIf cfg.enable {
    home.packages = extensions;
    dconf.settings = mkMerge ([
        {
          "org/gnome/shell" = {
            disable-user-extensions = false;
            enabled-extensions = map (e: e.extensionUuid) extensions;
          };

          "org/gnome/mutter" = {
            dynamic-workspaces = false;
          };

          "org/gnome/desktop/wm/preferences" = {
            resize-with-right-button = true;
            inherit num-workspaces;
          };

          "org/gnome/desktop/wm/keybindings" = {
            close = ["<Super>q"];
          };

          "org/gnome/shell/extensions/forge" = {
            dnd-center-layout = "swap";
          };

          "org/gnome/shell" = {
            favourite-apps = ["librewolf.desktop" "nvim.desktop" "kitty.desktop"];
            /*
            app-picker-layout = let
              mkAppPickerLayout = with lib.hm.gvariant; name: position: mkDictionaryEntry[
                name
                (mkVariant [mkDictionaryEntry["position" (mkInt32 position)]])
              ];
            in [[
              (mkAppPickerLayout "eae22aa9-9e0c-4e41-a250-b46a94953177" 0)
              (mkAppPickerLayout "775dd6c1-5121-4794-b920-2158a8e0052f" 1)
              (mkAppPickerLayout "b635b693-284c-4f98-9adc-06b23a6b6e81" 2)
              (mkAppPickerLayout "aa34a13c-6da2-42b9-95ed-c7517f787ccf" 3)
              (mkAppPickerLayout "95d41526-a331-422b-a8a6-47b47103f199" 4)
              (mkAppPickerLayout "f5b3d4e4-5f3e-4909-8c76-fcf35e3009eb" 5)
              (mkAppPickerLayout "49de0733-ec43-41d0-9cb3-8bb70a4776e4" 6)
            ]];
            */
          };

          "org/gnome/desktop/app-folders" = {
            folder-children = ["System" "Media" "Games" "Messaging" "Office" "Coding" "eae22aa9-9e0c-4e41-a250-b46a94953177" "95d41526-a331-422b-a8a6-47b47103f199" "b635b693-284c-4f98-9adc-06b23a6b6e81" "775dd6c1-5121-4794-b920-2158a8e0052f" "49de0733-ec43-41d0-9cb3-8bb70a4776e4" "f5b3d4e4-5f3e-4909-8c76-fcf35e3009eb" "aa34a13c-6da2-42b9-95ed-c7517f787ccf"];
          };

          "org/gnome/desktop/app-folders/folders/49de0733-ec43-41d0-9cb3-8bb70a4776e4" = {
            apps = ["org.gnome.TextEditor.desktop" "codium.desktop"];
            name = "Coding";
            translate = false;
          };

          "org/gnome/desktop/app-folders/folders/775dd6c1-5121-4794-b920-2158a8e0052f" = {
            apps = ["org.gnome.Geary.desktop" "org.gnome.Contacts.desktop" "org.gnome.clocks.desktop" "org.gnome.Calendar.desktop" "org.gnome.Maps.desktop" "org.gnome.Calculator.desktop"];
            name = "Productivity";
            translate = false;
          };

          "org/gnome/desktop/app-folders/folders/95d41526-a331-422b-a8a6-47b47103f199" = {
            apps = ["app.fotema.Fotema.desktop" "org.gnome.Nautilus.desktop" "de.haeckerfelix.Fragments.desktop" "spotify.desktop" "gimp.desktop" "org.gnome.Snapshot.desktop" "org.gnome.Totem.desktop" "org.gnome.Music.desktop" "io.github.nate_xyz.Conjure.desktop" "com.github.huluti.Curtail.desktop" "io.github.seadve.Kooha.desktop" "io.gitlab.adhami3310.Converter.desktop" "lf.desktop" "io.gitlab.theevilskeleton.Upscaler.desktop" "org.gnome.Loupe.desktop"];
            name = "Multimedia";
            translate = false;
          };

          "org/gnome/desktop/app-folders/folders/Pardus" = {
            categories = ["X-Pardus-Apps"];
            name = "X-Pardus-Apps.directory";
            translate = true;
          };

          "org/gnome/desktop/app-folders/folders/Utilities" = {
            apps = ["gnome-abrt.desktop" "gnome-system-log.desktop" "nm-connection-editor.desktop" "org.gnome.baobab.desktop" "org.gnome.Connections.desktop" "org.gnome.DejaDup.desktop" "org.gnome.Dictionary.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.Evince.desktop" "org.gnome.FileRoller.desktop" "org.gnome.fonts.desktop" "org.gnome.Loupe.desktop" "org.gnome.seahorse.Application.desktop" "org.gnome.tweaks.desktop" "org.gnome.Usage.desktop" "vinagre.desktop"];
            categories = ["X-GNOME-Utilities"];
            name = "X-GNOME-Utilities.directory";
            translate = true;
          };

          "org/gnome/desktop/app-folders/folders/YaST" = {
            categories = ["X-SuSE-YaST"];
            name = "suse-yast.directory";
            translate = true;
          };

          "org/gnome/desktop/app-folders/folders/aa34a13c-6da2-42b9-95ed-c7517f787ccf" = {
            apps = ["startcenter.desktop" "base.desktop" "calc.desktop" "draw.desktop" "impress.desktop" "math.desktop" "writer.desktop" "org.gnome.Evince.desktop"];
            name = "Office";
          };

          "org/gnome/desktop/app-folders/folders/b635b693-284c-4f98-9adc-06b23a6b6e81" = {
            apps = ["page.kramo.Cartridges.desktop" "com.heroicgameslauncher.hgl.desktop" "itch.desktop" "Rocket League®.desktop" "steam.desktop" "Baba Is You.desktop" "Bloons TD 6.desktop" "Modrinth App.desktop" "Progressbar95.desktop" "Proton Experimental.desktop" "Raft.desktop" "Rogue Tower.desktop" "Satisfactory.desktop" "Sheepy A Short Adventure.desktop" "Steam Linux Runtime 1.0 (scout).desktop" "Steam Linux Runtime 2.0 (soldier).desktop" "Steam Linux Runtime 3.0 (sniper).desktop" "Word Factori.desktop"];
            name = "Gaming";
            translate = false;
          };

          "org/gnome/desktop/app-folders/folders/eae22aa9-9e0c-4e41-a250-b46a94953177" = {
            apps = ["org.gnome.SystemMonitor.desktop" "org.gnome.Settings.desktop" "yelp.desktop" "nixos-manual.desktop" "org.gnome.Extensions.desktop" "org.gnome.DiskUtility.desktop" "winetricks.desktop" "ca.desrt.dconf-editor.desktop" "org.gnome.Characters.desktop" "org.gnome.baobab.desktop" "org.gnome.FileRoller.desktop" "org.gnome.font-viewer.desktop" "org.gnome.Logs.desktop" "org.gnome.seahorse.Application.desktop"];
            name = "System";
            translate = false;
          };

          "org/gnome/desktop/app-folders/folders/f5b3d4e4-5f3e-4909-8c76-fcf35e3009eb" = {
            apps = ["vesktop.desktop" "dev.geopjr.Tuba.desktop" "org.gnome.Fractal.desktop"];
            name = "Social";
            translate = false;
          };
        }
      ]
      ++ (map (i: {
        # See https://unix.stackexchange.com/a/677879
        "org/gnome/shell/keybindings" = {
          "switch-to-application-${toString i}" = [];
        };
        "org/gnome/desktop/wm/keybindings" = {
          "switch-to-workspace-${toString i}" = ["<Super>${toString (mod i 10)}"];
          "move-to-workspace-${toString i}" = ["<Super><Shift>${toString (mod i 10)}"];
        };
      }) (range 1 num-workspaces)));
  };
}
