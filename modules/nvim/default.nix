{ inputs, ... }:

{
  flake.modules.homeManager.nvim = {
    imports = [
      inputs.nixvim.homeModules.nixvim
      ./_config
    ];
  };
}
