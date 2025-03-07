-- config from kickstart.nvim, jonhoo, mitchellh, sumitdotml

-- set leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-------------------------------------------------------------------------------
--
-- General settings
--
-------------------------------------------------------------------------------

-- set tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
-- faster update time
vim.opt.updatetime = 250
-- line wrap
vim.opt.wrap = true
-- great relative line numbers
vim.opt.relativenumber = false
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
vim.o.conceallevel = 1
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
--
-- Hotkeys
--
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

-------------------------------------------------------------------------------
--
-- Plugins
--
-------------------------------------------------------------------------------

-- grab lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- setup plugins
require("lazy").setup({
  -- color theme
  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   priority = 1000,
  --   config = true,
  --   config = function()
  --     require("gruvbox").setup({
  --       inverse = true,
  --       contrast = "soft",
  --       undercurl = false,
  --       underline = false,
  --       bold = false,
  --       italic = {
  --         strings = false,
  --         emphasis = false,
  --         comments = false,
  --         folds = false,
  --       },
  --       strikethrough = false,
  --       invert_signs = false,
  --       invert_tabline = false,
  --       invert_intend_guides = false,
  --     })
  --     vim.cmd("colorscheme gruvbox")
  --     vim.cmd("highlight SpellBad cterm=underline gui=underline")
  --   end,
  -- },

  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin-mocha"
    end,
  },

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
    dependencies = { "nvim-lua/plenary.nvim" },
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

  -- comment lines out using `gc` in visual mode
  -- or `gcc` in normal mode
  { "numToStr/Comment.nvim", opts = {} },

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
	
	-- TODO quick navigation
	-- {
	--     "ggandor/leap.nvim",
	--     config = function()
	-- 	    require("leap").create_default_mappings()
	--     end
	-- },

	-- TODO auto save in nvim
	-- {
	--     "okuuva/auto-save.nvim",
	--     cmd = "ASToggle",
	--     event = { "InsertLeave", "TextChanged" },
	--     opts = {
	--         debounce_delay = 3000,
	--     }
	-- },

	-- TODO obsidian in nvim
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
  {
    "iamcco/markdown-preview.nvim",
    -- lazy load markdown preview only for markdown files
    lazy = true,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
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

  -- lua snippet manager and template library
  {
    "L3MON4D3/LuaSnip",
    -- lazy load snippets only when entering insert mode
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
  },

  -- LSP code and snippets completion
  {
    "hrsh7th/nvim-cmp",
    -- lazy load completion only when entering insert mode
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "quangnguyen30192/cmp-nvim-ultisnips",
    },
    config = function()
      -- lua snippet manager
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        -- perf settings
        performance = {
          -- reduce processing frequency
          debounce = 150,
          -- limit updates per second
          throttle = 60,
          -- timeout for completion
          fetching_timeout = 200,
        },
        preselect = cmp.PreselectMode.None,
        snippet = {
          -- Required by UltiSnips
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          -- start completion after 2 chars
          keyword_length = 2,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-Space>"] = cmp.mapping.complete({}),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        -- Enable paths completion
        sources = cmp.config.sources({
          { name = "nvim_lsp", max_item_count = 10 },
          { name = "luasnip", max_item_count = 5 },
          { name = "path", max_item_count = 5 },
        }),
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    -- lazy load LSP only when opening a file with LSP support
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- LSP manager
      {
        "williamboman/mason.nvim",
        cmd = "Mason",
        config = function()
          require("mason").setup({
            ui = {
              icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
              }
            }
          })
        end
      },
      -- LSP extension for lua API
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls" },
            automatic_installation = true,
          })
        end
      },
      "folke/neodev.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")

      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end

        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				-- nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					-- nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace 
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
        nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
				-- nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
        nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
      end

      -- LSP manager setup
      require("mason").setup()

      -- Configure lua_ls as an example (add more LSPs as needed)
      lspconfig.lua_ls.setup {
        on_attach = on_attach,
      }

		-- TODO auto install LSPs
			-- require("mason-lspconfig").setup({
			--     ensure_installed = { "lua_ls", "clangd", "pyright", "tsserver", "jdtls" },
			-- })
			-- local servers = {
			--     lua_ls = {
			--         Lua = {
			--             workspace = { checkThirdParty = false },
			--             telemetry = { enable = false },
			--         },
			--     },
			--     clangd = {},
			--     pyright = {}, -- add '~/.config/pycodestyle' to disable warnings
			--     tsserver = {},
			--     jdtls = {},
			-- }
			-- C/CPP LSP
			-- lspconfig.clangd.setup {
			--     on_attach = on_attach,
			-- }
			-- Python
			-- lspconfig.pyright.setup {
			--     on_attach = on_attach,
			-- }
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
			-- local mason_lspconfig = require("mason-lspconfig")

			-- mason_lspconfig.setup_handlers({
			--     function(server_name)
			--         require("lspconfig")[server_name].setup({
			--             capabilities = capabilities,
			--             on_attach = on_attach,
			--             settings = servers[server_name],
			--         })
			--     end,
			-- })

      -- autoformatters for lua, python, c/cpp, typescript, markdown
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.lua", "*.py", "*.cpp", "*.hpp", "*.c", "*.h", "*.ts", "*.md" },
        callback = function()
          -- check if LSP is attached and able to format current buffer
          if #vim.lsp.buf_get_clients() > 0 then
            vim.lsp.buf.format({ async = false })
          else
            -- fallback to external formatters if LSP not available
            local file_ext = vim.fn.expand("%:e")
            if file_ext == "cpp" or file_ext == "hpp" or file_ext == "c" or file_ext == "h" then
              vim.cmd("silent! %!clang-format -style=file:${HOME}/Documents/config/dotfiles/config/langs/clang-format")
            elseif file_ext == "py" then
              vim.cmd("silent! %!black -q -")
            elseif file_ext == "ts" then
              vim.cmd("silent! %!prettier --write --parser typescript")
            elseif file_ext == "lua" then
              vim.cmd("silent! %!stylua -")
            elseif file_ext == "md" then
              vim.cmd("silent! %!prettier --write --parser markdown")
            end
          end
        end,
      })
    end,
  },
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
--
-- Global Mappings
--
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
