{self, ...}: let
  inherit (builtins) attrValues removeAttrs;
in {
  imports = attrValues (removeAttrs self.nixOnDroidModules ["all"]);
}
