return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    ft = "markdown",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      local colors = {
        h1 = { bg = "#5c2e2e", fg = "#ff9e9e" },
        h2 = { bg = "#5c472e", fg = "#ffcd9e" },
        h3 = { bg = "#4f5c2e", fg = "#eaff9e" },
        h4 = { bg = "#2e455c", fg = "#9edaff" },
        h5 = { bg = "#3e2e5c", fg = "#c29eff" },
        h6 = { bg = "#2e5c52", fg = "#9effec" },
      }

      for i = 1, 6 do
        local color = colors["h" .. i]
        vim.api.nvim_set_hl(0, "MarkviewHeading" .. i, {
          bg = color.bg,
          fg = color.fg,
          bold = true,
        })
        vim.api.nvim_set_hl(0, "MarkviewHeading" .. i .. "Sign", {
          bg = color.bg,
          fg = color.fg,
        })
      end

      local presets = require("markview.presets")
      require("markview").setup({

        markdown = {
          enable = true,
          headings = presets.headings.glow, -- 背景色が光る
          tables = {
            enable = true,
            style = "simple",
          }
        },

        latex = {
          enable = true, -- デフォルトで有効
          -- 数式部分のハイライト設定など
          hl = "@markup.math",
        },

      })
    end
  }
}
