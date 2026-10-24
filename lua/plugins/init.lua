-- 使用 Neovim 原生 vim.pack 宣告並下載套件
vim.pack.add({
  -- 1. 主題配色
  "https://github.com/shaunsingh/nord.nvim.git",

  -- 2. Treesitter 語法高亮
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "master" },

  -- 3. LSP 語言伺服器配置與 Mason 自動管理器
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/williamboman/mason-lspconfig.nvim",

  -- 4. Telescope 檔案搜尋與基礎依賴
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",

  -- 5. Oil.nvim (目錄檔案管理)
  "https://github.com/stevearc/oil.nvim",

  -- 6. 自動補全引擎 (nvim-cmp 體系)
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/cmp-path",
  "https://github.com/hrsh7th/cmp-buffer",
  "https://github.com/L3MON4D3/LuaSnip",
})

-------------------------------------------------------------------------------
-- 各套件初始化設定 (Configurations)
-------------------------------------------------------------------------------

-- 1. 啟用配色主題
vim.cmd[[colorscheme nord]]

-- 2. Treesitter 語法高亮設定
require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "vim", "vimdoc", "python", "javascript", "json", "html" },
  highlight = { enable = true },
  indent = { enable = true },
})

-- 3. Oil.nvim (開啟類似檔案總管的目錄編輯器)
require("oil").setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "開啟目錄管理" })

-- 4. Telescope (模糊搜尋快捷鍵)
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "搜尋檔案" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "全域搜尋文字" })

-- 5. Mason & LSP 自動化設定
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright", "ts_ls" },
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason-lspconfig").setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      capabilities = capabilities,
    })
  end,
})

-- LSP 常用功能按鍵綁定
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)      -- 跳轉到定義
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)           -- 查看文件說明
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- 變數重新命名
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- 執行 Code Action
  end,
})

-- 6. nvim-cmp 自動補全設定
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "buffer" },
  }),
})