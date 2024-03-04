{ outputs, inputs }:
let
  addPatches = pkg: patches: pkg.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ patches;
  });
in
{
  # Third party overlays
  nh = inputs.nh.overlays.default;
  neovim = inputs.neovim-nightly-overlay.overlay;

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
    # Modify packages here, i.e:
    # vimPlugins = prev.vimPlugins // {
    #   vim-numbertoggle = addPatches prev.vimPlugins.vim-numbertoggle [ ./vim-numbertoggle-command-mode.patch ];
    # };
  };

}
