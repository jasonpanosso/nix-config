{ inputs }:

# let
#   addPatches = pkg: patches: pkg.overrideAttrs (oldAttrs: {
#     patches = (oldAttrs.patches or [ ]) ++ patches;
#   });
# in
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
    vimPlugins = prev.vimPlugins // {
      actions-preview = prev.vimUtils.buildVimPlugin {
        pname = "actions-preview";
        version = "2024-11-26";
        src = prev.fetchgit {
          url = "https://github.com/aznhe21/actions-preview.nvim";
          rev = "9f52a01c374318e91337697ebed51c6fae57f8a4";
          hash = "sha256-lYjsv8y1fMuTGpBF/iG7cm/a7tLdh748vJhVsSp/Iz8=";
          fetchSubmodules = true;
        };
        meta.homepage = "https://github.com/aznhe21/actions-preview.nvim";
      };

      pretty_hover = prev.vimUtils.buildVimPlugin {
        pname = "pretty_hover";
        version = "2024-11-26";
        src = prev.fetchgit {
          url = "https://github.com/Fildo7525/pretty_hover";
          rev = "dabf4dcfd6b074d5edefce381f1bc04c361527ca";
          hash = "sha256-N/AtGg2vL3YGJ4hzm0isYc9CkYAsP7LTlBeAcspF+2I=";
          fetchSubmodules = true;
        };
        meta.homepage = "https://github.com/Fildo7525/pretty_hover";
      };

      garbage-day = prev.vimUtils.buildVimPlugin {
        pname = "garbage-day.nvim";
        version = "2024-11-13";
        src = prev.fetchgit {
          url = "https://github.com/Zeioth/garbage-day.nvim";
          rev = "750ef08ae6031ee3683014c5349144340c08ead6";
          hash = "sha256-XBt1EMbd3QTwfxHZcTVO1Rd0rocATrv8HMEBPxbs60w=";
          fetchSubmodules = true;
        };
        meta.homepage = "https://github.com/Zeioth/garbage-day.nvim";
      };
    };
  };
}
