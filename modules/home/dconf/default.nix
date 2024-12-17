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
              (mkAppPickerLayout "System" 0)
              (mkAppPickerLayout "Productivity" 1)
              (mkAppPickerLayout "Gaming" 2)
              (mkAppPickerLayout "Office" 3)
              (mkAppPickerLayout "Multimedia" 4)
              (mkAppPickerLayout "Social" 5)
              (mkAppPickerLayout "Coding" 6)
            ]];
            */
          };

          "org/gnome/desktop/app-folders" = {
            folder-children = ["System" "Productivity" "Gaming" "Office" "Multimedia" "Social" "Coding"];
          };

          "org/gnome/desktop/app-folders/folders/System" = {
            apps = ["org.gnome.SystemMonitor.desktop" "org.gnome.Settings.desktop" "yelp.desktop" "nixos-manual.desktop" "org.gnome.Extensions.desktop" "org.gnome.DiskUtility.desktop" "winetricks.desktop" "ca.desrt.dconf-editor.desktop" "org.gnome.Characters.desktop" "org.gnome.baobab.desktop" "org.gnome.FileRoller.desktop" "org.gnome.font-viewer.desktop" "org.gnome.Logs.desktop" "org.gnome.seahorse.Application.desktop" "io.github.Foldex.AdwSteamGtk.desktop"];
            name = "System";
            translate = false;
          };

          "org/gnome/desktop/app-folders/folders/Productivity" = {
            apps = ["org.gnome.Geary.desktop" "org.gnome.Contacts.desktop" "org.gnome.clocks.desktop" "org.gnome.Calendar.desktop" "org.gnome.Maps.desktop" "org.gnome.Calculator.desktop"];
            name = "Productivity";
            translate = false;
          };

          "org/gnome/desktop/app-folders/folders/Gaming" = {
            apps = ["page.kramo.Cartridges.desktop" "com.heroicgameslauncher.hgl.desktop" "itch.desktop" "Rocket League®.desktop" "steam.desktop" "Baba Is You.desktop" "Bloons TD 6.desktop" "Modrinth App.desktop" "Progressbar95.desktop" "Proton Experimental.desktop" "Raft.desktop" "Rogue Tower.desktop" "Satisfactory.desktop" "Sheepy A Short Adventure.desktop" "Steam Linux Runtime 1.0 (scout).desktop" "Steam Linux Runtime 2.0 (soldier).desktop" "Steam Linux Runtime 3.0 (sniper).desktop" "Word Factori.desktop"];
            name = "Gaming";
            translate = false;
          };

          "org/gnome/desktop/app-folders/folders/Office" = {
            apps = ["startcenter.desktop" "base.desktop" "calc.desktop" "draw.desktop" "impress.desktop" "math.desktop" "writer.desktop" "org.gnome.Evince.desktop"];
            name = "Office";
          };

          "org/gnome/desktop/app-folders/folders/Multimedia" = {
            apps = ["app.fotema.Fotema.desktop" "org.gnome.Nautilus.desktop" "de.haeckerfelix.Fragments.desktop" "spotify.desktop" "gimp.desktop" "org.gnome.Snapshot.desktop" "org.gnome.Totem.desktop" "org.gnome.Music.desktop" "io.github.nate_xyz.Conjure.desktop" "com.github.huluti.Curtail.desktop" "io.github.seadve.Kooha.desktop" "io.gitlab.adhami3310.Converter.desktop" "lf.desktop" "io.gitlab.theevilskeleton.Upscaler.desktop" "org.gnome.Loupe.desktop"];
            name = "Multimedia";
            translate = false;
          };

          "org/gnome/desktop/app-folders/folders/Social" = {
            apps = ["vesktop.desktop" "dev.geopjr.Tuba.desktop" "org.gnome.Fractal.desktop"];
            name = "Social";
            translate = false;
          };

          "org/gnome/desktop/app-folders/folders/Coding" = {
            apps = ["org.gnome.TextEditor.desktop" "codium.desktop"];
            name = "Coding";
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
