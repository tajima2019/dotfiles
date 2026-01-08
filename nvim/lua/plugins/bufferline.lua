-- 開いているファイルのタブを表示する
return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  keys = {
    -- <Shift> + l で次のタブへ, <Shift> + h で前のタブへ移動
    { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",   desc = "Next Buffer" },
    { "<S-l>",      "<cmd>BufferLineCyclePrev<cr>",   desc = "Prev Buffer" },
    -- <Space>co で今見ているタブ以外を全部閉じる(Close Others)
    { "<leader>co", "<cmd>BufferLineCloseOthers<cr>", desc = "Close Other Buffers" },
    opts = {
      options = {
        mode = "buffers",
        separator_style = "slant",
        always_show_bufferline = true,
      },
    },
  },
}
