return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    ft = "markdown", -- ここを追加
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("markview").setup({
        -- ここに詳細設定を記述します
        latex = {
          enable = true, -- デフォルトで有効
          -- 数式部分のハイライト設定など
          hl = "@markup.math",
        },
      })
    end
  }
}
