{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.zsh;
  dotDir = ".config/zsh";
in {
  config = mkIf cfg.enable {
    programs.zsh = {
      inherit dotDir;
      history.path = "${dotDir}/.zsh_history";
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
          gpf = "git push --force";
          ga = "git add";
          gaa = "git add .";
          gr = "git reset";
          gc = "git commit";
          gcm = "git commit --message";
          gca = "git commit --amend";
          gcan = "git commit --amend --no-edit";
          gco = "git checkout";
          gcob = "git checkout -b";
          gd = "git diff";
          gdn = "git diff --name-only";
          gdh = "git diff HEAD~ HEAD";
          gdc = "git diff --cached";
          gdcn = "git diff --cached --name-only";
          gl = "git log";
          glo = "git log --oneline";
          grb = "git rebase";
          gri = "git rebase --interactive --committer-date-is-author-date";
          gs = "git stash";
          gsa = "git stash apply";
          gcp = "git cherry-pick";
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
          cpr = "cp --recursive";
        };
      };
    };
  };
}
