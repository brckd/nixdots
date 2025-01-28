{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.zsh;
in {
  config = mkIf cfg.enable {
    programs.zsh = {
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.ignoreSpace = true;
      zsh-abbr = {
        enable = true;
        abbreviations = {
          sh = "$SHELL";
          pg = "$PAGER";
          ed = "$EDITOR";
          g = "git";
          gcl = "git clone";
          gf = "git fetch";
          gpl = "git pull";
          gp = "git push";
          ga = "git add .";
          gc = "git commit";
          gcm = "git commit --message";
          gca = "git commit --amend";
          gcan = "git commit --amend --no-edit";
          gco = "git checkout";
          gd = "git diff";
          gdn = "git diff --name-only";
          gdh = "git diff HEAD~ HEAD";
          gdc = "git diff --cached";
          gdcn = "git diff --cached --name-only";
          gl = "git log";
          glo = "git log --oneline";
          gr = "git rebase";
          gri = "git rebase --interactive --committer-date-is-author-date";
          n = "nix";
          ns = "nix shell";
          nr = "nix run";
          nrp = "nix repl";
          nf = "nix flake";
          nfm = "nix flake metadata";
          nfu = "nix flake update";
          nhh = "nh home switch .";
          nho = "nh os switch .";
          mkp = "mkdir --parent";
        };
      };
    };
  };
}
