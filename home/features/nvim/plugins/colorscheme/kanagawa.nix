{
  programs.nixvim.colorschemes.kanagawa = {
    enable = true;
    compile = true;
    keywordStyle = { bold = false; italic = false; };
    commentStyle = { bold = false; italic = false; };
    statementStyle = { bold = false; italic = false; };
    functionStyle = { bold = false; italic = false; };
    overrides =
      ''
        local theme = colors.theme
        return {
          Function = { bold = false, italic = false },
          Constant = { bold = false, italic = false },

          NormalFloat = { bg = 'none' },
          FloatBorder = { bg = 'none' },
          FloatTitle = { bg = 'none' },

          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

          TelescopeTitle = { fg = theme.ui.special, bold = true },

          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = 0 },
          PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2, blend = 0 },
          PmenuSbar = { bg = theme.ui.bg_m1, blend = 0 },
          PmenuThumb = { bg = theme.ui.bg_p2, blend = 0 },
        }
      '';
  };
}
