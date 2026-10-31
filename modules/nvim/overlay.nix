{
  # vim plugins nixvim uses that nixpkgs doesn't package
  flake.overlays.vim-plugins = final: prev: {
    vimPlugins = prev.vimPlugins // {
      harpoon-tabline = prev.vimUtils.buildVimPlugin {
        pname = "harpoon-tabline";
        version = "2024-04-27";
        src = prev.fetchgit {
          url = "https://github.com/Run1e/harpoon-tabline.nvim";
          rev = "f3092df9ce0f03d06ad7124128d6dd1c49bf717b";
          hash = "sha256-DrFsPNkBSUBZfnFNeVM1qolY7OYmagu85bpbwmlYsIo=";
        };

        # require check needs harpoon on the path
        doCheck = false;

        meta.homepage = "https://github.com/jasonpanosso/harpoon-tabline.nvim/";
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
    };
  };
}
