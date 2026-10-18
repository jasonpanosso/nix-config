{ pkgs }:

let
  inherit (pkgs) lib;

  pwd = builtins.getEnv "PWD"; # "" when pure
  gomod = "${pwd}/go.mod";

  # "go 1.24.3" -> "24"
  minor =
    if pwd != "" && builtins.pathExists gomod then
      let
        lines = lib.splitString "\n" (builtins.readFile (/. + gomod));
        found = lib.filter (m: m != null) (map (builtins.match "go 1\\.([0-9]+).*") lines);
      in
      if found == [ ] then null else builtins.head (builtins.head found)
    else null;

  # Use go_1_<minor> when nixpkgs still has it, otherwise the newest Go
  pinned = if minor == null then null else builtins.tryEval pkgs."go_1_${minor}";
  go = if pinned != null && pinned.success then pinned.value else pkgs.go;
in
pkgs.mkShell {
  name = "go";
  packages = [ go pkgs.gopls pkgs.gotools pkgs.go-tools pkgs.delve ];
  GOTOOLCHAIN = "local";
}
