{ pkgs, ... }:

{
  programs.nixvim = {
    extraPackages = [
      pkgs.terraform-ls
    ];

    plugins.lsp.servers.terraformls.enable = true;
    extraConfigLua = /* lua */ ''
      vim.filetype.add({
        extension = {
          tf = "terraform",
        },
      })
    '';
  };
}
