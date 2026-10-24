local opt = vim.opt

opt.number = true             -- 顯示絕對行號
opt.relativenumber = true     -- 顯示相對行號
opt.tabstop = 4               -- Tab 鍵寬度
opt.shiftwidth = 4            -- 縮排寬度
opt.expandtab = true          -- 將 Tab 轉為空格
opt.smartindent = true        -- 智慧縮排
opt.termguicolors = true      -- 開啟 24-bit RGB 真彩色
opt.ignorecase = true         -- 搜尋忽略大小寫
opt.smartcase = true          -- 搜尋包含大寫時區分大小寫
opt.cursorline = true         -- 高亮當前行
opt.clipboard = "unnamedplus" -- 共享 Windows 系統剪貼簿