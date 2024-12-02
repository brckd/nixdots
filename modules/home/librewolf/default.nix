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
              "Startpage" = {
                urls = singleton {template = "https://www.startpage.com/sp/search?query={searchTerms}";};
                iconsUpdateURL = "https://www.startpage.com/sp/cdn/favicons/favicon-96x96.png";
                definedAliases = ["@sp" "@startpage"];
              };
              "Noogle" = {
                urls = singleton {template = "https://noogle.dev/q?term={searchTerms}";};
                iconsUpdateURL = "https://noogle.dev/favicon.png";
                definedAliases = ["@ng" "@noogle"];
              };
              "Nix Documentation" = {
                urls = singleton {template = "https://nix.dev/search.html?q={searchTerms}";};
                iconsUpdateURL = "https://nix.dev/_static/favicon.png";
                definedAliases = ["@nxd" "@nixdocs"];
              };
              "Nix Manual" = {
                urls = singleton {template = "https://nix.dev/manual/nix/latest/?search={searchTerms}";};
                iconUpdateURL = "https://nix.dev/manual/nix/latest/favicon.svg";
                definedAliases = ["@nxm" "@nixmanual"];
              };
              "Nix Packages" = {
                urls = singleton {template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";};
                iconUpdateURL = "https://search.nixos.org/favicon.png";
                definedAliases = ["@nxp" "@nixpackages"];
              };
              "Searchix" = {
                urls = singleton {template = "https://searchix.alanpearce.eu/all/search?query={searchTerms}";};
                definedAliases = ["@sx" "@searchix"];
              };
              "NixOS Options" = {
                urls = singleton {template = "https://search.nixos.org/options?query={searchTerms}";};
                iconUpdateURL = "https://search.nixos.org/favicon.png";
                definedAliases = ["@noo" "@nixosops"];
              };
              "NixOS Wiki" = {
                urls = singleton {template = "https://nixos.wiki/index.php?search={searchTerms}";};
                iconUpdateURL = "https://nixos.wiki/favicon.png";
                definedAliases = ["@now" "@nixoswiki"];
              };
              "Home Manager Options" = {
                urls = singleton {template = "https://home-manager-options.extranix.com/?query={searchTerms}";};
                iconUpdateURL = "https://home-manager-options.extranix.com/images/favicon.png";
                definedAliases = ["@hmo" "@homemmanageropts"];
              };
              "Flake Parts Docs" = {
                urls = singleton {template = "https://flake.parts/?search={searchTerms}";};
                iconUpdateURL = "https://flake.parts/favicon.svg";
                definedAliases = ["@fpd" "flakepartsdocs"];
              };
              "NixVim Docs" = {
                urls = singleton {template = "https://nix-community.github.io/nixvim/?search={searchTerms}";};
                iconUpdateURL = "https://nix-community.github.io/nixvim/favicon.svg";
                definedAliases = ["@nvd" "@nixvimdocs"];
              };
              "Fancade Wiki" = {
                urls = singleton {template = "https://www.fancade.com/wiki/gollum/search?q={searchTerms}";};
                iconUpdateURL = "https://www.fancade.com/favicon.ico";
                definedAliases = ["@fcw" "@fancadewiki"];
              };
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
          "addy.io"
          "simplelogin.com"
          "huggingface.co"
          "vercel.com"
          "netlify.com"
          "neon.tech"
          "penpot.app"
          "figma.com"
          "fancade.com"
          "fancade.club"
          "discord.com"
          "spotify.com"
          "epicgams.com"
          "steam.com"
          "adventofcode.com"
          "fancade.com"
          "hypehype.com"
        ];
      };
    };
  };
}
