{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.firefox;
in {
  config = mkIf cfg.enable {
    programs.firefox = {
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
            "extensions.autoDisableScopes" = 0;
            "browser.toolbars.bookmarks.visibility" = "never";
            "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
          };
        };
      };
    };
  };
}
