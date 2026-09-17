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
          ["<Leader>ty"] = {
            function()
              if vim.fn.executable "yazi" == 1 then
                require("astrocore").toggle_term_cmd { cmd = "yazi", direction = "float" }
              else
                vim.notify("yazi not found", vim.log.levels.WARN)
              end
            end,
            desc = "ToggleTerm yazi",
          },
          ["<Leader>tj"] = {
            function()
              if vim.fn.executable "lazyjira" == 1 then
                require("astrocore").toggle_term_cmd { cmd = "lazyjira", direction = "float" }
              else
                vim.notify("lazyjira not found", vim.log.levels.WARN)
              end
            end,
            desc = "ToggleTerm lazyjira",
          },
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
