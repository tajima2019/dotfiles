local opt = vim.opt

opt.number = true         -- 行番号を表示
opt.relativenumber = true -- 相対行番号を表示
opt.cursorline = true     -- カーソル行をハイライト

opt.tabstop = 2           -- タブ文字が画面上で何文字に見えるか
opt.shiftwidth = 2        -- 自動インデントなどでずらす幅
opt.expandtab = true      -- tab -> space
opt.smartindent = true    -- 改行した時、前の行に合わせて勝手に字下げする

opt.ignorecase = true     -- 検索で大文字小文字の区別なくす
opt.smartcase = true

opt.termguicolors = true            -- 24bit color
opt.clipboard:append("unnamedplus") -- クリップボード共有
opt.mouse = "a"                     -- マウス有効化

opt.encoding = "utf-8"              -- 内部文字コード
opt.fileencoding = "utf-8"          -- ファイルの文字コード
