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
              bitwarden
              darkreader
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
              "Nixpkgs Issues" = {
                urls = singleton {template = "https://github.com/nixos/nixpkgs/issues?q={searchTerms}";};
                icon = "https://github.githubassets.com/favicons/favicon.png";
                definedAliases = ["@nxi" "@nixpkgsissues"];
              };
              "Searchix" = {
                urls = singleton {template = "https://searchix.ovh/?query={searchTerms}";};
                definedAliases = ["@sx" "@searchix"];
              };
              "NixOS Options" = {
                urls = singleton {template = "https://search.nixos.org/options?query={searchTerms}";};
                icon = "https://search.nixos.org/favicon.png";
                definedAliases = ["@noo" "@nixosops"];
              };
              "NixOS Wiki" = {
                urls = singleton {template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";};
                icon = "https://wiki.nixos.org/favicon.ico";
                definedAliases = ["@now" "@nixoswiki"];
              };
              "Home Manager Options" = {
                urls = singleton {template = "https://home-manager-options.extranix.com/?query={searchTerms}";};
                icon = "https://home-manager-options.extranix.com/images/favicon.png";
                definedAliases = ["@hmo" "@homemmanageropts"];
              };
              "Home Manager Issues" = {
                urls = singleton {template = "https://github.com/nix-community/home-manager/issues?q={searchTerms}";};
                icon = "https://github.githubassets.com/favicons/favicon.png";
                definedAliases = ["@hmi" "@homemanagerissues"];
              };
              "Stylix Documentations" = {
                urls = singleton {template = "https://nix-community.github.io/stylix/?search={searchTerms}";};
                icon = "https://nix-community.github.io/stylix/favicon-de23e50b.svg";
                definedAliases = ["@std" "@stylixdocs"];
              };
              "Stylix Issues" = {
                urls = singleton {template = "https://github.com/nix-community/stylix/issues?q={searchTerms}";};
                icon = "https://github.githubassets.com/favicons/favicon.png";
                definedAliases = ["@sti" "@stylixissues"];
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
              "GitHub" = {
                urls = singleton {template = "https://github.com/search?q={searchTerms}";};
                icon = "https://github.githubassets.com/favicons/favicon.png";
                definedAliases = ["@gh" "@github"];
              };
              "GitLab" = {
                urls = singleton {template = "https://gitlab.com/search?search={searchTerms}";};
                icon = "https://gitlab.com/assets/favicon-72a2cad5025aa931d6ea56c3201d1f18e68a8cd39788c7c80d5b2b82aa5143ef.png";
                definedAliases = ["@gl" "@gitlab"];
              };
              "Codeberg" = {
                urls = singleton {template = "https://codeberg.org/explore/repos?q={searchTerms}";};
                icon = "https://codeberg.org/assets/img/favicon.svg";
                definedAliases = ["@cb" "@codeberg"];
              };
              "Reddit" = {
                urls = singleton {template = "https://www.reddit.com/search/?q={searchTerms}";};
                icon = "https://www.redditstatic.com/shreddit/assets/favicon/64x64.png";
                definedAliases = ["@rd" "@reddt"];
              };
            };
          };
          bookmarks = {
            force = true;
            settings = [
              {
                name = "Bricked";
                tags = ["bricked"];
                url = "https://bricked.dev";
              }
              {
                name = "Git";
                tags = ["bricked" "git"];
                url = "https://git.bricked.dev";
              }
              {
                name = "Dashboard";
                tags = ["bricked"];
                url = "https://dash.bricked.dev";
              }
              {
                name = "Status";
                tags = ["bricked"];
                url = "https://status.bricked.dev";
              }
              {
                name = "GitHub";
                tags = ["git"];
                url = "https://github.com";
              }
              {
                name = "Codeberg";
                tags = ["git"];
                url = "https://codeberg.org";
              }
              {
                name = "GitLab";
                tags = ["git"];
                url = "https://gitlab.com";
              }
              {
                name = "GNOME GitLab";
                tags = ["gnome" "git"];
                url = "https://gitlab.gnome.org";
              }
              {
                name = "Nixpkgs Repository";
                tags = ["nixpkgs" "git"];
                url = "https://github.com/nixos/nixpkgs";
              }
              {
                name = "Home Manager Repository";
                tags = ["homemanager" "git"];
                url = "https://github.com/nix-community/home-manager";
              }
              {
                name = "Stylix Repository";
                tags = ["stylix" "git"];
                url = "https://github.com/nix-community/stylix";
              }
              {
                name = "Deepl";
                tags = ["translator"];
                url = "https://deepl.com";
              }
              {
                name = "Fancade Web";
                tags = ["fancade" "gaming"];
                url = "https://play.fancade.com";
              }
              {
                name = "HypeHype App";
                tags = ["hypehype" "gaming"];
                url = "https://app.hypehype.com";
              }
              {
                name = "HypeHype Learning Hub";
                tags = ["hypehype" "gaming"];
                url = "https://learn.hypehype.com";
              }
              {
                name = "Proton Mail";
                tags = ["proton" "mail"];
                url = "https://mail.proton.me";
              }
              {
                name = "AnonAddy";
                tags = ["mail"];
                url = "https://addy.io";
              }
              {
                name = "SimpleLogin";
                tags = ["mail"];
                url = "https://simplelogin.com";
              }
              {
                name = "Vercel";
                tags = ["hosting"];
                url = "https://vercel.com";
              }
              {
                name = "Netlify";
                tags = ["hosting"];
                url = "https://netlify.com";
              }
              {
                name = "Tailscale";
                tags = ["hosting"];
                url = "https://tailscale.com";
              }
              {
                name = "Monkeytype";
                tags = ["typing"];
                url = "https://monkeytype.com";
              }
            ];
          };
          settings = {
            "extensions.autoDisableScopes" = 0; # Enable extensions
            "browser.aboutConfig.showWarning" = false;
            "browser.tabs.closeWindowWithLastTab" = false;

            # Privacy
            "privacy.sanitize.sanitizeOnShutdown" = false; # Keep history
            "privacy.resistFingerprinting.letterboxing" = true;

            # Blank homepage
            "browser.newtabpage.enable" = false;
            "browser.startup.homepage" = "about:newtab";
            "browser.startup.page" = 3;
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
          "bricked.dev"
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
          "monkeytype.com"
          "typst.app"
          "keybr.com"
          "cachix.org"
          "tailscale.com"
        ];
      };
    };
  };
}
