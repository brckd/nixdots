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
    clipboard-indicator
    reboottouefi
    caffeine
    forge
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
          };

          # App Picker
          "org/gnome/desktop/app-folders" = {
            folder-children = ["System" "Ressources" "Productivity" "Files" "Media" "Design" "Office" "Games" "Social" "Development" "Libraries"];
          };

          "org/gnome/desktop/app-folders/folders/System" = {
            apps = ["org.gnome.Settings.desktop" "ca.desrt.dconf-editor.desktop" "org.gnome.Logs.desktop" "org.gnome.Extensions.desktop" "nixos-manual.desktop" "yelp.desktop"];
            name = "System";
            translate = false;
          };

          "org/gnome/desktop/app-folders/folders/Ressources" = {
            apps = ["org.gnome.SystemMonitor.desktop" "org.gnome.baobab.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.font-viewer.desktop" "org.gnome.Characters.desktop" "org.gnome.seahorse.Application.desktop"];
            name = "Ressources";
            translate = false;
          };

          "org/gnome/desktop/app-folders/folders/Productivity" = {
            apps = ["org.gnome.Geary.desktop" "org.gnome.Contacts.desktop" "org.gnome.clocks.desktop" "org.gnome.Calendar.desktop" "org.gnome.Maps.desktop" "org.gnome.Calculator.desktop"];
            name = "Productivity";
            translate = false;
          };

          "org/gnome/desktop/app-folders/folders/Files" = {
            apps = ["org.gnome.Nautilus.desktop" "org.gnome.FileRoller.desktop" "de.haeckerfelix.Fragments.desktop" "lf.desktop"];
            name = "Files";
            translate = false;
          };

          "org/gnome/desktop/app-folders/folders/Media" = {
            apps = ["app.fotema.Fotema.desktop" "org.gnome.Loupe.desktop" "org.gnome.Totem.desktop" "org.gnome.Music.desktop" "org.gnome.Snapshot.desktop" "io.github.seadve.Kooha.desktop" "spotify.desktop" "org.nickvision.cavalier.desktop"];
            name = "Media";
            translate = false;
          };

          "org/gnome/desktop/app-folders/folders/Design" = {
            apps = ["gimp.desktop" "io.github.nate_xyz.Conjure.desktop" "io.gitlab.adhami3310.Converter.desktop" "io.gitlab.theevilskeleton.Upscaler.desktop" "com.github.huluti.Curtail.desktop" "com.belmoussaoui.Obfuscate.desktop"];
            name = "Design";
            translate = false;
          };

          "org/gnome/desktop/app-folders/folders/Office" = {
            apps = ["startcenter.desktop" "base.desktop" "calc.desktop" "draw.desktop" "impress.desktop" "math.desktop" "writer.desktop" "org.gnome.Evince.desktop"];
            name = "Office";
            translate = false;
          };

          "org/gnome/desktop/app-folders/folders/Games" = {
            apps = ["page.kramo.Cartridges.desktop" "steam.desktop" "com.heroicgameslauncher.hgl.desktop" "itch.desktop" "Modrinth App.desktop" "Rocket League\174.desktop" "Satisfactory.desktop" "Raft.desktop" "Sheepy A Short Adventure.desktop" "Progressbar95.desktop" "Baba Is You.desktop" "Bloons TD 6.desktop" "Rogue Tower.desktop" "Word Factori.desktop"];
            name = "Games";
            translate = false;
          };

          "org/gnome/desktop/app-folders/folders/Social" = {
            apps = ["vesktop.desktop" "dev.geopjr.Tuba.desktop" "org.gnome.Fractal.desktop"];
            name = "Social";
            translate = false;
          };

          "org/gnome/desktop/app-folders/folders/Development" = {
            apps = ["org.gnome.TextEditor.desktop" "codium.desktop"];
            name = "Development";
            translate = false;
          };

          "org/gnome/desktop/app-folders/folders/Libraries" = {
            apps = ["winetricks.desktop" "io.github.Foldex.AdwSteamGtk.desktop" "Proton Experimental.desktop" "Steam Linux Runtime 1.0 (scout).desktop" "Steam Linux Runtime 2.0 (soldier).desktop" "Steam Linux Runtime 3.0 (sniper).desktop"];
            name = "Libraries";
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
