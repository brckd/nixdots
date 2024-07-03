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
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master.new_status = "master";

        bind =
          [
            "${mainMod} SHIFT, Q, exit, "
            "${mainMod}, Q, killactive, "
            "${mainMod}, V, togglefloating, "
            "${mainMod}, P, pseudo," # dwindle
            "${mainMod}, J, togglesplit," # dwindle

            # Move focus with mainMod + arrow keys
            "${mainMod}, left, movefocus, l"
            "${mainMod}, right, movefocus, r"
            "${mainMod}, up, movefocus, u"
            "${mainMod}, down, movefocus, d"

            # Example special workspace (scratchpad)
            "${mainMod}, S, togglespecialworkspace, magic"
            "${mainMod} SHIFT, S, movetoworkspace, special:magic"

            # Scroll through existing workspaces with mainMod + scroll
            "${mainMod}, mouse_down, workspace, e+1"
            "${mainMod}, mouse_up, workspace, e-1"
          ]
          ++ mapAttrsToList (key: app: "${mainMod} SHIFT, ${key}, exec, ${app}") binds
          # Switch workspaces with mainMod + [0-9]
          ++ map (ws: "${mainMod}, ${toString (mod ws 10)}, workspace, ${toString ws}") (range 1 10)
          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          ++ map (ws: "${mainMod} SHIFT, ${toString (mod ws 10)}, movetoworkspace, ${toString ws}") (range 1 10);

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = [
          "${mainMod}, mouse:272, movewindow"
          "${mainMod}, mouse:273, resizewindow"
        ];
      };
    };
  };
}
