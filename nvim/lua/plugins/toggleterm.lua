-- ターミナル統合
return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 20,
      open_mapping = [[<C-@>]], -- Ctrl + @でターミナルを開く
      direction = "horizontal",
      float_opts = {
        border = "curved",
      },
    },
  },
}
