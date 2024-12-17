{
  config,
  lib,
  firefox-gnome-theme,
  ...
}: {
  config = lib.mkMerge (map (target:
    lib.mkIf (config.stylix.enable && config.stylix.targets.${target}.enable && config.programs.${target}.enable) (
      lib.mkMerge (map (profile: {
        home.file."${config.programs.${target}.configPath}/${profile}/chrome/firefox-gnome-theme".source = firefox-gnome-theme;
        programs.${target}.profiles.${profile} = {
          userChrome = builtins.readFile (config.lib.stylix.colors {
            template = ./userChrome.mustache;
            extension = "css";
          });

          userContent = ''
            @import "firefox-gnome-theme/userContent.css";
          '';
        };
      }) ["default"])
    )) ["firefox" "librewolf"]);
}
