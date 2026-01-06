-- ファイルエクスプローラー
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      -- <Space>e でツリーを開閉する
      { "<leader>e", ":Neotree toggle<CR>", desc = "Toggle Explorer" },
    },
    opts = {
      window = { width = 30 },
      filesystem = {
        filtered_items = { visible = true }, -- 隠しファイルも設定
      },
    },
  },
}

