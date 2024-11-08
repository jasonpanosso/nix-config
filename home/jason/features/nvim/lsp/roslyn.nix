{ pkgs, ... }:

let
  roslyn-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "roslyn-nvim";
    version = "2024-10-21";
    src = pkgs.fetchgit
      {
        url = "https://github.com/seblj/roslyn.nvim";
        rev = "0cb7527d951237bd23e30c461e8f7e2d615830fd";
        hash = "sha256-t3gShqWD54bUPOAsqF+VeUenbuFtFxk3fpz8mVRASEw=";
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
            on_attach = function() end,
            exe = 'Microsoft.CodeAnalysis.LanguageServer',
            capabilities = capabilities,
        })
      '';
  };
}
