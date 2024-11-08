{ config, ... }:

let
  cacheDir = config.home.homeDirectory + "/.cache/nvim/";
in
{
  programs.nixvim = {
    luaLoader.enable = true;

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      termguicolors = true;
      hidden = true;
      magic = true;
      virtualedit = "block";
      clipboard = "unnamedplus";
      wildignorecase = true;
      swapfile = false;
      directory = cacheDir + "swap/";
      undodir = cacheDir + "undo/";
      backupdir = cacheDir + "backup/";
      viewdir = cacheDir + "view/";
      spellfile = cacheDir + "spell/en.uft-8.add";
      history = 2000;
      timeout = true;
      ttimeout = true;
      timeoutlen = 500;
      ttimeoutlen = 10;
      updatetime = 100;
      redrawtime = 1500;

      ignorecase = true;
      smartcase = true;
      infercase = true;

      grepformat = "%f:%l:%c:%m,%f:%l:%m";
      grepprg = "rg --vimgrep --no-heading --smart-case";

      completeopt = "menu,menuone,noselect";
      showmode = false;
      shortmess = "aoOTIcF";
      scrolloff = 6;
      sidescrolloff = 5;
      ruler = false;
      winwidth = 30;
      pumheight = 15;
      showcmd = false;

      cmdheight = 0;
      laststatus = 3;
      list = true;
      listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←";
      pumblend = 10;
      winblend = 0;
      undofile = true;

      smarttab = true;
      expandtab = true;
      autoindent = true;
      smartindent = true;
      tabstop = 2;

      linebreak = true;
      whichwrap = "h,l,<,>,[,],~";
      breakindentopt = "shift:2,min:20";
      showbreak = "↳ ";

      foldlevelstart = 999;

      signcolumn = "yes";
      spelloptions = "camel";

      textwidth = 0;
      colorcolumn = "80";

      conceallevel = 0;
      mouse = "a";
      cursorline = true;
      showmatch = false;

      showtabline = 2;
    };

    globals = {
      loaded_gzip = 1;
      loaded_tar = 1;
      loaded_tarPlugin = 1;
      loaded_zip = 1;
      loaded_zipPlugin = 1;
      loaded_getscript = 1;
      loaded_getscriptPlugin = 1;
      loaded_vimball = 1;
      loaded_vimballPlugin = 1;
      loaded_matchit = 1;
      loaded_2html_plugin = 1;
      loaded_logiPat = 1;
      loaded_rrhelper = 1;
      loaded_netrw = 1;
      loaded_netrwPlugin = 1;
      loaded_netrwSettings = 1;
      loaded_netrwFileHandlers = 1;
    };

    extraConfigLua =
      /* lua */
      ''
        -- init cache directories
        local cache_dir = vim.fn.stdpath('cache') .. '/' .. 'nvim' .. '/'

        local data_dir = {
          cache_dir .. 'backup',
          cache_dir .. 'session',
          cache_dir .. 'swap',
          cache_dir .. 'tags',
          cache_dir .. 'undo',
        }

        if vim.fn.isdirectory(cache_dir) == 0 then
          os.execute('mkdir -p ' .. cache_dir)
          for _, v in pairs(data_dir) do
            if vim.fn.isdirectory(v) == 0 then
              os.execute('mkdir -p ' .. v)
            end
          end
        end
      '';
  };
}
