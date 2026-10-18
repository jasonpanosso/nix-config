{
  programs.nixvim.plugins.lsp.servers.rust_analyzer = {
    enable = true;
    packageFallback = true;
    installRustc = false;
    installCargo = false;
    settings = {
      cargo = { targetDir = true; };
      check = {
        command = "clippy";
        allTargets = true;
      };
      checkOnSave = true;
    };
  };
}
