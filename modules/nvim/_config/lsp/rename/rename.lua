-- rename in a float at the cursor, editing the current name as a normal buffer
local ns = vim.api.nvim_create_namespace('lsp_rename')

-- highlight the symbol's references in this buffer while the float is open
local function highlight_references(bufnr, is_open)
  local client = vim.lsp.get_clients({ bufnr = bufnr, method = 'textDocument/references' })[1]
  if not client then
    return
  end

  local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
  params.context = { includeDeclaration = true }
  client:request('textDocument/references', params, function(_, result)
    if not is_open() then
      return
    end

    local function col(pos)
      local line = vim.api.nvim_buf_get_lines(bufnr, pos.line, pos.line + 1, false)[1] or ''
      return vim.str_byteindex(line, client.offset_encoding, pos.character, false)
    end

    for _, loc in ipairs(result or {}) do
      if vim.uri_to_bufnr(loc.uri) == bufnr then
        local s, e = loc.range.start, loc.range['end']
        vim.hl.range(bufnr, ns, 'Search', { s.line, col(s) }, { e.line, col(e) })
      end
    end
  end, bufnr)
end

function _M.lsp_rename()
  local bufnr = vim.api.nvim_get_current_buf()
  local origin = vim.api.nvim_get_current_win()
  local pos = vim.api.nvim_win_get_cursor(origin)
  local cword = vim.fn.expand('<cword>')
  local open = true

  -- the cursor's column within cword (0 when it sits before the word)
  local offset = 0
  local line = vim.api.nvim_get_current_line()
  local init = 1
  while true do
    local s, e = line:find(cword, init, true)
    if not s then
      break
    end
    if pos[2] + 1 >= s and pos[2] + 1 <= e then
      offset = pos[2] + 1 - s
      break
    end
    init = e + 1
  end

  highlight_references(bufnr, function()
    return open
  end)

  local input = vim.api.nvim_create_buf(false, true)
  vim.bo[input].bufhidden = 'wipe'
  vim.api.nvim_buf_set_lines(input, 0, -1, false, { cword })

  local win =
    vim.api.nvim_open_win(input, true, vim.lsp.util.make_floating_popup_options(30, 1, { border = 'rounded' }))
  vim.wo[win].winhighlight = 'NormalFloat:Statement,FloatBorder:FloatBorder'
  vim.wo[win].scrolloff = 0

  local function close(after)
    if not open then
      return
    end
    open = false
    vim.cmd.stopinsert()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
    vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
    if not vim.api.nvim_win_is_valid(origin) then
      return
    end
    vim.api.nvim_set_current_win(origin)
    -- stopinsert lands after this returns and moves the cursor back a column
    vim.schedule(function()
      vim.api.nvim_win_set_cursor(origin, pos)
      if after then
        after()
      end
    end)
  end

  local function apply()
    local name = vim.trim(vim.api.nvim_get_current_line())
    close(function()
      if name ~= '' and name ~= cword then
        vim.lsp.buf.rename(name, { bufnr = bufnr })
      end
    end)
  end

  vim.keymap.set({ 'n', 'i' }, '<CR>', apply, { buffer = input })
  vim.keymap.set('n', '<esc>', close, { buffer = input })
  vim.keymap.set('n', 'q', close, { buffer = input })
  vim.api.nvim_create_autocmd('WinLeave', {
    buffer = input,
    once = true,
    callback = function()
      vim.schedule(close)
    end,
  })

  -- start where the cursor sat within the name
  vim.api.nvim_win_set_cursor(win, { 1, offset })
end
