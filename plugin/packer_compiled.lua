-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/prh/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/prh/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/prh/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/prh/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/prh/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  FastFold = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/FastFold"
  },
  LuaSnip = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/LuaSnip"
  },
  ale = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/ale"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/cmp_luasnip"
  },
  fzf = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["github-nvim-theme"] = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/github-nvim-theme"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n™\15\0\0\5\0 \0#6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\14\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\3=\3\15\0025\3\16\0005\4\17\0=\4\18\0035\4\19\0=\4\20\3=\3\21\0025\3\22\0=\3\23\0025\3\24\0=\3\25\0025\3\26\0=\3\27\0025\3\28\0=\3\29\0025\3\30\0=\3\31\2B\0\2\1K\0\1\0\tyadm\1\0\1\venable\1\19preview_config\1\0\5\bcol\3\1\brow\3\0\rrelative\vcursor\nstyle\fminimal\vborder\vsingle&current_line_blame_formatter_opts\1\0\1\18relative_time\1\28current_line_blame_opts\1\0\3\18virt_text_pos\beol\14virt_text\2\ndelay\3è\a\16watch_index\1\0\2\rinterval\3è\a\17follow_files\2\fkeymaps\tn [c\1\2\1\0H&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'\texpr\2\tn ]c\1\2\1\0H&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'\texpr\2\1\0\r\17n <leader>hr0<cmd>lua require\"gitsigns\".reset_hunk()<CR>\17n <leader>hb4<cmd>lua require\"gitsigns\".blame_line(true)<CR>\17n <leader>hu5<cmd>lua require\"gitsigns\".undo_stage_hunk()<CR>\17n <leader>hS2<cmd>lua require\"gitsigns\".stage_buffer()<CR>\17v <leader>hsT<cmd>lua require\"gitsigns\".stage_hunk({vim.fn.line(\".\"), vim.fn.line(\"v\")})<CR>\17n <leader>hU8<cmd>lua require\"gitsigns\".reset_buffer_index()<CR>\17n <leader>hs0<cmd>lua require\"gitsigns\".stage_hunk()<CR>\to ih::<C-U>lua require\"gitsigns.actions\".select_hunk()<CR>\tx ih::<C-U>lua require\"gitsigns.actions\".select_hunk()<CR>\17n <leader>hp2<cmd>lua require\"gitsigns\".preview_hunk()<CR>\17n <leader>hR2<cmd>lua require\"gitsigns\".reset_buffer()<CR>\17v <leader>hrT<cmd>lua require\"gitsigns\".reset_hunk({vim.fn.line(\".\"), vim.fn.line(\"v\")})<CR>\fnoremap\2\nsigns\1\0\t\20update_debounce\3d\18sign_priority\3\6\nnumhl\1\15signcolumn\2\vlinehl\1\23current_line_blame\1\24attach_to_untracked\2\14word_diff\1\20max_file_length\3À¸\2\17changedelete\1\0\4\nnumhl\21GitSignsChangeNr\vlinehl\21GitSignsChangeLn\ttext\6~\ahl\19GitSignsChange\14topdelete\1\0\4\nnumhl\21GitSignsDeleteNr\vlinehl\21GitSignsDeleteLn\ttext\bâ€¾\ahl\19GitSignsDelete\vdelete\1\0\4\nnumhl\21GitSignsDeleteNr\vlinehl\21GitSignsDeleteLn\ttext\6_\ahl\19GitSignsDelete\vchange\1\0\4\nnumhl\21GitSignsChangeNr\vlinehl\21GitSignsChangeLn\ttext\bâ”‚\ahl\19GitSignsChange\badd\1\0\0\1\0\4\nnumhl\18GitSignsAddNr\vlinehl\18GitSignsAddLn\ttext\bâ”‚\ahl\16GitSignsAdd\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["gruvbox.nvim"] = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/gruvbox.nvim"
  },
  kommentary = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/kommentary"
  },
  ["lsp-colors.nvim"] = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nÂ\4\0\0\5\0\31\0/6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\t\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0034\4\0\0=\4\b\3=\3\n\0025\3\f\0005\4\v\0=\4\r\0035\4\14\0=\4\15\0035\4\16\0=\4\17\0035\4\18\0=\4\19\0035\4\20\0=\4\21\0035\4\22\0=\4\23\3=\3\24\0025\3\25\0004\4\0\0=\4\r\0034\4\0\0=\4\15\0035\4\26\0=\4\17\0035\4\27\0=\4\19\0034\4\0\0=\4\21\0034\4\0\0=\4\23\3=\3\28\0024\3\0\0=\3\29\0024\3\0\0=\3\30\2B\0\2\1K\0\1\0\15extensions\ftabline\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\1\2\0\0\rfilename\14lualine_b\1\2\0\0\vbranch\14lualine_a\1\0\0\1\3\0\0\nbufnr\tmode\foptions\1\0\0\23disabled_filetypes\25component_separators\1\3\0\0\bî‚±\bî‚³\23section_separators\1\3\0\0\bî‚°\bî‚²\1\0\2\18icons_enabled\2\ntheme\vgithub\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["lush.nvim"] = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/lush.nvim"
  },
  neovim = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/neovim"
  },
  ["nightfox.nvim"] = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/nightfox.nvim"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\nC\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequireƒ\1\1\0\5\0\n\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0003\4\3\0=\4\5\3=\3\a\0024\3\3\0005\4\b\0>\4\1\3=\3\t\2B\0\2\1K\0\1\0\fsources\1\0\1\tname\fluasnip\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\bcmp\frequire\0" },
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspfuzzy"] = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/nvim-lspfuzzy"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["snippets.nvim"] = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/snippets.nvim"
  },
  ["surround.nvim"] = {
    config = { "\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\19mappings_style\rsurround\nsetup\rsurround\frequire\0" },
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/surround.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/trouble.nvim"
  },
  ["vim-easymotion"] = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/vim-easymotion"
  },
  ["vim-gutentags"] = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/vim-gutentags"
  },
  ["vim-tex-fold"] = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/vim-tex-fold"
  },
  vimtex = {
    loaded = true,
    path = "/Users/prh/.local/share/nvim/site/pack/packer/start/vimtex"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: surround.nvim
time([[Config for surround.nvim]], true)
try_loadstring("\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\19mappings_style\rsurround\nsetup\rsurround\frequire\0", "config", "surround.nvim")
time([[Config for surround.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\nÂ\4\0\0\5\0\31\0/6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\t\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0034\4\0\0=\4\b\3=\3\n\0025\3\f\0005\4\v\0=\4\r\0035\4\14\0=\4\15\0035\4\16\0=\4\17\0035\4\18\0=\4\19\0035\4\20\0=\4\21\0035\4\22\0=\4\23\3=\3\24\0025\3\25\0004\4\0\0=\4\r\0034\4\0\0=\4\15\0035\4\26\0=\4\17\0035\4\27\0=\4\19\0034\4\0\0=\4\21\0034\4\0\0=\4\23\3=\3\28\0024\3\0\0=\3\29\0024\3\0\0=\3\30\2B\0\2\1K\0\1\0\15extensions\ftabline\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\1\2\0\0\rfilename\14lualine_b\1\2\0\0\vbranch\14lualine_a\1\0\0\1\3\0\0\nbufnr\tmode\foptions\1\0\0\23disabled_filetypes\25component_separators\1\3\0\0\bî‚±\bî‚³\23section_separators\1\3\0\0\bî‚°\bî‚²\1\0\2\18icons_enabled\2\ntheme\vgithub\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\nC\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequireƒ\1\1\0\5\0\n\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0003\4\3\0=\4\5\3=\3\a\0024\3\3\0005\4\b\0>\4\1\3=\3\t\2B\0\2\1K\0\1\0\fsources\1\0\1\tname\fluasnip\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n™\15\0\0\5\0 \0#6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\14\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\3=\3\15\0025\3\16\0005\4\17\0=\4\18\0035\4\19\0=\4\20\3=\3\21\0025\3\22\0=\3\23\0025\3\24\0=\3\25\0025\3\26\0=\3\27\0025\3\28\0=\3\29\0025\3\30\0=\3\31\2B\0\2\1K\0\1\0\tyadm\1\0\1\venable\1\19preview_config\1\0\5\bcol\3\1\brow\3\0\rrelative\vcursor\nstyle\fminimal\vborder\vsingle&current_line_blame_formatter_opts\1\0\1\18relative_time\1\28current_line_blame_opts\1\0\3\18virt_text_pos\beol\14virt_text\2\ndelay\3è\a\16watch_index\1\0\2\rinterval\3è\a\17follow_files\2\fkeymaps\tn [c\1\2\1\0H&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'\texpr\2\tn ]c\1\2\1\0H&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'\texpr\2\1\0\r\17n <leader>hr0<cmd>lua require\"gitsigns\".reset_hunk()<CR>\17n <leader>hb4<cmd>lua require\"gitsigns\".blame_line(true)<CR>\17n <leader>hu5<cmd>lua require\"gitsigns\".undo_stage_hunk()<CR>\17n <leader>hS2<cmd>lua require\"gitsigns\".stage_buffer()<CR>\17v <leader>hsT<cmd>lua require\"gitsigns\".stage_hunk({vim.fn.line(\".\"), vim.fn.line(\"v\")})<CR>\17n <leader>hU8<cmd>lua require\"gitsigns\".reset_buffer_index()<CR>\17n <leader>hs0<cmd>lua require\"gitsigns\".stage_hunk()<CR>\to ih::<C-U>lua require\"gitsigns.actions\".select_hunk()<CR>\tx ih::<C-U>lua require\"gitsigns.actions\".select_hunk()<CR>\17n <leader>hp2<cmd>lua require\"gitsigns\".preview_hunk()<CR>\17n <leader>hR2<cmd>lua require\"gitsigns\".reset_buffer()<CR>\17v <leader>hrT<cmd>lua require\"gitsigns\".reset_hunk({vim.fn.line(\".\"), vim.fn.line(\"v\")})<CR>\fnoremap\2\nsigns\1\0\t\20update_debounce\3d\18sign_priority\3\6\nnumhl\1\15signcolumn\2\vlinehl\1\23current_line_blame\1\24attach_to_untracked\2\14word_diff\1\20max_file_length\3À¸\2\17changedelete\1\0\4\nnumhl\21GitSignsChangeNr\vlinehl\21GitSignsChangeLn\ttext\6~\ahl\19GitSignsChange\14topdelete\1\0\4\nnumhl\21GitSignsDeleteNr\vlinehl\21GitSignsDeleteLn\ttext\bâ€¾\ahl\19GitSignsDelete\vdelete\1\0\4\nnumhl\21GitSignsDeleteNr\vlinehl\21GitSignsDeleteLn\ttext\6_\ahl\19GitSignsDelete\vchange\1\0\4\nnumhl\21GitSignsChangeNr\vlinehl\21GitSignsChangeLn\ttext\bâ”‚\ahl\19GitSignsChange\badd\1\0\0\1\0\4\nnumhl\18GitSignsAddNr\vlinehl\18GitSignsAddLn\ttext\bâ”‚\ahl\16GitSignsAdd\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
