{ inputs, ... }:

{
  flake.modules.homeManager.nvim =
    { config, ... }:
    {
      imports = [ inputs.nixvim.homeModules.nixvim ];

      programs.nixvim = {
        enable = true;
        defaultEditor = true;
        nixpkgs.useGlobalPackages = true;

        imports = [ ./_config ];

        # the home's clipboard commands (e.g. win32yank on wsl) instead of nvim's autodetection
        globals.clipboard = {
          name = "nix-clipboard";
          copy = {
            "+" = config.clipboard.copy;
            "*" = config.clipboard.copy;
          };
          paste = {
            "+" = config.clipboard.paste;
            "*" = config.clipboard.paste;
          };
          cache_enabled = 0;
        };
      };

      home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };

      stylix.targets.nixvim.enable = false;
    };

  # `nix run .#nvim` anywhere; uses nvim's own clipboard detection
  perSystem =
    { pkgs, system, ... }:
    {
      packages.nvim = inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
        inherit pkgs;
        module = ./_config;
      };
    };
}
