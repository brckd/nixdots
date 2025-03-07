{self, ...}: let
  inherit (builtins) attrValues removeAttrs;
in {
  imports = attrValues (removeAttrs self.homeModules ["all"]);
}
