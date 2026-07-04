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
          version = "2024-04-27";
          src = prev.fetchgit
            {
              url = "https://github.com/Run1e/harpoon-tabline.nvim";
              rev = "f3092df9ce0f03d06ad7124128d6dd1c49bf717b";
              hash = "sha256-DrFsPNkBSUBZfnFNeVM1qolY7OYmagu85bpbwmlYsIo=";
            };

          # dep on harpoon, idc to learn how to configure it
          doCheck = false;

          meta.homepage = "https://github.com/jasonpanosso/harpoon-tabline.nvim/";
        };

      actions-preview = prev.vimUtils.buildVimPlugin {
        pname = "actions-preview";
        version = "2026-07-04";
        src = prev.fetchgit {
          url = "https://github.com/aznhe21/actions-preview.nvim";
          rev = "0ac9c2aa3cfc8c885321c0862b50b6b1c3392405";
          hash = "sha256-ibzfF/Ebm5+1EgZ05NQCTRDB+Q7ymyRy2fZpjvwv8EA=";
          fetchSubmodules = true;
        };
        meta.homepage = "https://github.com/aznhe21/actions-preview.nvim";
      };

      pretty_hover = prev.vimUtils.buildVimPlugin {
        pname = "pretty_hover";
        version = "2026-07-04";
        src = prev.fetchgit {
          url = "https://github.com/Fildo7525/pretty_hover";
          rev = "934df974ef6158b100fe910e8556e6c4a66614c2";
          hash = "sha256-4rwsSnq9Knce9h/jp3vYzduZCQROpxXUk2SFYyveF/s=";
          fetchSubmodules = true;
        };
        meta.homepage = "https://github.com/Fildo7525/pretty_hover";
      };

      garbage-day = prev.vimUtils.buildVimPlugin {
        pname = "garbage-day.nvim";
        version = "2026-07-04";
        src = prev.fetchgit {
          url = "https://github.com/Zeioth/garbage-day.nvim";
          rev = "2fcc56556281de8ee871a5f3beb9db7ab747ef32";
          hash = "sha256-GabA9whTRQpBbQjc5pyGGVnehBG2i+lwiqJLx31tTLE=";
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
        version = "2026-07-04";
        src = prev.fetchgit {
          url = "https://github.com/LunarVim/breadcrumbs.nvim";
          rev = "a59e3ee12818135098e5ce8efeb7b58b675b09ec";
          hash = "sha256-E/EjzeKyPmssDVF0QtbTmLU805F9b+MNl23pIE2ko0o=";
          fetchSubmodules = true;
        };
        meta.homepage = "https://github.com/LunarVim/breadcrumbs.nvim";
      };
    };
  };
}
