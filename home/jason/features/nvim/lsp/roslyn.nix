{ pkgs, ... }:

let
  roslyn-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "roslyn-nvim";
    version = "2025-04-08";
    src = pkgs.fetchgit
      {
        url = "https://github.com/seblj/roslyn.nvim";
        rev = "09541daaefaa61a422a4ae979dcc8d1b5cd37e42";
        hash = "sha256-VQYHRD3++0+OU7Eyrfif+k9T+F1vvPv0cSJ9XZBoUtE=";
      };
  };
in
{

  programs.nixvim = {
    extraPackages = with pkgs; [
      (with dotnetCorePackages; combinePackages [
        sdk_6_0
        sdk_7_0
        sdk_8_0
        sdk_9_0
      ])
      roslyn-ls
    ];

    extraPlugins = [ roslyn-nvim ];

    extraConfigLua =
      #lua
      ''
        local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
        capabilities = vim.tbl_deep_extend('force', capabilities, {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = false,
            },
          },
        })

        require("roslyn").setup({
            exe = 'Microsoft.CodeAnalysis.LanguageServer',
            capabilities = capabilities,
        })
      '';
  };
}
