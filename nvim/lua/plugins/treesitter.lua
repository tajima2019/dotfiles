-- シンタックスハイライト
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.config").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go", "javascript", "html" },
        auto_install = true,
        highlight = {
          enable = true,
        },
      })
    end,
  },
}

