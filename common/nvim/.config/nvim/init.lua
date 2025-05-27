-- config from kickstart.nvim, jonhoo, mitchellh, sumitdotml

if vim.g.vscode then
  -- vscode neovim
  require "user.vscode_keymaps"
else
  -- neovim
end

-- set leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-------------------------------------------------------------------------------
-- General settings
-------------------------------------------------------------------------------

-- set tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
-- faster update time
vim.opt.updatetime = 250
-- line wrap
vim.opt.wrap = true
-- set absolute line numbers for current line
vim.opt.number = true
-- set relative line numbers
vim.opt.relativenumber = false
-- set width for numbers
vim.opt.numberwidth = 1
-- keep content on top left when splitting
vim.opt.splitright = true
vim.opt.splitbelow = true
-- infinite undo
-- NOTE: ends up in ~/.local/state/nvim/undo/
vim.opt.undofile = true
-- turn off swaps and backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.o.writebackup = false
-- when opening a file with a command (like :e),
-- don't suggest files like these
vim.opt.wildignore = ".hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site,*.DS_Store"
-- set search/replace to case-insensitive
vim.opt.ignorecase = true
-- unless uppercase in search terms
vim.o.smartcase = true
-- better scroll and cursor input
vim.opt.mouse = "a"
-- set ruler to 100 characters
vim.opt.colorcolumn = "100"
-- except in c/cpp, python
-- vim.api.nvim_create_autocmd("Filetype", { pattern = "c", command = "set colorcolumn=80" })
-- vim.api.nvim_create_autocmd("Filetype", { pattern = "cpp", command = "set colorcolumn=80" })
-- vim.api.nvim_create_autocmd("Filetype", { pattern = "python", command = "set colorcolumn=80" })
-- set term colors
vim.opt.termguicolors = true
-- set encode to standard
vim.opt.encoding = "UTF-8"
-- indent new lines in same column
vim.opt.breakindent = true
-- show mode under status line
vim.opt.showmode = true
-- show last exec command in status line
vim.opt.laststatus = 1
-- set highlight all when searching
vim.opt.hlsearch = true
-- always set draw sign column
vim.opt.signcolumn = "yes"
-- stop terminal beep
vim.opt.vb = true
-- see only one auto-completion
vim.opt.completeopt = "menuone,noselect"
-- switch to another buffer if are unsaved changes
-- vim.opt.hidden = false
-- set scroll in middle
vim.opt.scrolloff = 999
-- stop folding
-- vim.opt.foldenable = false
-- vim.opt.foldmethod = "manual"
-- vim.opt.foldlevelstart = 99
-- set conceal level for Obsidian.nvim
vim.o.conceallevel = 0
-- set diff options
-- ignore whitespace
vim.opt.diffopt:append("iwhite")
-- use smarter algorithm
vim.opt.diffopt:append("algorithm:histogram")
vim.opt.diffopt:append("indent-heuristic")
-- set spell check
vim.opt.spelllang = "en_us"
vim.opt.spell = true

-------------------------------------------------------------------------------
-- Hotkeys
-------------------------------------------------------------------------------

-- quickly open files
vim.keymap.set("", "<C-p>", "<cmd>Files<cr>")
-- quick-save
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")
-- Ctrl+j and Ctrl+k as Esc
vim.keymap.set("i", "<C-j>", "<Esc>")
vim.keymap.set("i", "<C-j>", "<Esc>")
vim.keymap.set("n", "<C-j>", "<Esc>")
vim.keymap.set("v", "<C-j>", "<Esc>")
vim.keymap.set("o", "<C-j>", "<Esc>")
-- j+k as Esc
vim.keymap.set("i", "jk", "<Esc>")
-- Ctrl+h to stop searching
-- vim.keymap.set("v", "<C-h>", "<cmd>nohlsearch<cr>")
-- vim.keymap.set("n", "<C-h>", "<cmd>nohlsearch<cr>""
-- clipboard integration for macos
vim.keymap.set("n", "<leader>v", '"+p`]')
vim.keymap.set("v", "<leader>c", '"+y')
-- open new file adjacent to current file
vim.keymap.set("n", "<leader>o", ":e <C-R>=expand('%:p:h') . '/' <cr>")
-- no arrow keys, force self to use the home row
vim.keymap.set("n", "<up>", "<nop>")
vim.keymap.set("n", "<down>", "<nop>")
vim.keymap.set("i", "<up>", "<nop>")
vim.keymap.set("i", "<down>", "<nop>")
vim.keymap.set("i", "<left>", "<nop>")
vim.keymap.set("i", "<right>", "<nop>")
-- left and right arrows can be useful, they can switch buffers
vim.keymap.set("n", "<left>", ":bp<cr>")
vim.keymap.set("n", "<right>", ":bn<cr>")
-- make j and k move by visual line, not actual line, when text is soft-wrapped
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
-- set zen mode
vim.keymap.set("n", "<leader>u", ":ZenMode <CR>", { silent = true })

-------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------

-- grab lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- setup plugins
require("lazy").setup({
  -- color theme
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
    config = function()
      require("gruvbox").setup({
        inverse = true,
        contrast = "hard",
        undercurl = false,
        underline = false,
        bold = false,
        italic = {
          strings = false,
          emphasis = false,
          comments = false,
          folds = false,
        },
        strikethrough = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
      })
      vim.cmd("colorscheme gruvbox")
      vim.cmd("highlight SpellBad cterm=underline gui=underline")

      -- set line number and sign column background to dim grey
      local unified_grey_bg = "#303030"
      local dimmer_grey_fg = "#928374"
      vim.api.nvim_set_hl(0, "LineNr", { fg = dimmer_grey_fg, bg = unified_grey_bg })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = unified_grey_bg })
    end,
  },

  -- {
  --   "catppuccin/nvim",
  --   lazy = false,
  --   name = "catppuccin",
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme "catppuccin-mocha"
  --   end,
  -- },
  
  -- {
  --   "sonph/onehalf",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- manually add `vim/` subdir to runtime
  --     vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/onehalf/vim")
  --     vim.cmd("colorscheme onehalfdark")
      
  --     -- set lighter background for completions
  --     vim.api.nvim_set_hl(0, "Pmenu", { bg = "#3e4452" })
      
  --     -- set lighter background for which-key
  --     vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#3e4452" })
  --     vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "#3e4452" })
  --   end,
  -- },

  -- status bar, lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 100,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {}, -- "encoding", "filetype"
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {}, -- { "filename", path = 1 },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {
        lualine_a = {},
        lualine_b = { { "filename", path = 1 } },
        lualine_c = {},
        lualine_x = { "searchcount", "encoding", "diagnostics" },
        lualine_y = { "filetype" },
        lualine_z = {},
      },
      inactive_winbar = {},
      extensions = {},
    },
  },

  -- fuzzy finding for files
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = true,
            file_ignore_patterns = {
              "DS_Store",
              "thumbs.db",
              ".history",
              ".git",
              ".vscode",
              "node_modules",
            },
          },
        },
      }
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Find Files' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch [G]rep' })
    end,
  },

  -- neotree file sidebar/popup
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        filesystem = {
          -- replace netrw with neo-tree in current window
          hijack_netrw_behavior = "open_current",
          filtered_items = {
            -- show hidden files by default
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = {
              -- "node_modules",
            },
            never_show = {
              ".DS_Store",
              "thumbs.db",
              ".history",
            },
          },
        },
      })
      -- for revealing the Neotree to the left
      vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal float<CR>', {})
      vim.keymap.set('n', '<C-b>', ':Neotree filesystem reveal right<CR>', {})
    end,
  },

  -- neotree file icons
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").get_icon(filename, extension, options)
    end,
  },

  -- auto adjust tabstop to current file
  { "tpope/vim-sleuth" },

  -- git commands inside nvim
  { "tpope/vim-fugitive" },

  -- extension for fugitive.vim
  { "tpope/vim-rhubarb" },

  -- keymappings menu
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = 200,
    },
    config = function()
      local wk = require("which-key")
      wk.add({
        { "<leader>c", group = "[C]ode" },
        { "<leader>d", group = "[D]ocument" },
        { "<leader>g", group = "[G]it" },
        { "<leader>h", group = "Git [H]unk" },
        { "<leader>r", group = "[R]ename" },
        { "<leader>s", group = "[S]earch" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>w", group = "[W]orkspace" },
      })
      wk.add({
        { "<leader>", group = "VISUAL <leader>", mode = "v" },
      })
    end,
  },

  -- ident guides on blank lines
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  -- highlight todo, notes in comments
  { 
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { 
      signs = false,
      keywords = {
        TODO = { color = "info" },
      },
      colors = {
        info = { "#ffa500" },
      },
    },
  },
  
  -- use wakatime for time tracking projects
  { 'wakatime/vim-wakatime', lazy = false },

  -- comment lines out using `gc` for inline or `gb` for block 
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        toggler = { line = 'gc' },
        opleader = { line = 'gc' },
        -- set commentstring for c/cpp to use `//`
        pre_hook = function(ctx)
          local ft = vim.bo.filetype
          if ft == "c" or ft == "cpp" then
            return "// %s"
          end
        end,
      })
    end,
  },

  -- auto cd to root of git project
  {
    "notjedi/nvim-rooter.lua",
    config = function()
      require("nvim-rooter").setup({
        -- only change root when manually triggered
        manual = true,
        -- only treat .git as root marker
        patterns = { ".git" },
        -- use lcd instead of cd to change directory only for current window
        cd_command = "lcd",
      })
    end,
  },
  
  -- zen mode
  {
    "folke/zen-mode.nvim",
    opts = {
        window = {
            backdrop = 0.1,
            width = 0.20 * 4,
            height = 0.18 * 4,
            options = {
                signcolumn = "no",
                number = false,
                relativenumber = false,
                cursorline = false,
                cursorcolumn = false,
                foldcolumn = "0",
                list = false,
            },
        },
        plugins = {
            options = {
                enabled = true,
                ruler = false,
                showcmd = false,
                laststatus = 0,
            },
            twilight = { enabled = true },
            gitsigns = { enabled = false },
            tmux = { enabled = true },
            todo = { enabled = false },
        },
        on_open = function(win)
        end,
        on_close = function()
        end,
    }
  },
	
	-- TODO:quick navigation
	-- {
	--     "ggandor/leap.nvim",
	--     config = function()
	-- 	    require("leap").create_default_mappings()
	--     end
	-- },

	-- TODO: obsidian in nvim
	-- {
	--     "epwalsh/obsidian.nvim",
	--     config = function()
	--         require("obsidian").setup({
	--             -- set directory of Obsidian vault
	--             dir = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/personal",
	--         })
	--     end,
	-- },

  -- markdown preview
  -- needs to run `:call mkdp#util#install()`
  {
    "iamcco/markdown-preview.nvim",
    -- lazy load markdown preview only for markdown files
    lazy = false,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- render markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { "markdown" },
  },

  -- LLM integration with dingllm.nvim
  -- {
  --   'yacineMTB/dingllm.nvim',
  --   dependencies = { 'nvim-lua/plenary.nvim' },
  --   config = function()
  --     local system_prompt =
  --       'You should replace the code that you are sent, only following the comments. Do not talk at all. Only output valid code. Do not provide any backticks that surround the code. Never ever output backticks like this ```. Any comment that is asking you for something should be removed after you satisfy them. Other comments should left alone. Do not output backticks'
  --     local helpful_prompt = 'You are a helpful assistant. What I have sent are my notes so far.'
  --     local dingllm = require 'dingllm'

  --     -- function to handle openrouter api responses
  --     local function handle_open_router_spec_data(data_stream)
  --       local success, json = pcall(vim.json.decode, data_stream)
  --       if success then
  --         if json.choices and json.choices[1] and json.choices[1].text then
  --           local content = json.choices[1].text
  --           if content then
  --             dingllm.write_string_at_cursor(content)
  --           end
  --         end
  --       else
  --         print("non json " .. data_stream)
  --       end
  --     end

  --     -- custom function for openrouter api requests
  --     local function custom_make_openai_spec_curl_args(opts, prompt)
  --       local url = opts.url
  --       local api_key = opts.api_key_name and os.getenv(opts.api_key_name)
  --       local data = {
  --         prompt = prompt,
  --         model = opts.model,
  --         temperature = 0.7,
  --         stream = true,
  --       }
  --       local args = { '-N', '-X', 'POST', '-H', 'Content-Type: application/json', '-d', vim.json.encode(data) }
  --       if api_key then
  --         table.insert(args, '-H')
  --         table.insert(args, 'Authorization: Bearer ' .. api_key)
  --       end
  --       table.insert(args, url)
  --       return args
  --     end

  --     -- openrouter llm functions
  --     local function openrouter_help()
  --       dingllm.invoke_llm_and_stream_into_editor({
  --         url = 'https://openrouter.ai/api/v1/chat/completions',
  --         model = 'deepseek/deepseek-chat-v3-0324:free',
  --         api_key_name = 'OPENROUTER_API_KEY',
  --         system_prompt = helpful_prompt,
  --         replace = false,
  --       }, custom_make_openai_spec_curl_args, handle_open_router_spec_data)
  --     end

  --     local function openrouter_replace()
  --       dingllm.invoke_llm_and_stream_into_editor({
  --         url = 'https://openrouter.ai/api/v1/chat/completions',
  --         model = 'deepseek/deepseek-chat-v3-0324:free',
  --         api_key_name = 'OPENROUTER_API_KEY',
  --         system_prompt = system_prompt,
  --         replace = true,
  --       }, custom_make_openai_spec_curl_args, handle_open_router_spec_data)
  --     end
      
  --     -- keymaps for llm functions for openrouter
  --     vim.keymap.set({ 'n', 'v' }, '<leader>oi', openrouter_replace, { desc = 'LLM replace with llm' })
  --     vim.keymap.set({ 'n', 'v' }, '<leader>oI', openrouter_help, { desc = 'LLM help with llm' })
  --   end,
  -- },

  -- github copilot
  {
    "github/copilot.vim",
  },
	
	-- snippet manager
	-- NOTE: must run `pip3 install pynvim`
	-- TODO: fix UltiSnips (main cause of initial insert mode lag)
	-- {
	-- 	"SirVer/ultisnips",
	-- 	dependencies = {
	-- 		"quangnguyen30192/cmp-nvim-ultisnips",
	-- 	},
	-- 	config = function()
	-- 		-- set snippets directory
	-- 		vim.g.UltiSnipsSnippetDirectories = { "UltiSnips", "${HOME}/.config/nvim/UltiSnips/" }
	-- 		vim.g["UltiSnipsSnippetDirectories"] = { "~/.config/nvim/UltiSnips" }
	-- 		vim.g["UltiSnipsExpandTrigger"] = "<tab>"
	-- 		vim.g["UltiSnipsJumpForwardTrigger"] = "<tab>"
	-- 		vim.g["UltiSnipsJumpBackwardTrigger"] = "<s-tab>"
	-- 	end,
	-- },

  -- lua snippet manager and template library (not using lua snippets for now)
  -- {
  --   "L3MON4D3/LuaSnip",
  --   -- lazy load snippets only when entering insert mode
  --   event = "InsertEnter",
  --   dependencies = {
  --     "rafamadriz/friendly-snippets",
  --     "saadparwaiz1/cmp_luasnip",
  --   },
  -- },
  
  -- TODO: Figure out if want to use Blink or nvim-cmp for LSP completions 
  -- LSP code and snippets completion (using Blink)
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "1.*",
    opts = {
      keymap = { preset = "enter" },
  
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      completion = {
        documentation = { auto_show = false },
        menu = {
          border = "rounded",
        }
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      signature = { enabled = true },
    },
    opts_extend = { "sources.default" }
  },

  -- -- LSP code and snippets completion (not using nvim-cmp for now)
  -- {
  --   "hrsh7th/nvim-cmp",
  --   -- lazy load completion only when entering insert mode
  --   event = "InsertEnter",
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-path",
  --     -- "saadparwaiz1/cmp_luasnip",
  --   },
  --   config = function()
  --     -- lua snippet manager
  --     local cmp = require("cmp")
  --     -- local luasnip = require("luasnip")
      
  --     -- require("luasnip.loaders.from_vscode").lazy_load()
      
  --     cmp.setup({
  --       -- snippet = {
  --       --   expand = function(args) luasnip.lsp_expand(args.body) end,
  --       -- },
  --       mapping = cmp.mapping.preset.insert({
  --         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  --         ["<C-f>"] = cmp.mapping.scroll_docs(4),
  --         ["<C-n>"] = cmp.mapping.select_next_item(),
  --         ["<C-p>"] = cmp.mapping.select_prev_item(),
  --         ["<C-Space>"] = cmp.mapping.complete({}),
  --         ["<CR>"] = cmp.mapping.confirm({
  --           behavior = cmp.ConfirmBehavior.Replace,
  --           select = true,
  --         }),
  --         ["<Tab>"] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.select_next_item()
  --           -- elseif luasnip.expand_or_locally_jumpable() then
  --           --   luasnip.expand_or_jump()
  --           else
  --             fallback()
  --           end
  --         end, { "i", "s" }),
  --         ["<S-Tab>"] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.select_prev_item()
  --           -- elseif luasnip.locally_jumpable(-1) then
  --           --   luasnip.jump(-1)
  --           else
  --             fallback()
  --           end
  --         end, { "i", "s" }),
  --       }),
  --       -- enable paths completion
  --       sources = cmp.config.sources({
  --         { name = "nvim_lsp", max_item_count = 10 },
  --         -- { name = "luasnip", max_item_count = 5 },
  --         { name = "path", max_item_count = 5 },
  --       }),
  --     })
  --   end,
  -- },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    -- lazy load LSP only when opening a file with LSP support
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- LSP manager
      { "williamboman/mason.nvim", lazy = false, opts = {} },
      -- LSP extension for lua api
      "williamboman/mason-lspconfig.nvim",
      -- TODO: disabled nvim-cmp for now, using Blink instead
      -- "hrsh7th/cmp-nvim-lsp",
      "saghen/blink.cmp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      -- TODO: disable nvim-cmp for now, using Blink instead
      -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- set LSP servers
      local servers = {
        -- set python, c/cpp, lua, js/ts, html, css, rust, bash, json
        pyright = {},
        clangd = {},
        lua_ls = {
          settings = { Lua = { diagnostics = { globals = { 'vim' } } } },
        },
        ts_ls = {},
        html = {},
        cssls = {},
        gopls = {},
        zls = {},
        rust_analyzer = {},
        bashls = {},
        jsonls = {},
      }

      -- setup mason to install all servers
      require("mason-lspconfig").setup {
        ensure_installed = vim.tbl_keys(servers),
        handlers = {
          function(server_name)
            lspconfig[server_name].setup {
              capabilities = capabilities,
              on_attach = function(_, bufnr)
                local nmap = function(keys, func, desc)
                  vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
                end
                nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                nmap("K", vim.lsp.buf.hover, "Hover Documentation")
                nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
                nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
                nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
                nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
                nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
              end,
            }
          end,
        },
      }
    end,
  },

  -- set autoformatting
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    event = { "BufWritePre" },
    opts = {
      formatters_by_ft = {
        python = { "ruff" },
        cpp = { "clang_format" },
        c = { "clang_format" },
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        -- go = { "gofmt" },
        rust = { "rustfmt" },
        -- bash = { "shfmt" },
        -- disable markdown
        markdown = {},
      },
      format_on_save = {
        timeout_ms = 500,
        -- use only conform formatters, not LSP
        lsp_fallback = false,
      },
      formatters = {
        ruff = {
          command = "ruff",
          args = { "format", "--config", vim.fn.expand("~/dotfiles/common/langs/ruff.toml"), "--stdin-filename", "$FILENAME", "-" },
        },
        clang_format = {
          command = "clang-format",
          args = { "--style=file:" .. vim.fn.expand("~/dotfiles/common/langs/clang-format") },
          stdin = true,
          fallback_style = "LLVM",
        },
        stylua = { command = "stylua" },
        prettier = { command = "prettier", args = { "--write", "$FILENAME" } },
      },
    },
  },

  -- set treesitter for better syntax highlighting
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
}, {
  -- added perf settings for lazy.nvim
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-------------------------------------------------------------------------------
-- Global Mappings
-------------------------------------------------------------------------------

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
-- remap for word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- global diagnostic keymaps
-- see `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
-- disable telescope default mappings
require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  },
})
-- enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")
-- telescope mappings
vim.keymap.set("n", "<Space><Space>", require("telescope.builtin").find_files, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recent opened files" })
vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
-- NOTE: must run `install ripgrep`
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
