{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.librewolf;
  firefox-addons = inputs.firefox-addons.packages.${pkgs.system};
in {
  config = mkIf cfg.enable {
    programs.librewolf = {
      profiles = {
        default = {
          name = "Default";
          extensions = {
            packages = with firefox-addons; [
              ublock-origin
              privacy-badger
              bitwarden
              libredirect
              darkreader
              webhint
            ];
            force = true;
          };
          search = {
            default = "ddg";
            force = true;
            engines = {
              "google".metaData.hidden = true;
              "bing".metaData.hidden = true;
              "Startpage" = {
                urls = singleton {template = "https://www.startpage.com/sp/search?query={searchTerms}";};
                icon = "https://www.startpage.com/sp/cdn/favicons/favicon-96x96.png";
                definedAliases = ["@sp" "@startpage"];
              };
              "Noogle" = {
                urls = singleton {template = "https://noogle.dev/q?term={searchTerms}";};
                icon = "https://noogle.dev/favicon.png";
                definedAliases = ["@ng" "@noogle"];
              };
              "Nix Documentation" = {
                urls = singleton {template = "https://nix.dev/search.html?q={searchTerms}";};
                icon = "https://nix.dev/_static/favicon.png";
                definedAliases = ["@nxd" "@nixdocs"];
              };
              "Nix Manual" = {
                urls = singleton {template = "https://nix.dev/manual/nix/latest/?search={searchTerms}";};
                icon = "https://nix.dev/manual/nix/latest/favicon.svg";
                definedAliases = ["@nxm" "@nixmanual"];
              };
              "Nix Packages" = {
                urls = singleton {template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";};
                icon = "https://search.nixos.org/favicon.png";
                definedAliases = ["@nxp" "@nixpackages"];
              };
              "Searchix" = {
                urls = singleton {template = "https://searchix.alanpearce.eu/all/search?query={searchTerms}";};
                definedAliases = ["@sx" "@searchix"];
              };
              "NixOS Options" = {
                urls = singleton {template = "https://search.nixos.org/options?query={searchTerms}";};
                icon = "https://search.nixos.org/favicon.png";
                definedAliases = ["@noo" "@nixosops"];
              };
              "NixOS Wiki" = {
                urls = singleton {template = "https://nixos.wiki/index.php?search={searchTerms}";};
                icon = "https://nixos.wiki/favicon.png";
                definedAliases = ["@now" "@nixoswiki"];
              };
              "Home Manager Options" = {
                urls = singleton {template = "https://home-manager-options.extranix.com/?query={searchTerms}";};
                icon = "https://home-manager-options.extranix.com/images/favicon.png";
                definedAliases = ["@hmo" "@homemmanageropts"];
              };
              "Flake Parts Docs" = {
                urls = singleton {template = "https://flake.parts/?search={searchTerms}";};
                icon = "https://flake.parts/favicon.svg";
                definedAliases = ["@fpd" "flakepartsdocs"];
              };
              "NixVim Docs" = {
                urls = singleton {template = "https://nix-community.github.io/nixvim/?search={searchTerms}";};
                icon = "https://nix-community.github.io/nixvim/favicon.svg";
                definedAliases = ["@nvd" "@nixvimdocs"];
              };
              "Fancade Wiki" = {
                urls = singleton {template = "https://www.fancade.com/wiki/gollum/search?q={searchTerms}";};
                icon = "https://www.fancade.com/favicon.ico";
                definedAliases = ["@fcw" "@fancadewiki"];
              };
              "Deepl" = {
                urls = singleton {template = "https://www.deepl.com/en/translator#en/en/{searchTerms}";};
                icon = "https://static.deepl.com/img/logo/deepl-logo-blue.svg";
                definedAliases = ["@dpl" "@deepl"];
              };
            };
          };
          bookmarks = {
            force = true;
            settings = [
              {
                name = "GitHub";
                tags = ["git"];
                keyword = "github";
                url = "https://github.com/";
              }
            ];
          };
          settings = {
            "extensions.autoDisableScopes" = 0; # Enable extensions
            "browser.aboutConfig.showWarning" = false;
            "webgl.disabled" = false;
            "browser.tabs.closeWindowWithLastTab" = false;
            "browser.startup.page" = 3;

            # Blank homepage
            "browser.newtabpage.enable" = false;
            "browser.startup.homepage" = "about:newtab";
            "browser.toolbars.bookmarks.visibility" = "never";

            # UI customization
            "browser.uiCustomization.state" = builtins.readFile ./toolbar.json;
            "layers.acceleration.force-enabled" = true; # Rounded window corners on Wayland

            # Gnome Theme
            "gnomeTheme.bookmarksToolbarUnderTabs" = true;
            "gnomeTheme.dragWindowHeaderbarButtons" = true;
            "gnomeTheme.symbolicTabIcons" = true;
          };
        };
      };
      policies = {
        Cookies.Allow = map (d: "https://${d}") [
          "github.com"
          "codeberg.org"
          "gitlab.com"
          "gitlab.gnome.org"
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
          "epicgames.com"
          "steamcommunity.com"
          "steampowered.com"
          "adventofcode.com"
          "fancade.com"
          "hypehype.com"
          "tilde.zone"
          "feddit.org"
          "nope.chat"
          "flaci.com"
          "lernraum-berlin.de"
          "monkeytype.com"
          "typst.app"
          "keybr.com"
          "cachix.org"
        ];
      };
    };
  };
}
