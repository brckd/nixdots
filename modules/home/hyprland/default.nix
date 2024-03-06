{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.wayland.windowManager.hyprland;
in {
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        monitor = ",preferred,auto,auto";

        env = "XCURSOR_SIZE,24";

        input = {
          follow_mouse = "1";

          touchpad = {
            natural_scroll = "no";
          };

          sensitivity = "0";
        };

        general = {
          gaps_in = "5";
          gaps_out = "10";
          border_size = "0";

          layout = "dwindle";

          allow_tearing = "false";
        };

        decoration = {
          rounding = "10";

          drop_shadow = "true";
          shadow_range = "4";
          shadow_render_power = "3";

          active_opacity = "1";
          inactive_opacity = "1";

          dim_inactive = "true";
          dim_strength = "0.2";
        };

        animations = {
          enabled = "yes";

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
          pseudotile = "yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below";
          preserve_split = "yes # you probably want this";
        };

        master = {
          new_is_master = "true";
        };

        gestures = {
          workspace_swipe = "off";
        };

        misc = {
          force_default_wallpaper = "-1 # Set to 0 to disable the anime mascot wallpapers";
        };

        "$mainMod" = "SUPER";

        bind = [
          "$mainMod SHIFT, C, exec, kitty"
          "$mainMod SHIFT, F, exec, librewolf"
          "$mainMod, Q, killactive, "
          "$mainMod SHIFT, Q, exit, "
          "$mainMod SHIFT, E, exec, dolphin"
          "$mainMod, V, togglefloating, "
          "$mainMod, R, exec, wofi --show drun"
          "$mainMod, P, pseudo, # dwindle"
          "$mainMod, J, togglesplit, # dwindle"

          # Move focus with mainMod + arrow keys
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          # Switch workspaces with mainMod + [0-9]
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

          # Example special workspace (scratchpad)
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"

          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ];

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
      };
    };
  };
}
