{ inputs }:

# let
#   addPatches = pkg: patches: pkg.overrideAttrs (oldAttrs: {
#     patches = (oldAttrs.patches or [ ]) ++ patches;
#   });
# in
{
  # Third party overlays
  nh = inputs.nh.overlays.default;

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

      harpoon2 = prev.vimUtils.buildVimPlugin {
        pname = "harpoon2";
        version = "2025-02-13";
        src = prev.fetchgit
          {
            url = "https://github.com/ThePrimeagen/harpoon";
            rev = "ed1f853847ffd04b2b61c314865665e1dadf22c7";
            hash = "sha256-L7FvOV6KvD58BnY3no5IudiKTdgkGqhpS85RoSxtl7U=";
          };

        # No idea why the require checks fail
        doCheck = false;

        meta.homepage = "https://github.com/ThePrimeagen/harpoon/tree/harpoon2";
      };

      harpoon-tabline =
        prev.vimUtils.buildVimPlugin {
          pname = "harpoon-tabline";
          version = "2024-02-27";
          src = prev.fetchgit
            {
              url = "https://github.com/jasonpanosso/harpoon-tabline.nvim";
              rev = "37a15cfd9c4dac32e5be37b41491eb81082f6afe";
              hash = "sha256-ypJdBXLZccWilUo6wLJc/xYtXxF2suyxFDPWqLVrD0s=";
            };

          # dep on harpoon, idc to learn how to configure it
          doCheck = false;

          meta.homepage = "https://github.com/jasonpanosso/harpoon-tabline.nvim/";
        };

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

      vim-rzip = prev.vimUtils.buildVimPlugin {
        pname = "vim-rzip";
        version = "2024-11-22";
        src = prev.fetchgit {
          url = "https://github.com/lbrayner/vim-rzip";
          rev = "f65400fed27b27c7cff7ef8d428c4e5ff749bf28";
          hash = "sha256-xy7rNqDVqlGapKClrP5BhfOORlMzHOQ8oIc8FdZT/AE=";
          fetchSubmodules = true;
        };
        meta.homepage = "https://github.com/lbrayner/vim-rzip";
      };

      breadcrumbs-nvim = prev.vimUtils.buildVimPlugin {
        pname = "breadcrumbs.nvim";
        version = "2024-12-09";
        src = prev.fetchgit {
          url = "https://github.com/LunarVim/breadcrumbs.nvim";
          rev = "9f764278784ce2f10dbe2f555ba14be2451d36a0";
          hash = "sha256-DXR5Qvlxh9MiCngH9OlzsUp6LCg8P/RNwurU9vky89w=";
          fetchSubmodules = true;
        };
        meta.homepage = "https://github.com/LunarVim/breadcrumbs.nvim";
      };
    };
  };
}
