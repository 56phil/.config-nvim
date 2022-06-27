local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- PACKER BOOTSTRAP -----------------------------------------------------------
local execute = vim.api.nvim_command

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute 'packadd packer.nvim'
end

-- require('plugins')
-- require('opts')
-- require('bindings')

-- PLUGINS --------------------------------------------------------------------
local use = require('packer').use
require('packer').startup(function()
    use 'wbthomason/packer.nvim'          -- Package manager
    use 'ludovicchabant/vim-gutentags'    -- Automatic tags management
    use 'tpope/vim-commentary'            -- gc to comment visual regions, gcc for one liner
    use 'tpope/vim-fugitive'              -- Git commands in nvim
    use 'tpope/vim-rhubarb'               -- Fugitive-companion to interact with github
    use 'tpope/vim-surround'              -- surround whatever with something
    use 'ms-jpq/chadtree'
    use 'airblade/vim-gitgutter'

    -- Highlight, edit, and navigate code using a fast incremental parsing library
    -- UI to select things (files, grep results, open buffers...)
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } } }

    use {
        'ojroques/nvim-lspfuzzy',
        requires = {
            {'junegunn/fzf'},
            {'junegunn/fzf.vim'},               -- to enable preview (optional)
        },
    }

    -- Add indentation guides even on blank lines
    use 'lukas-reineke/indent-blankline.nvim'

    -- Add git related info in the signs columns and popups
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use 'nvim-treesitter/nvim-treesitter'

    -- Additional textobjects for treesitter
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-treesitter/nvim-treesitter-refactor'

    use 'neovim/nvim-lspconfig'           -- Collection of configurations for built-in LSP client
    use 'hrsh7th/nvim-compe'              -- Autocompletion plugin
    use 'L3MON4D3/LuaSnip'                -- Snippets plugin

    -- THEMES -------------------------------------------------------------------
    use { 'lalitmee/cobalt2.nvim', requires = 'tjdevries/colorbuddy.nvim' }
    use 'flazz/vim-colorschemes'

    -- SOME OLD FAVORITES
    use 'majutsushi/tagbar'               -- <f8> toggles
    use 'windwp/nvim-autopairs'
    use 'easymotion/vim-easymotion'       -- <leader><leader>[motion]
    use 'honza/vim-snippets'

    -- From D. Coneay OSCON 2013
    -- use 'fisadev/dragvisuals.vim'         -- simply handy
    use 'vitorgalvao/autoswap_mac'        -- sorry, macs only
    -- use 'lucasteles/swtc.vim'             -- just for fun
end)

-- OPTIONS --------------------------------------------------------------------
-- require('colorbuddy').colorscheme('cobalt2')
cmd([[colorscheme desert]])

opt.cursorline = true               -- highlight current line
opt.expandtab = true                -- Use spaces instead of tabs
opt.fileencoding = 'utf-8'          -- what else?
opt.hidden = true                   -- Enable background buffers
opt.ignorecase = true               -- Ignore case
opt.incsearch = true                -- search as we go
opt.joinspaces = false              -- No double spaces with join
opt.list = true                     -- Show some invisible characters
opt.mouse = 'inv'                   -- listen for clicks in insert, normal, visual
opt.number = true                   -- Show line numbers
opt.numberwidth = 5                 -- space for line numbers
opt.relativenumber = true           -- Relative line numbers
opt.scrolloff = 3                   -- Lines of context
opt.shiftround = true               -- Round indent
opt.shiftwidth = 4                  -- Size of an indent
opt.showmode = false                -- now in status line
opt.sidescrolloff = 8               -- Columns of context
opt.smartcase = true                -- Do not ignore case with capitals
opt.smartindent = true              -- Insert indents automatically
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new windows right of current
opt.tabstop = 4                     -- Number of spaces tabs count for
opt.termguicolors = true            -- True color support
opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
opt.wrap = false                    -- Disable line wrap

-- MAPPINGS -------------------------------------------------------------------
g.mapleader = ','                   -- change the <leader> key to be comma
map('', '<leader>c', '"+y')         -- Copy to clipboard in normal, visual, select and operator modes
map('i', '<C-u>', '<C-g>u<C-u>')    -- Make <C-u> undo-friendly
map('i', '<C-w>', '<C-g>u<C-w>')    -- Make <C-w> undo-friendly

-- WRITE ONLY WHEN CHANGED-----------------------------------------------------
map('n', '<leader>w', ':up<cr>')

-- <Tab> to navigate the completion menu
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

map('n', '<C-l>', '<cmd>noh<CR>')   -- Clear highlights
map('n', '<leader>o', 'm`o<Esc>``') -- Insert a newline in normal mode

-- MOVE LINES -----------------------------------------------------------------
map('n', '<up>', 'ddkP')            -- move line up
map('n', '<down>', 'ddp')           -- move line down

-- BUFFER HOPPING ------------------------------------------------------------- 
map('n', '<right>', ':bn<cr>')      -- next buffer
map('n', '<left>', ':bp<cr>')       -- previous buffer 

-- WINDOW HOPPING -------------------------------------------------------------
map('n', '<S-up>', '<C-w>k')        -- move up a window
map('n', '<S-down>', '<C-w>j')      -- move down a window
map('n', '<S-left>', '<C-w>h')      -- move left a window
map('n', '<S-right>', '<C-w>l')     -- move to window on the right

-- PASTE LAST YANKED ----------------------------------------------------------
map('n', '<leader>p', '"0p')
map('n', '<leader>P', '"0P')

-- UPDATE & SOURCE ------------------------------------------------------------
map('n', '<leader>s', ':up<cr>:so %<cr>')

-- WRITE ONLY WHEN CHANGED-----------------------------------------------------
map('n', '<leader>w', ':up<cr>')

-- SWAP ':' & ';' while in normal or visual mode ------------------------------
map('n', ';', ':')
map('v', ';', ':')

map('n', ':', ';')
map('v', ':', ';')

-- EASYCAPS -------------------------------------------------------------------
map('n', '<C-u>', 'viwU<ESC>')      -- WORD UPPER
map('i', '<C-u>', '<ESC>viwU')      -- WORD UPPER

-- pyright --------------------------------------------------------------------
require'lspconfig'.pyright.setup{}

-- COMPE ----------------------------------------------------------------------
vim.o.completeopt = "menuone,noselect"
require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    resolve_timeout = 800;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = {
        border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
        winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
        max_width = 120,
        min_width = 60,
        max_height = math.floor(vim.o.lines * 0.3),
        min_height = 1,
    };

    source = {
        path = true;
        buffer = true;
        calc = true;
        nvim_lsp = true;
        nvim_lua = true;
        vsnip = true;
        ultisnips = true;
        luasnip = true;
    };
}

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
lsp.ccls.setup {}
lsp.pylsp.setup {}
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
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'cobalt2',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {},
        always_divide_middle = true,
    },
    sections = {
        lualine_a = {'bufnr', 'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
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

-- TAGBAR ---------------------------------------------------------------------
cmd ([[
nmap <F8> :TagbarToggle<CR>
]])

map('n', '<leader>f', ':CHADopen<cr>')
