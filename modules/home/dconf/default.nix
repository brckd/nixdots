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
