-- TAKEN FROM OLIVER ROQUES' A LUA.INIT IN "Neovim 0.5 features and the switch
-- to init.lua" https://oroques.dev/notes/neovim-init/

-- HELPERS --------------------------------------------------------------------
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function printObj(obj, hierarchyLevel)
    if (hierarchyLevel == nil) then
        hierarchyLevel = 0
    elseif (herarchyLevel == 4) then
        return 0
    end

    local whitespace = ""
    for i=0,hierarchyLevel,1 do
        whitespace = whitespace .. "-"
    end
    io.write(whitespace)

    print(obj)
    if (type(obj) == "table") then
        for k,v in pairs(obj) do
            io.write(whitespace .. "-")
            if (type(v) == "table") then
                printObj(v, hierarchyLevel+1)
            else
                print(v)
            end
        end
    else
        print(obj)
    end
end

-- PACKER BOOTSTRAP -----------------------------------------------------------
-- local execute = vim.api.nvim_command

-- local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

-- if fn.empty(fn.glob(install_path)) > 0 then
--   fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
--   execute 'packadd packer.nvim'
-- end

-- PLUGINS --------------------------------------------------------------------
local use = require('packer').use
require('packer').startup(function()
    use 'wbthomason/packer.nvim'          -- Package manager
    use 'ludovicchabant/vim-gutentags'    -- Automatic tags management
    use 'tpope/vim-commentary'            -- "gc" to comment visual regions/lines
    use 'tpope/vim-fugitive'              -- Git commands in nvim
    use 'tpope/vim-rhubarb'               -- Fugitive-companion to interact with github
    use 'tpope/vim-surround'              -- surround whatever with something

    -- Highlight, edit, and navigate code using a fast incremental parsing library
    -- UI to select things (files, grep results, open buffers...)
    use 'hoob3rt/lualine.nvim'            -- Quicker statusline
    use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } } }

    -- Add indentation guides even on blank lines
    use 'lukas-reineke/indent-blankline.nvim'

    -- Add git related info in the signs columns and popups
    -- use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use 'nvim-treesitter/nvim-treesitter'

    -- Additional textobjects for treesitter
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-treesitter/nvim-treesitter-refactor'
    use 'roxma/nvim-yarp'
    use 'ncm2/ncm2'
    use 'L3MON4D3/LuaSnip'                -- Snippets plugin
    use 'dense-analysis/ale'

    -- THEMES -------------------------------------------------------------------
    use 'joshdick/onedark.vim'            -- Inspired by Atom
    use 'morhetz/gruvbox'
    use 'ajh17/spacegray.vim'

    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use { 'ojroques/nvim-lspfuzzy', requires = { {'junegunn/fzf'}, {'junegunn/fzf.vim'}, }, }

    use "ray-x/lsp_signature.nvim"
    use 'neovim/nvim-lspconfig'           -- Collection of configurations for built-in LSP client
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'

    -- some old favorites
    use 'easymotion/vim-easymotion'       -- <leader><leader>[motion]
    use 'honza/vim-snippets'
    use 'lervag/vimtex'
    use 'majutsushi/tagbar'               -- <f8> toggles
    use 'mklabs/vim-cowsay'
    use 'scrooloose/nerdtree'
    use 'tomtom/tcomment_vim'
    use 'vim-scripts/c.vim'
    use 'windwp/nvim-autopairs'

    -- From D. Conway OSCON 2013
    use 'vitorgalvao/autoswap_mac'        -- sorry, macs only
end)

-- PUT YOUR FAVORITE COLORSCHEME HERE -----------------------------------------
cmd 'colorscheme desert'
-- cmd 'colorscheme gruvbox'
-- cmd 'colorscheme onedark'
-- cmd 'colorscheme spacegray'

-- OPTIONS --------------------------------------------------------------------
opt.cursorcolumn = true
opt.cursorline = true
opt.expandtab = true                    -- Use spaces instead of tabs
opt.hidden = true                       -- Enable background buffers
opt.ignorecase = true                   -- Ignore case
opt.joinspaces = false                  -- No double spaces with join
opt.list = true                         -- Show some invisible characters
opt.mouse = 'a'                         -- Enable mouse, all modes
opt.number = true                       -- so current line has actual number
opt.relativenumber = true               -- Relative line numbers
opt.scrolloff = 3                       -- Lines of context
opt.shiftround = true                   -- Round indent
opt.shiftwidth = 4                      -- Size of an indent
opt.showmode = false                    -- now in status line
opt.sidescrolloff = 8                   -- Columns of context
opt.smartcase = true                    -- Do not ignore case with capitals
opt.smartindent = true                  -- Insert indents automatically
opt.splitbelow = true                   -- Put new windows below current
opt.splitright = true                   -- Put new windows right of current
opt.tabstop = 4                         -- Number of spaces tabs count for
opt.termguicolors = true                -- True color support
opt.wildmode = {'list', 'longest'}      -- Command-line completion mode
opt.wrap = false                        -- Disable line wrap
opt.completeopt = "menu,menuone,noselect"

-- MAPPINGS -------------------------------------------------------------------
g.mapleader = ','                       -- change the <leader> key to be comma
map('', '<leader>c', '"+y')             -- Copy to clipboard in normal, visual, select and operator modes
map('i', '<C-u>', '<C-g>u<C-u>')        -- Make <C-u> undo-friendly

-- WRITE ONLY WHEN CHANGED-----------------------------------------------------
map('n', '<leader>w', ':up<cr>')

-- <Tab> to navigate the completion menu
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

map('n', '<C-l>', '<cmd>noh<CR>')       -- Clear highlights
map('n', '<leader>o', 'm`o<Esc>``')     -- Insert a newline in normal mode

-- MOVE LINES -----------------------------------------------------------------
map('n', '<up>', 'ddkP')                -- move line up
map('n', '<down>', 'ddp')               -- move line down
-- BUFFER HOPPING -------------------------------------------------------------
map('n', '<right>', ':bn<cr>')          -- next buffer

map('n', '<left>', ':bp<cr>')           -- previous buffer

-- WINDOW HOPPING -------------------------------------------------------------
map('n', '<S-up>', '<C-w>k')            -- move up a window
map('n', '<S-down>', '<C-w>j')          -- move down a window
map('n', '<S-left>', '<C-w>h')          -- move left a window
map('n', '<S-right>', '<C-w>l')         -- move to window on the right

-- PASTE LAST YANKED ----------------------------------------------------------
map('n', '<leader>p', '"0p')
map('n', '<leader>P', '"0P')

-- UPDATE & SOURCE ------------------------------------------------------------
map('n', '<leader>s', ':up<cr>:so %<cr>')

-- WRITE ONLY WHEN CHANGED-----------------------------------------------------
map('n', '<leader>w', ':up<cr>')

-- SWAP : ; -------------------------------------------------------------------
map('n', ';', ':')
map('v', ';', ':')

map('n', ':', ';')
map('v', ':', ';')

-- EASYCAPS -------------------------------------------------------------------
map('n', '<C-u>', 'viwU<ESC>')          -- WORD UPPER
map('i', '<C-u>', '<ESC>viwU')          -- WORD UPPER

-- LUASNIP --------------------------------------------------------------------
cmd ([[
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
]])

-- TREE-SITTER ----------------------------------------------------------------
local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}

-- LSP ------------------------------------------------------------------------
-- local lsp = require 'lspconfig'
-- local lspfuzzy = require 'lspfuzzy'

-- We use the default settings for ccls and pylsp: the option table can stay empty
-- lspfuzzy.setup {}  -- Make the LSP client use FZF instead of the quickfix list
-- lsp.ccls.setup {}
-- lsp.pylsp.setup {}
-- lsp.clangd.setup{}
-- lsp.pyright.setup{}
-- lsp.rust_analyzer.setup{}

map('n', '<space>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<space>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<space>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<space>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<space>r', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')

-- COMMANDS -------------------------------------------------------------------
cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'  -- disabled in visual mode

-- TELESCOPE ------------------------------------------------------------------
map('n', '<space>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>')
map('n', '<space>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>')
map('n', '<space>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>')
map('n', '<space>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>')

-- STATUS LINE ----------------------------------------------------------------
require'lualine'.setup {
    options = {
        icons_enabled = true,
        theme = 'onedark',
        section_separators = {'', ''},
        component_separators = {'', ''},
        disabled_filetypes = {}
    },
    sections = {
        lualine_a = {'bufnr', 'mode'},
        lualine_b = {'branch'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}

-- NERDTree -------------------------------------------------------------------
map('n', '<F2>', '<cmd>NERDTreeToggle<cr>')
cmd ([[
autocmd VimEnter * NERDTree
]])

-- TAGBAR ---------------------------------------------------------------------
map('n', '<F8>', '<cmd>TagbarToggle<cr>')

-- STRIP TRAILING WHITE SPACE -------------------------------------------------
cmd ([[
au!
let l = line(".")
let c = col(".")
au BufWrite * %s/\s\+$//e
call cursor(l, c)
augroup end
]])

-- ale
cmd ([[
let g:ale_linters = {'python': ['pylint'], 'vim': ['vint'], 'cpp': ['clang'], 'c': ['clang']}
let g:neoformat_cpp_clangformat = { 'exe': 'clang-format', 'args': ['--style="{IndentWidth: 4}"'] }
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']
]])

-- vimtex
cmd ([[
let g:vimtex_compiler_progname = 'nvr'
]])

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

  -- Mappings.

-- local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

cfg = {
  bind = true,      -- This is mandatory, otherwise border config won't get registered.
                    -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 2, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                 -- set to 0 if you DO NOT want any API comments be shown
                 -- This setting only take effect in insert mode, it does not affect signature help in normal
                 -- mode, 10 by default

  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap
  fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = true, -- virtual hint enable
  hint_prefix = "🐼 ",  -- Panda for parameter
  hint_scheme = "String",
  use_lspsaga = false,  -- set to true if you want to use lspsaga popup
  hi_parameter = "Search", -- how your parameter will be highlight
  max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
                   -- to view the hiding contents
  max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
  transpancy = 10, -- set this value if you want the floating windows to be transpant (100 fully transpant), nil to disable(default)
  handler_opts = {
    border = "shadow"   -- double, single, shadow, none
  },

  trigger_on_newline = false, -- set to true if you need multiple line parameter, sometime show signature on new line can be confusing, set it to false for #58
  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  -- deprecate !!
  -- decorator = {"`", "`"}  -- this is no longer needed as nvim give me a handler and it allow me to highlight active parameter in floating_window
  zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
  debug = false, -- set to true to enable debug logging
  log_path = "debug_log_file_path", -- debug log path

  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
  toggle_key = nil -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
}

-- require'lsp_signature'.on_attach(cfg, bufnr) -- no need to specify bufnr if you don't use toggle_key

cmd([[
set completeopt=menu,menuone,noselect
]])

-- TAKEN FROM OLIVER ROQUES' A LUA.INIT IN "Neovim 0.5 features and the switch
-- to init.lua" https://oroques.dev/notes/neovim-init/

-- HELPERS --------------------------------------------------------------------
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function printObj(obj, hierarchyLevel)
    if (hierarchyLevel == nil) then
        hierarchyLevel = 0
    elseif (herarchyLevel == 4) then
        return 0
    end

    local whitespace = ""
    for i=0,hierarchyLevel,1 do
        whitespace = whitespace .. "-"
    end
    io.write(whitespace)

    print(obj)
    if (type(obj) == "table") then
        for k,v in pairs(obj) do
            io.write(whitespace .. "-")
            if (type(v) == "table") then
                printObj(v, hierarchyLevel+1)
            else
                print(v)
            end
        end
    else
        print(obj)
    end
end

-- PACKER BOOTSTRAP -----------------------------------------------------------
-- local execute = vim.api.nvim_command

-- local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

-- if fn.empty(fn.glob(install_path)) > 0 then
--   fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
--   execute 'packadd packer.nvim'
-- end

-- PLUGINS --------------------------------------------------------------------
local use = require('packer').use
require('packer').startup(function()
    use 'wbthomason/packer.nvim'          -- Package manager
    use 'ludovicchabant/vim-gutentags'    -- Automatic tags management
    use 'tpope/vim-commentary'            -- "gc" to comment visual regions/lines
    use 'tpope/vim-fugitive'              -- Git commands in nvim
    use 'tpope/vim-rhubarb'               -- Fugitive-companion to interact with github
    use 'tpope/vim-surround'              -- surround whatever with something

    -- Highlight, edit, and navigate code using a fast incremental parsing library
    -- UI to select things (files, grep results, open buffers...)
    use 'hoob3rt/lualine.nvim'            -- Quicker statusline
    use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } } }

    -- Add indentation guides even on blank lines
    use 'lukas-reineke/indent-blankline.nvim'

    -- Add git related info in the signs columns and popups
    -- use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use 'nvim-treesitter/nvim-treesitter'

    -- Additional textobjects for treesitter
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-treesitter/nvim-treesitter-refactor'
    use 'roxma/nvim-yarp'
    use 'ncm2/ncm2'
    use 'L3MON4D3/LuaSnip'                -- Snippets plugin
    use 'dense-analysis/ale'

    -- THEMES -------------------------------------------------------------------
    use 'joshdick/onedark.vim'            -- Inspired by Atom
    use 'morhetz/gruvbox'
    use 'ajh17/spacegray.vim'

    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use { 'ojroques/nvim-lspfuzzy', requires = { {'junegunn/fzf'}, {'junegunn/fzf.vim'}, }, }


    use "ray-x/lsp_signature.nvim"
    use 'neovim/nvim-lspconfig'           -- Collection of configurations for built-in LSP client
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'

    -- some old favorites
    use 'easymotion/vim-easymotion'       -- <leader><leader>[motion]
    use 'honza/vim-snippets'
    use 'lervag/vimtex'
    use 'majutsushi/tagbar'               -- <f8> toggles
    use 'mklabs/vim-cowsay'
    use 'scrooloose/nerdtree'
    use 'tomtom/tcomment_vim'
    use 'vim-scripts/c.vim'
    use 'windwp/nvim-autopairs'

    -- From D. Conway OSCON 2013
    use 'vitorgalvao/autoswap_mac'        -- sorry, macs only
end)

-- PUT YOUR FAVORITE COLORSCHEME HERE -----------------------------------------
cmd 'colorscheme desert'
-- cmd 'colorscheme gruvbox'
-- cmd 'colorscheme onedark'
-- cmd 'colorscheme spacegray'

-- OPTIONS --------------------------------------------------------------------
opt.cursorcolumn = true
opt.cursorline = true
opt.expandtab = true                    -- Use spaces instead of tabs
opt.hidden = true                       -- Enable background buffers
opt.ignorecase = true                   -- Ignore case
opt.joinspaces = false                  -- No double spaces with join
opt.list = true                         -- Show some invisible characters
opt.mouse = 'a'                         -- Enable mouse, all modes
opt.number = true                       -- so current line has actual number
opt.relativenumber = true               -- Relative line numbers
opt.scrolloff = 3                       -- Lines of context
opt.shiftround = true                   -- Round indent
opt.shiftwidth = 4                      -- Size of an indent
opt.showmode = false                    -- now in status line
opt.sidescrolloff = 8                   -- Columns of context
opt.smartcase = true                    -- Do not ignore case with capitals
opt.smartindent = true                  -- Insert indents automatically
opt.splitbelow = true                   -- Put new windows below current
opt.splitright = true                   -- Put new windows right of current
opt.tabstop = 4                         -- Number of spaces tabs count for
opt.termguicolors = true                -- True color support
opt.wildmode = {'list', 'longest'}      -- Command-line completion mode
opt.wrap = false                        -- Disable line wrap
opt.completeopt = "menu,menuone,noselect"

-- MAPPINGS -------------------------------------------------------------------
g.mapleader = ','                       -- change the <leader> key to be comma
map('', '<leader>c', '"+y')             -- Copy to clipboard in normal, visual, select and operator modes
map('i', '<C-u>', '<C-g>u<C-u>')        -- Make <C-u> undo-friendly

-- WRITE ONLY WHEN CHANGED-----------------------------------------------------
map('n', '<leader>w', ':up<cr>')

-- <Tab> to navigate the completion menu
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

map('n', '<C-l>', '<cmd>noh<CR>')       -- Clear highlights
map('n', '<leader>o', 'm`o<Esc>``')     -- Insert a newline in normal mode

-- MOVE LINES -----------------------------------------------------------------
map('n', '<up>', 'ddkP')                -- move line up
map('n', '<down>', 'ddp')               -- move line down
-- BUFFER HOPPING -------------------------------------------------------------
map('n', '<right>', ':bn<cr>')          -- next buffer

map('n', '<left>', ':bp<cr>')           -- previous buffer

-- WINDOW HOPPING -------------------------------------------------------------
map('n', '<S-up>', '<C-w>k')            -- move up a window
map('n', '<S-down>', '<C-w>j')          -- move down a window
map('n', '<S-left>', '<C-w>h')          -- move left a window
map('n', '<S-right>', '<C-w>l')         -- move to window on the right

-- PASTE LAST YANKED ----------------------------------------------------------
map('n', '<leader>p', '"0p')
map('n', '<leader>P', '"0P')

-- UPDATE & SOURCE ------------------------------------------------------------
map('n', '<leader>s', ':up<cr>:so %<cr>')

-- WRITE ONLY WHEN CHANGED-----------------------------------------------------
map('n', '<leader>w', ':up<cr>')

-- SWAP : ; -------------------------------------------------------------------
map('n', ';', ':')
map('v', ';', ':')

map('n', ':', ';')
map('v', ':', ';')

-- EASYCAPS -------------------------------------------------------------------
map('n', '<C-u>', 'viwU<ESC>')          -- WORD UPPER
map('i', '<C-u>', '<ESC>viwU')          -- WORD UPPER

-- LUASNIP --------------------------------------------------------------------
cmd ([[
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
]])

-- TREE-SITTER ----------------------------------------------------------------
local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}

-- LSP ------------------------------------------------------------------------
local lsp = require 'lspconfig'
local lspfuzzy = require 'lspfuzzy'

-- We use the default settings for ccls and pylsp: the option table can stay empty
lspfuzzy.setup {}  -- Make the LSP client use FZF instead of the quickfix list
lsp.ccls.setup {}
lsp.pylsp.setup {}
lsp.clangd.setup{}
lsp.pyright.setup{}
-- lsp.rust_analyzer.setup{}

map('n', '<space>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<space>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<space>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<space>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<space>r', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')

-- COMMANDS -------------------------------------------------------------------
cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'  -- disabled in visual mode

-- TELESCOPE ------------------------------------------------------------------
map('n', '<space>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>')
map('n', '<space>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>')
map('n', '<space>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>')
map('n', '<space>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>')

-- STATUS LINE ----------------------------------------------------------------
require'lualine'.setup {
    options = {
        icons_enabled = true,
        theme = 'onedark',
        section_separators = {'', ''},
        component_separators = {'', ''},
        disabled_filetypes = {}
    },
    sections = {
        lualine_a = {'bufnr', 'mode'},
        lualine_b = {'branch'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}

-- NERDTree -------------------------------------------------------------------
map('n', '<F2>', '<cmd>NERDTreeToggle<cr>')
cmd ([[
autocmd VimEnter * NERDTree
]])

-- TAGBAR ---------------------------------------------------------------------
map('n', '<F8>', '<cmd>TagbarToggle<cr>')

-- STRIP TRAILING WHITE SPACE -------------------------------------------------
cmd ([[
au!
let l = line(".")
let c = col(".")
au BufWrite * %s/\s\+$//e
call cursor(l, c)
augroup end
]])

-- compe ----------------------------------------------------------------------
cmd ([[
let g:python3_host_prog="/opt/homebrew/bin/python3"
]])

-- ale
cmd ([[
let g:ale_linters = {'python': ['pylint'], 'vim': ['vint'], 'cpp': ['clang'], 'c': ['clang']}
let g:neoformat_cpp_clangformat = { 'exe': 'clang-format', 'args': ['--style="{IndentWidth: 4}"'] }
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']
]])

cmd ([[
let g:vimtex_compiler_progname = 'nvr'
]])

-- require'lspconfig'.rust_analyzer.setup{}

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

  -- Mappings.

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'clangd',  'pylsp', 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

cfg = {
  bind = true,      -- This is mandatory, otherwise border config won't get registered.
                    -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 2, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                 -- set to 0 if you DO NOT want any API comments be shown
                 -- This setting only take effect in insert mode, it does not affect signature help in normal
                 -- mode, 10 by default

  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap
  fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = true, -- virtual hint enable
  hint_prefix = "🐼 ",  -- Panda for parameter
  hint_scheme = "String",
  use_lspsaga = false,  -- set to true if you want to use lspsaga popup
  hi_parameter = "Search", -- how your parameter will be highlight
  max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
                   -- to view the hiding contents
  max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
  transpancy = 10, -- set this value if you want the floating windows to be transpant (100 fully transpant), nil to disable(default)
  handler_opts = {
    border = "shadow"   -- double, single, shadow, none
  },

  trigger_on_newline = false, -- set to true if you need multiple line parameter, sometime show signature on new line can be confusing, set it to false for #58
  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  -- deprecate !!
  -- decorator = {"`", "`"}  -- this is no longer needed as nvim give me a handler and it allow me to highlight active parameter in floating_window
  zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
  debug = false, -- set to true to enable debug logging
  log_path = "debug_log_file_path", -- debug log path

  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
  toggle_key = nil -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
}

require'lsp_signature'.on_attach(cfg, bufnr) -- no need to specify bufnr if you don't use toggle_key

cmd([[
set completeopt=menu,menuone,noselect
]])

  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        -- For `vsnip` user.
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.

        -- For `luasnip` user.
        require('luasnip').lsp_expand(args.body)

        -- For `ultisnips` user.
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },

      -- For vsnip user.
      -- { name = 'vsnip' },

      -- For luasnip user.
      { name = 'luasnip' },

      -- For ultisnips user.
      { name = 'ultisnips' },

      { name = 'buffer' },
    }
  })

  -- Setup lspconfig.
  -- require('lspconfig')[clangd].setup {
  --  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- }
