{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.librewolf;
in {
  config = mkIf cfg.enable {
    programs.librewolf = {
      profiles = {
        default = {
          name = "Default";
          extensions = with config.nur.repos.rycee.firefox-addons; [
            ublock-origin
            bitwarden
            darkreader
            libredirect
          ];
          search = {
            default = "DuckDuckGo";
            force = true;
            engines = {
              "Google".metaData.hidden = true;
              "Bing".metaData.hidden = true;
            };
          };
          bookmarks = [
            {
              name = "GitHub";
              tags = ["git"];
              keyword = "github";
              url = "https://github.com/";
            }
          ];
          settings = {
            "webgl.disabled" = false;
            "extensions.autoDisableScopes" = 0; # Enable extensions
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # Enable userchrome
            "browser.aboutConfig.showWarning" = false;

            # Blank homepage
            "browser.newtabpage.enable" = false;
            "browser.startup.homepage" = "about:newtab";
            "browser.toolbars.bookmarks.visibility" = "never";

            # Toolbar customization
            "browser.uiCustomization.state" = builtins.readFile ./toolbar.json;
          };

          userChrome = builtins.readFile ./userChrome.css;
        };
      };
      policies = {
        Cookies.Allow = map (d: "https://${d}") [
          "github.com"
          "codeberg.org"
          "gitlab.com"
          "proton.me"
          "purelymail.com"
          "discord.com"
          "spotify.com"
        ];
      };
    };
  };
}
