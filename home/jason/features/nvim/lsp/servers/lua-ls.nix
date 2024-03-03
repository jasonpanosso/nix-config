{
  programs.nixvim.plugins.lsp.servers.lua-ls = {
    enable = true;

    settings = {
      diagnostics.globals = [ "vim" ];
      runtime.version = "LuaJIT";
      workspace.library = [
        # lua
        ''
          (function()
            local lib = {}
            for _, path in ipairs(vim.api.nvim_get_runtime_file('lua', true)) do
              lib[#lib + 1] = path:sub(1, -5)
            end
            return lib
          end)()
        ''
      ];
    };
  };
}
