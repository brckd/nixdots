{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.wayland.windowManager.hyprland;
  mainMod = "SUPER";
  binds = {
    C = "kitty";
    F = "librewolf";
    D = "vesktop";
  };
  # Like WASD, but reachable from 10 finger typing position
  # May be changed to vi keys
  directions = {
    J = "l";
    L = "r";
    I = "u";
    K = "d";
  };
  resizeparams = {
    J = "-20 0";
    L = "20 0";
    I = "0 -20";
    K = "0 20";
  };
in {
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        monitor = ",preferred,auto,auto";

        general = {
          layout = "dwindle";
          gaps_in = 5;
          gaps_out = 10;
          border_size = 0;
        };

        decoration = {
          rounding = 15;
          shadow_range = 10;
          shadow_render_power = 4;
          dim_inactive = true;
          dim_strength = 0.2;
        };

        animations = {
          enabled = true;
          bezier = "easeInOut, 0.5, 0, 0, 1";
          animation = [
            "windows, 1, 3, easeInOut"
            "windowsOut, 1, 3, easeInOut, popin 80%"
            "workspaces, 1, 3, easeInOut"
            "border, 1, 3, easeInOut"
            "borderangle, 1, 3, easeInOut"
            "fade, 1, 3, easeInOut"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master.new_status = "master";

        bind =
          [
            "${mainMod} SHIFT, Q, exit" # Q as in quit
            "${mainMod}, Q, killactive" # Q as in quit
            "${mainMod}, O, togglefloating" # O as in flOat
            "${mainMod}, P, pin" # P as in pin
            "${mainMod}, U, togglesplit" # U as in tUrn
            "${mainMod}, F, fullscreen" # F as in fullscreen

            ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ",XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 0.1-"
            ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 0.1+"
          ]
          # Move focus with mainMod + directional keys
          ++ mapAttrsToList (key: dir: "${mainMod}, ${key}, movefocus, ${dir}") directions
          # Move windows with mainMod + SHIFT + directional keys
          ++ mapAttrsToList (key: dir: "${mainMod} SHIFT, ${key}, movewindow, ${dir}") directions
          # App bindings
          ++ mapAttrsToList (key: app: "${mainMod} SHIFT, ${key}, exec, ${app}") binds
          # Switch workspaces with mainMod + [0-9]
          ++ map (ws: "${mainMod}, ${toString (mod ws 10)}, workspace, ${toString ws}") (range 1 10)
          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          ++ map (ws: "${mainMod} SHIFT, ${toString (mod ws 10)}, movetoworkspace, ${toString ws}") (range 1 10);

        # Resize windows with mainMod + ALT + directional keys
        binde =
          mapAttrsToList (key: resize: "${mainMod} Control, ${key}, resizeactive, ${resize}") resizeparams;

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = [
          "${mainMod}, mouse:272, movewindow"
          "${mainMod}, mouse:273, resizewindow"
        ];
      };
    };
  };
}
