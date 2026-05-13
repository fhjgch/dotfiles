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
          ["<Leader>mp"] = { ":MarkdownPreview<CR>", desc = "Markdown preview" },
          ["<Leader>ms"] = { ":MarkdownPreviewStop<CR>", desc = "Markdown preview stop" },
          ["<Leader>mt"] = { ":MarkdownPreviewToggle<CR>", desc = "Markdown preview toggle" },
        },
      },
    },
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
