{ pkgs, ... }:

let
  roslyn-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "roslyn-nvim";
    version = "2025-04-08";
    src = pkgs.fetchgit
      {
        url = "https://github.com/seblyng/roslyn.nvim";
        rev = "6baa44274dabf237a0ebec94b4ccad0e3831ed12";
        hash = "sha256-pTpJ6sS32ztVm6qE60uEfSmG5WLWQ1xqLbu/i6dZmyY=";
      };
  };
in
{

  programs.nixvim = {
    extraPackages = with pkgs; [
      dotnet-sdk_9
      roslyn-ls
    ];

    extraPlugins = [ roslyn-nvim ];

    extraConfigLua =
      #lua
      ''
        local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

        require("roslyn").setup({
            filewatching = "roslyn",
            capabilities = capabilities,
        })

        vim.lsp.config("roslyn", {
            cmd = {
                "Microsoft.CodeAnalysis.LanguageServer",
                "--logLevel=Information",
                "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
                "--stdio",
            },
        })
      '';
  };
}
