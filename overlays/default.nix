{ inputs, ... }: {
  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = final: prev: {
    lib = prev.lib // { my = import ./lib { inherit (final) lib; }; };
    neovim = inputs.neovim-nightly-overlay.overlay;
  };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
