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
    gamemode-shell-extension
    rounded-window-corners-reborn
    privacy-settings-menu
  ];
  workspacesCount = 10;
  mkSlug = str: concatStrings (filter (c: elem c lowerChars) (stringToCharacters (toLower str)));
  mkApp = name: "${name}.desktop";
  appFolders = [
    {
      name = "System";
      categories = ["System" "Settings" "Documentation"];
      apps = map mkApp ["org.gnome.Extensions"];
    }

    {
      name = "Core";
      categories = ["Core"];
      apps = map mkApp ["org.gnome.Maps" "org.gnome.clocks" "org.gnome.Calculator" "org.gnome.Contacts"];
    }

    {
      name = "Utility";
      categories = ["Utility"];
    }

    {
      name = "Network";
      categories = ["Network"];
    }

    {
      name = "Graphics";
      categories = ["Graphics"];
      apps = map mkApp ["app.fotema.Fotema" "com.belmoussaoui.Obfuscate"];
    }

    {
      name = "Sound & Video";
      categories = ["AudioVideo" "Audio" "Video" "Recorder"];
    }

    {
      name = "Development";
      categories = ["Development" "TextEditor"];
    }

    {
      name = "Office";
      categories = ["Office"];
    }

    {
      name = "Games";
      categories = ["Game"];
    }

    {
      name = "Waydroid";
      categories = ["X-WayDroid-App"];
    }

    {
      name = "Wine";
      categories = ["Wine" "X-Wine" "Wine-Programs-Accessories" "Application"];
    }

    {
      name = "Console";
      categories = ["ConsoleOnly"];
    }
  ];
in {
  config = mkIf cfg.enable {
    home.packages = extensions;
    dconf.settings = mkMerge ([
        {
          "org/gnome/shell" = {
            disable-user-extensions = false;
            disable-extension-version-validation = true;
            enabled-extensions = map (e: e.extensionUuid) extensions;
          };

          "org/gnome/mutter" = {
            dynamic-workspaces = false;
          };

          "org/gnome/desktop/wm/preferences" = {
            resize-with-right-button = true;
            num-workspaces = workspacesCount;
            focus-mode = "sloppy"; # Focus windows on hover
          };

          "org/gnome/desktop/wm/keybindings" = {
            close = ["<Super>q"];
          };

          "org/gnome/shell/extensions/forge" = {
            dnd-center-layout = "swap";
          };

          "org/gnome/shell" = {
            favourite-apps = map mkApp ["librewolf" "nvim" "kitty"];
          };

          # App Picker
          "org/gnome/desktop/app-folders" = {
            folder-children = map mkSlug (catAttrs "name" appFolders);
          };

          "org/gnome/shell" = {
            app-picker-layout = with lib.gvariant;
              singleton (imap0 (
                  i: appFolder:
                    mkDictionaryEntry (mkSlug appFolder.name) (mkVariant (singleton (
                      mkDictionaryEntry "position" (mkInt32 i)
                    )))
                )
                appFolders);
          };
        }

        (listToAttrs (map (
            appFolder:
              nameValuePair "org/gnome/desktop/app-folders/folders/${mkSlug appFolder.name}" appFolder
          )
          appFolders))
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
      }) (range 1 workspacesCount)));
  };
}
