-- config from kickstart.nvim, jonhoo, mitchellh, sumitdotml, willccbb
vim.loader.enable()

-- disable netrw (required by nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable unused providers for fast startup
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

vim.opt.timeoutlen = 300

-------------------------------------------------------------------------------
-- General settings
-------------------------------------------------------------------------------

-- hide tabline
vim.opt.showtabline = 0

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
vim.opt.relativenumber = true
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
vim.opt.writebackup = false
-- when opening a file with a command (like :e),
-- don't suggest files like these
vim.opt.wildignore = ".hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site,*.DS_Store"
-- set search/replace to case-insensitive
vim.opt.ignorecase = true
-- unless uppercase in search terms
vim.opt.smartcase = true
-- better scroll and cursor input
vim.opt.mouse = "a"
vim.opt.cursorline = true
-- set ruler to 100 characters
vim.opt.colorcolumn = "100"
-- set term colors
vim.opt.termguicolors = true
-- indent new lines in same column
vim.opt.breakindent = true
-- show mode under status line
vim.opt.showmode = false
-- show last exec command in status line
vim.opt.laststatus = 3
-- set highlight all when searching
vim.opt.hlsearch = true
-- sign column for git
vim.opt.signcolumn   = "yes:1"
-- set left status column
vim.opt.statuscolumn = "%=%{v:virtnum==0?(v:relnum?v:relnum:v:lnum):''} %s"
-- stop terminal beep
vim.opt.vb = true
-- set scroll padding
vim.opt.scrolloff = 999
vim.opt.conceallevel = 0
-- set diff options
vim.opt.diffopt:append("iwhite,algorithm:histogram,indent-heuristic")
-- set spell check
vim.opt.spelllang = "en_us"
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "gitcommit", "text", "rst" },
  callback = function() vim.opt_local.spell = true end,
})
-- diagonal lines for empty diff slots
vim.opt.fillchars:append({ diff = "╱" })
vim.diagnostic.config({
  signs = false,
  virtual_text = { prefix = "●", spacing = 4, severity = { min = vim.diagnostic.severity.ERROR } },
})

-------------------------------------------------------------------------------
-- Hotkeys
-------------------------------------------------------------------------------

-- close buffer, fall back to nvim-tree
vim.keymap.set("n", "<leader>w", function()
  local bufs = #vim.fn.getbufinfo({ buflisted = 1 })
  vim.cmd(bufs > 1 and "bp | bd#" or "NvimTreeFocus | bd#")
end)
-- Ctrl+j as Esc
vim.keymap.set("i", "<C-j>", "<Esc>")
vim.keymap.set("n", "<C-j>", "<Esc>")
vim.keymap.set("v", "<C-j>", "<Esc>")
vim.keymap.set("o", "<C-j>", "<Esc>")
-- j+k as Esc
vim.keymap.set("i", "jk", "<Esc>")
-- clipboard via OSC 52
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}
vim.keymap.set("n", "<leader>v", '"+p')
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
-- cycle buffers
vim.keymap.set("n", "<S-h>", ":bp<cr>")
vim.keymap.set("n", "<S-l>", ":bn<cr>")
-- make j and k move by visual line, not actual line, when text is soft-wrapped
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
-- center cursor after half-page scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- center cursor when jumping between search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-------------------------------------------------------------------------------
-- Color palette + theme
-------------------------------------------------------------------------------

local C = {
  -- syntax
  amber  = "#E8C060",
  blue   = "#8DB4D4",
  green  = "#96CCAA",
  white  = "#D4D4D4",
  grey   = "#6A6A69",
  red    = "#C47070",
  purple = "#B48ECC",
  dimmed = "#4E4E4E",
  -- ui
  bg          = "#161616",
  surface     = "#1E1E1E",
  border      = "#3A3A3A",
  selection   = "#264F78",
  cursor_line = "#1F2A31",
  cursor_nr   = "#83BBF0",
  overlay     = "#242424",
  statusbar_z = "#1F2C36",
  match_bg    = "#6B6870",
  separator   = "#7D7D7D",
  root_fg     = "#6E6E6E",
  -- search
  search_bg    = "#773800",
  incsearch_bg = "#4B5632",
  -- diff
  diff_add     = "#1e4d20",
  diff_del     = "#4d1e1e",
  diff_add_chr = "#2d6e30",
  diff_del_chr = "#6e2d2d",
}

local function setup_theme()
  vim.cmd("highlight clear")
  vim.g.colors_name = "mytheme"
  local h = function(g, o) vim.api.nvim_set_hl(0, g, o) end

  -- ui
  h("Normal",       { fg = C.white, bg = C.bg })
  h("NormalNC",     { bg = C.bg })
  h("NormalFloat",  { bg = C.surface })
  h("FloatBorder",  { fg = C.border,    bg = C.surface })
  h("EndOfBuffer",  { fg = C.bg,        bg = C.bg })
  h("SignColumn",   { bg = C.bg })
  h("LineNr",       { fg = C.dimmed,    bg = C.surface })
  h("CursorLine",     { bg = C.cursor_line, underline = false })
  h("CursorLineNr",   { fg = C.cursor_nr, bg = C.cursor_line })
  h("CursorLineSign", { bg = C.cursor_line })
  h("Visual",       { bg = C.selection })
  h("WinSeparator",  { fg = C.separator, bg = C.bg })
  h("ColorColumn",   { bg = C.border })
  h("MatchParen",   { bg = C.match_bg,  bold = false })
  h("Search",       { bg = C.search_bg })
  h("IncSearch",    { bg = C.incsearch_bg })
  h("CurSearch",    { bg = C.incsearch_bg })
  h("Title",        { fg = C.white,     bold = false })
  h("StatusLine",   { fg = C.white,     bg = C.surface })
  h("StatusLineNC", { fg = C.grey,      bg = C.surface })
  h("ErrorMsg",     { fg = C.red })
  h("WarningMsg",   { fg = C.amber })
  h("MoreMsg",      { fg = C.green })
  h("Question",     { fg = C.green })

  -- nvim-tree
  h("NvimTreeNormal",           { fg = C.white,     bg = C.bg })
  h("NvimTreeEndOfBuffer",      { fg = C.bg,        bg = C.bg })
  h("NvimTreeWinSeparator",     { fg = C.separator, bg = C.bg })
  h("NvimTreeRootFolder",       { fg = C.root_fg,   bold = true })
  h("NvimTreeFolderName",       { fg = C.blue })
  h("NvimTreeOpenedFolderName", { fg = C.blue,  bold = true })
  h("NvimTreeEmptyFolderName",  { fg = C.blue })
  h("NvimTreeSymlink",          { fg = C.white, underline = false })
  h("NvimTreeSymlinkFolderName",{ fg = C.blue,  underline = false })
  h("NvimTreeSpecialFile",      { fg = C.white, bold = true })
  h("NvimTreeArrowClosed",      { fg = C.separator })
  h("NvimTreeArrowOpen",        { fg = C.separator })
  h("NvimTreeIndentMarker",     { fg = C.separator })
  for name, color in pairs({
    Dirty = C.amber, Staged = C.green, New     = C.green,
    Renamed = C.green, Deleted = C.red, Merge  = C.red, Ignored = C.dimmed,
  }) do
    h("NvimTreeGit" .. name .. "Icon",     { fg = color })
    h("NvimTreeGitFile" .. name .. "HL",   { fg = color })
    h("NvimTreeGitFolder" .. name .. "HL", { fg = color })
  end

  -- filetype overrides
  h("tomlTable",             { fg = C.white, bold = false })
  h("yamlAnchor",            { fg = C.amber })
  h("yamlAlias",             { fg = C.amber })
  h("yamlMerge",             { fg = C.blue })
  h("yamlBlockMappingKey",   { fg = C.blue })
  h("yamlKeyValueDelimiter", { fg = C.blue })
  h("yamlBlockSequenceEntry",{ fg = C.amber })
  h("yamlPlainScalar",       { fg = C.white })
  h("yamlBool",              { fg = C.amber })
  h("yamlInteger",           { fg = C.amber })
  h("yamlFloat",             { fg = C.amber })
  h("@label.bash",           { fg = C.green })

  -- diff
  h("DiffAdd",    { bg = C.diff_add })
  h("DiffDelete", { bg = C.diff_del })
  h("DiffChange", { bg = C.diff_del })
  h("DiffText",   { bg = C.diff_del_chr })
  h("@diff.plus",    { bg = C.diff_add })
  h("@diff.minus",   { bg = C.diff_del })
  h("@diff.delta",   { fg = C.blue })
  h("diffAdded",     { bg = C.diff_add })
  h("diffRemoved",   { bg = C.diff_del })
  h("diffChanged",   { bg = C.diff_del })
  h("diffFile",      { fg = C.amber })
  h("diffIndexLine", { fg = C.amber })
  h("diffOldFile",   { fg = C.amber })
  h("diffNewFile",   { fg = C.amber })
  h("diffLine",      { fg = C.blue })

  -- syntax
  for _, spec in ipairs({
    { fg = C.amber, groups = {
      "Keyword", "Statement", "Conditional", "Repeat", "Exception", "Include",
      "PreProc", "Define", "Macro", "PreCondit", "Boolean", "Number", "Float", "Constant",
      "@keyword", "@keyword.function", "@keyword.return", "@keyword.conditional",
      "@keyword.repeat", "@keyword.import", "@keyword.exception", "@keyword.coroutine",
      "@keyword.operator", "@keyword.storage", "@keyword.modifier", "@keyword.directive",
      "@boolean", "@number", "@number.float",
      "@constant", "@constant.macro",
      "@attribute", "@attribute.builtin", "@preproc",
      "@label",
      "@tag", "@tag.attribute", "@tag.delimiter",
      "@markup.link", "@markup.link.label", "@markup.link.url",
    }},
    { fg = C.blue, groups = {
      "Function",
      "@function", "@function.call", "@function.method", "@function.method.call",
      "@function.builtin", "@constructor",
      "@module", "@module.builtin", "@namespace", "@property",
      "@punctuation.special",
      "@variable.builtin", "@type.builtin", "@constant.builtin",
      "@markup.raw", "@markup.raw.block",
      "@markup.list", "@markup.list.checked", "@markup.list.unchecked",
      "@markup.quote",
    }},
    { fg = C.green, groups = {
      "String", "Character",
      "@string", "@string.escape", "@string.regexp",
      "@string.special", "@string.special.path", "@string.special.symbol",
      "@character", "@character.special",
    }},
    { fg = C.white, groups = {
      "Identifier", "StorageClass", "Structure", "Typedef",
      "Special", "SpecialChar", "Tag", "Delimiter", "SpecialComment", "Operator", "Type",
      "@variable", "@variable.member",
      "@variable.parameter", "@variable.parameter.builtin",
      "@type", "@type.qualifier", "@type.definition",
      "@operator",
      "@punctuation.bracket", "@punctuation.delimiter",
      "@markup.strong", "@markup.italic", "@markup.strikethrough",
    }},
    { fg = C.grey,  italic = false, groups = { "Comment", "@comment", "@comment.documentation", "@comment.warning", "@comment.todo", "@comment.note", "@comment.error" }},
  }) do
    local hl = { fg = spec.fg }
    if spec.italic ~= nil then hl.italic = spec.italic end
    for _, g in ipairs(spec.groups) do h(g, hl) end
  end

  -- gitsigns
  h("GitSignsAdd",    { fg = C.green,  bg = C.bg })
  h("GitSignsChange", { fg = C.amber,  bg = C.bg })
  h("GitSignsDelete", { fg = C.red,    bg = C.bg })

  -- blink completion
  h("BlinkCmpMenu",              { bg = C.overlay })
  h("BlinkCmpMenuBorder",        { fg = C.overlay, bg = C.overlay })
  h("BlinkCmpMenuSelection",     { bg = C.cursor_line })
  h("BlinkCmpItemAbbrMatch",     { fg = C.amber })
  h("BlinkCmpItemAbbrMatchFuzzy",{ fg = C.amber })
  h("BlinkCmpDoc",               { bg = C.surface })
  h("BlinkCmpDocBorder",         { fg = C.border, bg = C.surface })

  -- telescope
  h("TelescopeNormal",          { fg = C.white,  bg = C.surface })
  h("TelescopeBorder",          { fg = C.surface, bg = C.surface })
  h("TelescopeSelection",       { bg = C.cursor_line })
  h("TelescopeSelectionCaret",  { fg = C.blue,   bg = C.cursor_line })
  h("TelescopeMatching",        { fg = C.amber })
  h("TelescopePromptNormal",    { fg = C.white,  bg = C.surface })
  h("TelescopePromptBorder",    { fg = C.surface, bg = C.surface })
  h("TelescopePromptPrefix",    { fg = C.blue,   bg = C.surface })
  h("TelescopeResultsNormal",   { fg = C.white,  bg = C.surface })
  h("TelescopePreviewNormal",   { fg = C.white,  bg = C.surface })

  -- winbar
  h("WinBar",   { fg = C.grey,   bg = C.bg })
  h("WinBarNC", { fg = C.dimmed, bg = C.bg })

  -- diffview
  h("DiffviewNormal",              { fg = C.white,  bg = C.bg })
  h("DiffviewWinSeparator",        { fg = C.border, bg = C.bg })
  h("DiffviewCursorLine",          { bg = C.cursor_line })
  h("DiffviewFilePanelTitle",      { fg = C.blue })
  h("DiffviewFilePanelCounter",    { fg = C.dimmed })
  h("DiffviewFilePanelFileName",   { fg = C.white })
  h("DiffviewFilePanelPath",       { fg = C.dimmed })
  h("DiffviewFilePanelInsertions", { fg = C.green })
  h("DiffviewFilePanelDeletions",  { fg = C.red })
  h("DiffviewStatusAdded",         { fg = C.green })
  h("DiffviewStatusModified",      { fg = C.amber })
  h("DiffviewStatusRenamed",       { fg = C.blue })
  h("DiffviewStatusDeleted",       { fg = C.red })
  h("DiffviewStatusUntracked",     { fg = C.green })
  h("DiffviewFolderName",          { fg = C.blue })
  h("DiffviewFolderSign",          { fg = C.dimmed })
  h("DiffviewFilePanelRootPath",   { fg = C.dimmed })
  h("DiffviewReference",           { fg = C.amber })
  h("DiffviewDim1",                { fg = C.dimmed })
  h("DiffviewDiffAdd",           { bg = C.diff_add })
  h("DiffviewDiffDelete",        { fg = C.dimmed, bg = C.surface })
  h("DiffviewDiffAddAsDelete",   { fg = C.dimmed, bg = C.surface })
  h("DiffviewDiffDeleteDim",     { fg = C.dimmed, bg = C.surface })
  h("DiffviewDiffChange",        { bg = C.diff_del })
  h("DiffviewDiffAddText",       { bg = C.diff_add_chr })
  h("DiffviewDiffDeleteText",    { bg = C.diff_del_chr })
  h("DiffviewDiffStatAdditions", { fg = C.green })
  h("DiffviewDiffStatDeletions", { fg = C.red })
  h("DiffviewEmptyLineNr",         { fg = C.dimmed })

  -- todo-comments
  h("TodoBgTODO", { fg = C.bg, bg = C.amber, bold = false })
  h("TodoBgFIX",  { fg = C.bg, bg = C.red,   bold = false })
  h("TodoBgHACK", { fg = C.bg, bg = C.amber, bold = false })
  h("TodoBgWARN", { fg = C.bg, bg = C.amber, bold = false })
  h("TodoBgNOTE", { fg = C.bg, bg = C.blue,  bold = false })

  -- markdown
  h("@markup.heading",    { fg = C.blue })
  h("@markup.raw.inline", { fg = C.white, bg = C.surface })

  -- lsp semantic token overrides (treesitter takes priority)
  for _, t in ipairs({ "namespace", "variable", "parameter", "property", "enumMember",
    "function", "method", "class", "interface", "type", "typeParameter",
    "decorator", "macro", "label", "comment", "string", "number", "regexp", "operator" }) do
    h("@lsp.type." .. t, {})
  end
  for _, m in ipairs({ "declaration", "definition", "readonly", "static", "deprecated",
    "abstract", "async", "modification", "documentation", "defaultLibrary" }) do
    h("@lsp.mod." .. m, {})
  end

  -- diagnostics
  for _, d in ipairs({
    { color = C.red,   name = "Error" }, { color = C.amber, name = "Warn" },
    { color = C.blue,  name = "Info"  }, { color = C.green, name = "Hint" },
  }) do
    h("Diagnostic" .. d.name,            { fg = d.color })
    h("DiagnosticUnderline" .. d.name,   { fg = d.color, underline = true })
    h("DiagnosticVirtualText" .. d.name, { fg = d.color })
    h("DiagnosticFloating" .. d.name,    { fg = d.color })
  end

end

setup_theme()
vim.api.nvim_create_autocmd("ColorScheme", { callback = setup_theme })

-- diffview autocmds
local function diffview_is_open()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local ft = vim.bo[vim.api.nvim_win_get_buf(win)].filetype
    if ft == "DiffviewFiles" or ft == "DiffviewFileHistory" then return true end
  end
  return false
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "DiffviewFiles", "DiffviewFileHistory" },
  callback = function()
    vim.diagnostic.enable(false)
    vim.schedule(function()
      vim.opt_local.statuscolumn   = ""
      vim.opt_local.signcolumn     = "no"
      vim.opt_local.number         = false
      vim.opt_local.relativenumber = false
      vim.opt_local.winfixbuf      = true
      vim.opt_local.winbar         = "%=Source Control%="
    end)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "NvimTree" },
  callback = function()
    vim.opt_local.statuscolumn = ""
    vim.opt_local.number         = false
    vim.opt_local.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("WinClosed", {
  callback = function()
    vim.schedule(function()
      if not diffview_is_open() then
        vim.diagnostic.enable(true)
      end
    end)
  end,
})

vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    if diffview_is_open() then vim.cmd("DiffviewClose") end
  end,
})

-------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------

-- telescope builder helper
local tb = function(fn) return function() require("telescope.builtin")[fn]() end end

-- grab lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        update_focused_file = { enable = true },
        filters = { git_ignored = false },
        git = { enable = true, show_on_dirs = true, show_on_open_dirs = true },
        renderer = {
          root_folder_label = ":t",
          symlink_destination = false,
          highlight_git = "none",
          icons = {
            git_placement = "after",
            show = { git = true },
            glyphs = { git = {
              unstaged = "M", staged = "A", unmerged = "C",
              renamed  = "R", deleted = "D", untracked = "U", ignored = "",
            }},
          },
        },
      })
      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
    end,
  },

  -- status bar
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local function mode_theme(color)
        return {
          a = { fg = C.bg,    bg = color },
          b = { fg = C.grey,  bg = C.surface },
          c = { fg = C.white, bg = C.bg },
          z = { fg = C.white, bg = C.statusbar_z },
        }
      end
      return {
        options = {
          theme = {
            normal   = mode_theme(C.blue),
            insert   = mode_theme(C.green),
            command  = mode_theme(C.amber),
            visual   = mode_theme(C.purple),
            inactive = { a = { fg = C.grey, bg = C.surface }, c = { fg = C.grey, bg = C.bg } },
          },
          section_separators   = { left = "\u{E0B0}", right = "\u{E0B2}" },
          component_separators = { left = "", right = "" },
          globalstatus = true,
          refresh = { statusline = 500 },
        },
        sections = {
          lualine_a = { { "mode", fmt = function(s) return s:sub(1, 1) end } },
          lualine_b = { "branch" },
          lualine_c = {
            { "filename", path = 1, symbols = { modified = " *", readonly = " [-]", unnamed = "[No Name]" },
              cond = function()
                local ft = vim.bo.filetype
                return ft ~= "NvimTree" and ft ~= "DiffviewFiles" and ft ~= "DiffviewFileHistory" and ft ~= "grug-far"
              end,
            },
            { "diagnostics", diagnostics_color = {
              error = { fg = C.red }, warn = { fg = C.amber }, info = { fg = C.blue }, hint = { fg = C.green },
            }},
          },
          lualine_x = {},
          lualine_y = { "searchcount", "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {}, lualine_b = {},
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "location" },
          lualine_y = {}, lualine_z = {},
        },
      }
    end,
  },

  -- fuzzy finding for files
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = { "Telescope" },
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    config = function(_, opts)
      require("telescope").setup(opts)
      pcall(require("telescope").load_extension, "fzf")
    end,
    opts = {
      defaults = {
        prompt_title  = false,
        results_title = false,
        preview_title = false,
        path_display  = { "truncate" },
        mappings = { i = { ["<C-u>"] = false, ["<C-d>"] = false } },
        preview = { treesitter = false },
      },
      pickers = {
        find_files = {
          hidden = true,
          file_ignore_patterns = {
            "DS_Store", "thumbs.db", ".history", ".git", ".vscode", "node_modules",
          },
        },
      },
    },
  },

  -- auto adjust tabstop to current file
  { "tpope/vim-sleuth", event = "BufReadPost" },

  -- git change indicators
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = { add = { text = "▎" }, change = { text = "▎" }, delete = { text = "▎" } },
    },
  },

  -- git commands inside nvim
  { "tpope/vim-fugitive", cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit" } },

  -- git diff viewer
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>",        desc = "[G]it [D]iff" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "[G]it [H]istory" },
    },
    opts = {
      show_help_hints = false,
      signs           = { fold_closed = "+", fold_open = "-", section_sign = "" },
      file_panel = {
        listing_style = "list",
        win_config    = { position = "left", width = 35 },
      },
      hooks = {
        diff_buf_win_enter = function(_, winid)
          vim.wo[winid].cursorline = false
        end,
      },
    },
  },

  -- search and replace
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      { "<leader>sr", "<cmd>GrugFar<cr>", desc = "[S]earch and [R]eplace" },
    },
    opts = {
      icons                    = { enabled = true, fileIconsProvider = false },
      spinnerStates            = false,
      showCompactInputs        = true,
      showInputsTopPadding     = false,
      showInputsBottomPadding  = false,
      helpLine                 = { enabled = false },
      showEngineInfo           = false,
      resultsSeparatorLineChar = "─",
    },
  },

  -- extension for fugitive.vim
  { "tpope/vim-rhubarb", cmd = { "GBrowse" }, dependencies = { "tpope/vim-fugitive" } },

  -- keymappings menu
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = 200,
      win = { border = "none" },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.add({
        { "<leader>c", group = "[C]ode" },
        { "<leader>d", group = "[D]ocument" },
        { "<leader>g", group = "[G]it" },
        { "<leader>h", group = "Git [H]unk" },
        { "<leader>r", group = "[R]ename" },
        { "<leader>s", group = "[S]earch" },
        { "<leader>t", group = "[T]oggle" },
      })
      wk.add({
        { "<leader>", group = "VISUAL <leader>", mode = "v" },
      })
    end,
  },

  -- indent guide
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      indent  = { char = "│" },
      scope   = { enabled = false },
      exclude = {
        filetypes = { "diff", "git", "gitcommit", "fugitive", "fugitiveblame" },
      },
    },
  },

  -- highlight todo/fix/note keywords in comments
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({
        signs = false,
        highlight = { multiline = false, keyword = "bg", after = "" },
        keywords = {
          FIX  = { icon = "", color = C.red,   alt = { "FIXME", "BUG", "ERROR" } },
          TODO = { icon = "", color = C.amber },
          HACK = { icon = "", color = C.amber },
          WARN = { icon = "", color = C.amber, alt = { "WARNING" } },
          NOTE = { icon = "", color = C.blue,  alt = { "INFO" } },
        },
      })
    end,
  },

  -- use wakatime for time tracking projects
  { "wakatime/vim-wakatime", lazy = false },

  -- navigate between tmux panes and nvim splits with ctrl+hjkl
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft", "TmuxNavigateDown",
      "TmuxNavigateUp",   "TmuxNavigateRight", "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  -- vim practice game
  {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood",
  },

  -- github copilot
  { "github/copilot.vim", event = "InsertEnter" },

  -- LSP completion
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    opts = {
      keymap = { preset = "enter" },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        documentation = { auto_show = false },
        menu = { border = "none" },
      },
      sources = {
        default = { "lsp", "path", "buffer" },
      },
      signature = { enabled = true },
    },
    opts_extend = { "sources.default" },
  },

  -- auto-install formatters and linters via mason
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = { "ruff", "stylua", "prettier", "clang-format", "taplo", "shfmt", "oxlint", "shellcheck" },
      })
      vim.cmd("MasonToolsInstall")
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim", lazy = false, opts = {} },
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local servers = {
        pyright = {},
        clangd = {},
        lua_ls = {
          settings = { Lua = { diagnostics = { globals = { "vim" } } } },
        },
        ts_ls = {},
        html = {},
        cssls = {},
        gopls = {},
        zls = {},
        rust_analyzer = {},
        bashls = {},
        jsonls = {},
        yamlls = {},
        taplo = {},
        dockerls = {},
      }

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
                nmap("gd", tb("lsp_definitions"),    "[G]oto [D]efinition")
                nmap("gr", tb("lsp_references"),     "[G]oto [R]eferences")
                nmap("K",  vim.lsp.buf.hover,        "Hover Documentation")
                nmap("gI", tb("lsp_implementations"), "[G]oto [I]mplementation")
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
        yaml = { "prettier" },
        toml = { "taplo" },
        -- jsonl = { "jq", "prettier" },
        -- go = { "gofmt" },
        rust = { "rustfmt" },
        zig  = { "zigfmt" },
        bash = { "shfmt" },
        -- disable markdown
        markdown = {},
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "never",
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
        prettier = { command = "prettier", args = { "--stdin-filepath", "$FILENAME" }, stdin = true },
      },
    },
  },

  -- set treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local ensure = { "bash", "python", "lua", "javascript", "typescript", "html", "css", "json", "rust", "go", "c", "cpp", "zig", "markdown", "markdown_inline" }
      local installed = require("nvim-treesitter.config").get_installed("parsers")
      local missing = vim.tbl_filter(function(p)
        return not vim.tbl_contains(installed, p)
      end, ensure)
      if #missing > 0 then
        require("nvim-treesitter.install").install(missing)
      end
      local no_ts = { diff = true }
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          if not no_ts[vim.bo[args.buf].filetype] then
            pcall(vim.treesitter.start, args.buf)
          end
        end,
      })
    end,
  },

  -- show function/class context at top when scrolling
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      max_lines = 3,
      min_window_height = 20,
      multiline_threshold = 1,
    },
  },


}, {
  -- added perf settings for lazy.nvim
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", "matchit", "netrwPlugin",
        "tarPlugin", "tohtml", "tutor", "zipPlugin",
      },
    },
  },
  ui = { border = "rounded" },
})

-------------------------------------------------------------------------------
-- Global Mappings
-------------------------------------------------------------------------------

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
-- global diagnostic keymaps
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
-- telescope mappings
vim.keymap.set("n", "<Space><Space>", tb("find_files"), { silent = true })
vim.keymap.set("n", "<C-p>",          tb("find_files"), { silent = true })
vim.keymap.set("n", "<leader>?",      tb("oldfiles"),    { desc = "[?] Find recent opened files" })
vim.keymap.set("n", "<leader>gf",     tb("git_files"),   { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>sg",     tb("live_grep"),   { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sw",     tb("grep_string"), { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sd",     tb("diagnostics"), { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sh",     tb("help_tags"),   { desc = "[S]earch [H]elp" })
