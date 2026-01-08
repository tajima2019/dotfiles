-- LSPの設定
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- Mason(インストーラー) の設定
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "gopls", "lua_ls", "ts_ls" }, -- 自動で入れたいものを書く

        -- handlers: インストールされたLSPごとの設定をここに書く
        handlers = {
          -- デフォルト設定
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,

          -- Go言語の個別設定
          ["gopls"] = function()
            require("lspconfig").gopls.setup({
              settings = {
                gopls = {
                  analyses = { unusedparams = true },
                  staticcheck = true,
                },
              },
            })
          end,

          -- Luaの個別設定
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              settings = {
                Lua = { diagnostics = { globals = { "vim" } } },
              },
            })
          end,

          -- JS/TS用の設定を追加
          ["ts_ls"] = function()
            require("lspconfig").ts_ls.setup({})
          end,
        },
      })

      -- キーバインド設定
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          -- 定義ジャンプ(Go Definition) -> gd
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          -- 情報表示(Hover) -> K
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          -- リネーム(変数名変更) -> <Space>rn
          vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
          -- コードアクション(修正提案) -> <Space>ca
          vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
          -- 参照先一覧 -> gr
          vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
        end,
      })
    end,
  },
}
