vim.g.mapleader = " "          -- 設定 Space (空格鍵) 為 Leader 鍵

local keymap = vim.keymap.set

-- 快速儲存與離開
keymap("n", "<Leader>w", ":w<CR>", { desc = "儲存檔案" })
keymap("n", "<Leader>q", ":q<CR>", { desc = "離開" })

-- 視窗分頁切換
keymap("n", "<C-h>", "<C-w>h", { desc = "移至左視窗" })
keymap("n", "<C-j>", "<C-w>j", { desc = "移至下視窗" })
keymap("n", "<C-k>", "<C-w>k", { desc = "移至上視窗" })
keymap("n", "<C-l>", "<C-w>l", { desc = "移至右視窗" })