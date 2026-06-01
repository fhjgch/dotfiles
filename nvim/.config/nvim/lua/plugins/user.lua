return {
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        i = {
          ["jk"] = { "<ESC>:w<Return>", desc = "How it looks in the descriptions" },
          ["jj"] = { "<ESC>:w<Return>", desc = "How it looks in the descriptions" },
        },
        n = {
          ["gb"] = { ":bnext<CR>", desc = "Next buffer" },
          ["gB"] = { ":bprevious<CR>", desc = "Previous buffer" },
          ["<Leader>mt"] = { ":RenderMarkdown toggle<CR>", desc = "Render markdown toggle" },
        },
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown", "quarto", "asciidoc" },
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
}
