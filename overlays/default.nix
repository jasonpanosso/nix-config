{ inputs }:

let
  addPatches = pkg: patches: pkg.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ patches;
  });
in
{
  # Third party overlays
  nh = inputs.nh.overlays.default;
  neovim = inputs.neovim-nightly-overlay.overlays.default;

  # For every flake input, aliases 'pkgs.inputs.${flake}' to
  # 'inputs.${flake}.packages.${pkgs.system}' or
  # 'inputs.${flake}.legacyPackages.${pkgs.system}'
  flake-inputs = final: _: {
    inputs = builtins.mapAttrs
      (_: flake:
        let
          legacyPackages = ((flake.legacyPackages or { }).${final.system} or { });
          packages = ((flake.packages or { }).${final.system} or { });
        in
        if legacyPackages != { } then legacyPackages else packages
      )
      inputs;
  };

  # Adds custom packages
  additions = final: prev: import ../pkgs { pkgs = final; } // {
    # Add additions here, i.e
    # formats = prev.formats // import ../pkgs/formats { pkgs = final; };
  };

  # Modifies existing packages
  modifications = final: prev: {
    # vimPlugins = prev.vimPlugins // {
    #   oil-nvim = prev.vimUtils.buildVimPlugin {
    #     pname = "oil";
    #     version = "2024-04-26";
    #     src = prev.fetchgit {
    #       url = "https://github.com/stevearc/oil.nvim";
    #       rev = "f3a31eba24587bc038592103d8f7e64648292115";
    #       hash = "sha256-JlA5/qU3U/uAuNt9iVIsIUnULxtxpzoO49ooF8MY3gw=";
    #       fetchSubmodules = true;
    #     };
    #     meta.homepage = "https://github.com/stevearc/oil.nvim";
    #   };
    # };
  };

}
