-- https://oroques.dev/notes/neovim-init/

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

--[[
local function getCurrentDirectory()
require('lfs')
local cwd = lfs.currentdir()
return cwd
end
]]

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

    -- ALE --------------------------------------------------------------------
    use 'dense-analysis/ale'

    -- ALL THE REST -----------------------------------------------------------
    use 'kyazdani42/nvim-web-devicons'
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons'
    }
    use {
        "blackCauldron7/surround.nvim",
        config = function()
            require"surround".setup {mappings_style = "surround"}
        end
    }
    use 'b3nj5m1n/kommentary'             -- Easier commenting
    use 'easymotion/vim-easymotion'

    -- CMP --------------------------------------------------------------------
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use { 'hrsh7th/nvim-cmp',
    config = function ()
        require'cmp'.setup {
            snippet = {
                expand = function(args)
                    require'luasnip'.lsp_expand(args.body)
                end
            },
            sources = {
                { name = 'luasnip' },
                -- more sources
            },
        }
    end }
    use 'norcalli/snippets.nvim'

    use { 'saadparwaiz1/cmp_luasnip' }

    -- GUTTER STUFF -----------------------------------------------------------
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }
    -- Add git related info in the signs columns and popups -------------------
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('gitsigns').setup {
                signs = {
                    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
                    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
                    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
                    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
                    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
                },
                signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
                numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
                keymaps = {
                    -- Default keymap options
                    noremap = true,

                    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
                    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

                    ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
                    ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
                    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
                    ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
                    ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
                    ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
                    ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
                    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
                    ['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
                    ['n <leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

                    -- Text objects
                    ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
                    ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
                },
                watch_index = {
                    interval = 1000,
                    follow_files = true
                },
                attach_to_untracked = true,
                current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                    delay = 1000,
                },
                current_line_blame_formatter_opts = {
                    relative_time = false
                },
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil, -- Use default
                max_file_length = 40000,
                preview_config = {
                    -- Options passed to nvim_open_win
                    border = 'single',
                    style = 'minimal',
                    relative = 'cursor',
                    row = 0,
                    col = 1
                },
                yadm = {
                    enable = false
                },
            }
        end
    }

    -- GUTEN TAGS -------------------------------------------------------------
    use 'ludovicchabant/vim-gutentags'

    -- LATEX ------------------------------------------------------------------
    use 'Konfekt/FastFold'
    use 'matze/vim-tex-fold'
    use 'lervag/vimtex'

    -- LSP --------------------------------------------------------------------
    use 'folke/lsp-colors.nvim'
    use 'neovim/nvim-lspconfig'
    use {
        'ojroques/nvim-lspfuzzy',
        requires = {
            {'junegunn/fzf'},
            {'junegunn/fzf.vim'},  -- to enable preview (optional)
        },
    }
    use "ray-x/lsp_signature.nvim"

    -- LUALINE ----------------------------------------------------------------
    use {
        "hoob3rt/lualine.nvim",
        config = function()
            require("lualine").setup {
                options = {
                    theme = "gruvbox",
                    icons_enabled = true,
                    section_separators = {'', ''},
                    component_separators = {'', ''},
                    disabled_filetypes = {}
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch'},
                    lualine_c = {'filename'},
                    lualine_x = {},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {
                    lualine_a = {'bufnr'},
                    lualine_b = {'hostname'},
                    lualine_c = {},
                    lualine_x = {'encoding'},
                    lualine_y = {'fileformat'},
                    lualine_z = {'filetype'}
                },
                extensions = {}

            }
        end
    }

    -- LUASNIP ----------------------------------------------------------------
    use { 'L3MON4D3/LuaSnip' }

    -- NEORG ------------------------------------------------------------------
    use {
        "nvim-neorg/neorg",
        config = function()
            require('neorg').setup {
                -- Tell Neorg what modules to load
                load = {
                    ["core.defaults"] = {}, -- Load all the default modules
                    ["core.norg.concealer"] = {}, -- Allows for use of icons
                    ["core.norg.dirman"] = { -- Manage your directories with Neorg
                    config = {
                        workspaces = {
                            my_workspace = "~/neorg"
                        }
                    }  }
                },
            }
        end,
        requires = "nvim-lua/plenary.nvim"
    }

    -- TELESCOPE --------------------------------------------------------------
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- THEMES -----------------------------------------------------------------
    use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
    use "projekt0n/github-nvim-theme"

    -- TREE-SITTER ------------------------------------------------------------
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-refactor'
end)

-- ALE ------------------------------------------------------------------------
cmd ([[
let g:ale_linters = {'python': ['pylint'], 'vim': ['vint'], 'cpp': ['clang'], 'c': ['clang']}
let g:neoformat_cpp_clangformat = { 'exe': 'clang-format', 'args': ['--style="{IndentWidth: 4}"'] }
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']
]])

-- ALL THE REST ---------------------------------------------------------------
require("lsp-colors").setup({
    Error = "#db4b4b",
    Warning = "#e0af68",
    Information = "#0db9d7",
    Hint = "#10B981"
})

map('n', '<C-u>', 'viwU<ESC>')              -- WORD UPPER
map('i', '<C-u>', '<ESC>viwU')              -- WORD UPPER
map('n', '<leader>s', ':up<cr>:so %<cr>')   -- SAVE & SOURCE
map('n', '<S-up>', '<C-w>k')                -- MOVE UP a WINDOW
map('n', '<S-down>', '<C-w>j')              -- MOVE DOWN A WINDOW
map('n', '<S-left>', '<C-w>h')              -- MOVE LEFT A WINDOW
map('n', '<S-right>', '<C-w>l')             -- MOVE TO WINDOW ON THE RIGHT
map('n', '<leader>w', ':up<cr>')            -- UPDATE
map('n', '<left>', ':bp<cr>')               -- PREVIOUS BUFFER
map('n', '<right>', ':bn<cr>')              -- NEXT BUFFER


-- CMP ------------------------------------------------------------------------
-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
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
        { name = 'luasnip' },
        { name = 'buffer' },
    }
})

-- <Tab> to navigate the completion menu
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

map('n', '<C-l>', '<cmd>noh<CR>')       -- Clear highlights
map('n', '<leader>o', 'm`o<Esc>``')     -- Insert a newline in normal mode

-- COLORSCHEME PUT YOUR FAVORITE HERE -----------------------------------------
-- cmd 'colorscheme desert'
cmd 'colorscheme gruvbox'

-- GUTTER STUFF ---------------------------------------------------------------
require'nvim-web-devicons'.setup {
    -- your personnal icons can go here (to override)
    -- DevIcon will be appended to `name`
    override = {
        zsh = {
            icon = "",
            color = "#428850",
            name = "Zsh"
        }
    };
    -- globally enable default icons (default to false)
    -- will get overriden by `get_icons` option
    default = true;
}

-- LATEX ----------------------------------------------------------------------
g.tex_flavor  = 'latex'
g.tex_conceal = ''
g.vimtex_fold_manual = 1
g.vimtex_latexmk_continuous = 1
g.vimtex_compiler_progname = 'nvr'

-- LSP ------------------------------------------------------------------------
local nvim_lsp = require('lspconfig')
require('lspfuzzy').setup {}

cfg = {
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    -- If you want to hook lspsaga or other signature handler, pls set to false
    doc_lines = 2, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
    -- set to 0 if you DO NOT want any API comments be shown
    -- This setting only take effect in insert mode, it does not affect signature help in normal
    -- mode, 10 by default

    floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

    floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
    -- will set to truewhen fully tested, set to false will use whichever side has more space
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
local servers = { 'ccls', 'clangd', 'pylsp', 'pyright'  }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        }
    }
end

-- LSPCONFIG ------------------------------------------------------------------
require('lspconfig')['ccls'].setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

-- MAPPINGS -------------------------------------------------------------------
g.mapleader = ','                       -- change the <leader> key to be comma
map('', '<leader>c', '"+y')             -- Copy to clipboard in normal, visual, select and operator modes
map('i', '<C-u>', '<C-g>u<C-u>')        -- Make <C-u> undo-friendly

-- MOVE LINES -----------------------------------------------------------------
map('n', '<up>', 'ddkP')                -- move line up
map('n', '<down>', 'ddp')               -- move line down

-- NVIM TREE ------------------------------------------------------------------
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
-- default mappings
g.nvim_tree_bindings = {
    { key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit") },
    { key = {"<2-RightMouse>", "<C-]>"},    cb = tree_cb("cd") },
    { key = "<C-v>",                        cb = tree_cb("vsplit") },
    { key = "<C-x>",                        cb = tree_cb("split") },
    { key = "<C-t>",                        cb = tree_cb("tabnew") },
    { key = "<",                            cb = tree_cb("prev_sibling") },
    { key = ">",                            cb = tree_cb("next_sibling") },
    { key = "P",                            cb = tree_cb("parent_node") },
    { key = "<BS>",                         cb = tree_cb("close_node") },
    { key = "<S-CR>",                       cb = tree_cb("close_node") },
    { key = "<Tab>",                        cb = tree_cb("preview") },
    { key = "K",                            cb = tree_cb("first_sibling") },
    { key = "J",                            cb = tree_cb("last_sibling") },
    { key = "I",                            cb = tree_cb("toggle_ignored") },
    { key = "H",                            cb = tree_cb("toggle_dotfiles") },
    { key = "R",                            cb = tree_cb("refresh") },
    { key = "a",                            cb = tree_cb("create") },
    { key = "d",                            cb = tree_cb("remove") },
    { key = "r",                            cb = tree_cb("rename") },
    { key = "<C-r>",                        cb = tree_cb("full_rename") },
    { key = "x",                            cb = tree_cb("cut") },
    { key = "c",                            cb = tree_cb("copy") },
    { key = "p",                            cb = tree_cb("paste") },
    { key = "y",                            cb = tree_cb("copy_name") },
    { key = "Y",                            cb = tree_cb("copy_path") },
    { key = "gy",                           cb = tree_cb("copy_absolute_path") },
    { key = "[c",                           cb = tree_cb("prev_git_item") },
    { key = "]c",                           cb = tree_cb("next_git_item") },
    { key = "-",                            cb = tree_cb("dir_up") },
    { key = "s",                            cb = tree_cb("system_open") },
    { key = "q",                            cb = tree_cb("close") },
    { key = "g?",                           cb = tree_cb("toggle_help") },
}

-- OPTIONS --------------------------------------------------------------------
opt.background = "dark"                 -- or "light" for light mode
opt.completeopt = "menu,menuone,noselect"
opt.cursorcolumn = true                 -- highlight current column
opt.cursorline = true                   -- highlight current line
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

-- PASTE LAST YANKED ----------------------------------------------------------
map('n', '<leader>p', '"0p')
map('n', '<leader>P', '"0P')

-- STRIP TRAILING WHITE SPACE -------------------------------------------------
cmd ([[
au!
let l = line(".")
let c = col(".")
au BufWrite * %s/\s\+$//e
call cursor(l, c)
augroup end
]])

-- SWAP : ; -------------------------------------------------------------------
map('n', ';', ':')
map('v', ';', ':')

map('n', ':', ';')
map('v', ':', ';')

-- TELESCOPE ------------------------------------------------------------------
map('n', '<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>')
map('n', '<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>')
map('n', '<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>')
map('n', '<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>')

-- TREE-SITTER ----------------------------------------------------------------
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = { "javascript" }, -- List of parsers to ignore installing
    highlight = {
        enable = false,             -- false will disable the whole extension
        disable = { "c", "rust" },  -- list of language that will be disabled
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main"
    },
}

-- UPDATE & SOURCE ------------------------------------------------------------

