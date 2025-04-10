-- init.lua

-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", 
    "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  -- Tema
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- NvimTree (explorador de arquivos)
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-tree/nvim-web-devicons" },

  -- Telescope (busca de arquivos/texto)
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- Syntax Highlighting
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- Autocomplete (sem LSP)
  { "hrsh7th/nvim-cmp" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  -- Vimwiki
  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_list = {
        {
          path = "/mnt/5f2655ff-4701-48e9-89fa-ce1b949e8d74/Wiki",
          syntax = "markdown",
          ext = ".md",
        }
      }
      vim.g.vimwiki_global_ext = 0
    end,
  },
})

-- Tema
vim.cmd.colorscheme "catppuccin-mocha"

-- NvimTree
require("nvim-tree").setup()

-- Telescope
require("telescope").setup {}

-- Treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "markdown", "html", "css", "javascript", "typescript" },
  highlight = { enable = true },
})

-- Autocomplete (nvim-cmp)
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = "luasnip" },
  },
})

-- Atalhos
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-f>", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })

