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
    elseif (hierarchyLevel == 4) then
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
    use 'neovim/nvim-lspconfig'           -- Collection of configurations for built-in LSP client
    use 'L3MON4D3/LuaSnip'                -- Snippets plugin
    use 'Shougo/deoplete.nvim'
    use 'deoplete-plugins/deoplete-clang'
    use 'dense-analysis/ale'

    -- THEMES -------------------------------------------------------------------
    use 'joshdick/onedark.vim'            -- Inspired by Atom
    use 'morhetz/gruvbox'
    use 'ajh17/spacegray.vim'

    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }

    use { 'ojroques/nvim-lspfuzzy', requires = { {'junegunn/fzf'}, {'junegunn/fzf.vim'}, }, }

    -- some old favorites
    use 'easymotion/vim-easymotion'       -- <leader><leader>[motion]
    use 'honza/vim-snippets'
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
-- cmd 'colorscheme desert'
cmd 'colorscheme gruvbox'
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

g.vimtex_compiler_progname = 'nvr'

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
lsp.pylsp.setup {}
lsp.ccls.setup {}
lspfuzzy.setup {}  -- Make the LSP client use FZF instead of the quickfix list

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

-- start and configure deoplete
cmd ([[
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('ignore_sources', {'_': ['around', 'buffer']})
]])

-- ale
cmd ([[
let g:ale_linters = {'python': ['pylint'], 'vim': ['vint'], 'cpp': ['clang'], 'c': ['clang']}
let g:neoformat_cpp_clangformat = { 'exe': 'clang-format', 'args': ['--style="{IndentWidth: 4}"'] }
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']
]])
