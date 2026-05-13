return {
  "kiyoon/jupynium.nvim",
  -- No automatic build - install manually in each project venv:
  -- pip install ~/.local/share/nvim/lazy/jupynium.nvim
  dependencies = {
    "rcarriga/nvim-notify", -- optional but recommended for notifications
    "stevearc/dressing.nvim", -- optional, UI for vim.ui.input
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        if not opts.mappings then opts.mappings = {} end
        local prefix = "<Leader>j"

        -- Leader j prefix group
        opts.mappings.n[prefix] = { desc = "Jupynium" }

        -- Cell execution
        opts.mappings.n[prefix .. "r"] = { "<Cmd>JupyniumExecuteSelectedCells<CR>", desc = "Run selected cells" }
        opts.mappings.x[prefix .. "r"] = { "<Cmd>JupyniumExecuteSelectedCells<CR>", desc = "Run selected cells" }
        opts.mappings.n[prefix .. "R"] = {
          function()
            vim.cmd "JupyniumExecuteSelectedCells" -- Will need to implement run all cells manually
          end,
          desc = "Run all cells",
        }
        opts.mappings.n[prefix .. "c"] = { "<Cmd>JupyniumClearSelectedCellsOutputs<CR>", desc = "Clear cell outputs" }
        opts.mappings.x[prefix .. "c"] = { "<Cmd>JupyniumClearSelectedCellsOutputs<CR>", desc = "Clear cell outputs" }

        -- Kernel operations
        opts.mappings.n[prefix .. "k"] = { "<Cmd>JupyniumKernelHover<CR>", desc = "Kernel hover" }
        opts.mappings.n[prefix .. "K"] = { "<Cmd>JupyniumKernelRestart<CR>", desc = "Kernel restart" }
        opts.mappings.n[prefix .. "i"] = { "<Cmd>JupyniumKernelInterrupt<CR>", desc = "Kernel interrupt" }

        -- Navigation
        opts.mappings.n["]j"] = {
          "<Cmd>lua require'jupynium.textobj'.goto_next_cell_separator()<CR>",
          desc = "Next Jupynium cell",
        }
        opts.mappings.n["[j"] = {
          "<Cmd>lua require'jupynium.textobj'.goto_previous_cell_separator()<CR>",
          desc = "Previous Jupynium cell",
        }
        opts.mappings.n[prefix .. "j"] = {
          "<Cmd>lua require'jupynium.textobj'.goto_current_cell_separator()<CR>",
          desc = "Jump to current cell",
        }

        -- Notebook control
        opts.mappings.n[prefix .. "a"] = {
          "<Cmd>JupyniumStartAndAttachToServer<CR>",
          desc = "Start and attach to server",
        }
        opts.mappings.n[prefix .. "s"] = { "<Cmd>JupyniumStartSync<CR>", desc = "Start sync" }
        opts.mappings.n[prefix .. "S"] = { "<Cmd>JupyniumScrollToCell<CR>", desc = "Scroll to cell" }
        opts.mappings.n[prefix .. "d"] = { "<Cmd>JupyniumDetachFromServer<CR>", desc = "Detach from server" }
        opts.mappings.n[prefix .. "o"] = {
          "<Cmd>JupyniumToggleSelectedCellsOutputsScroll<CR>",
          desc = "Toggle output scroll",
        }

        -- Quick execution (Ctrl+Enter and Shift+Enter)
        opts.mappings.n["<C-CR>"] = { "<Cmd>JupyniumExecuteSelectedCells<CR>", desc = "Run current cell" }
        opts.mappings.n["<S-CR>"] = {
          function()
            vim.cmd "JupyniumExecuteSelectedCells"
            require("jupynium.textobj").goto_next_cell_separator()
          end,
          desc = "Run cell and move to next",
        }
      end,
    },
  },
  config = function()
    require("jupynium").setup({
      python_host = vim.g.python3_host_prog or "python3",
      default_notebook_URL = "localhost:8888/nbclassic",
      jupyter_command = "jupyter notebook",

      -- Jupynium options
      use_default_keybindings = false, -- Using custom keybindings via AstroCore
      textobjects = {
        use_default_keybindings = true, -- Keep text objects (aj, ij, etc.)
      },

      -- Automatically start Jupyter server
      auto_start_server = {
        enable = false, -- set to true if you want auto start
        file_pattern = { "*.ju.*" },
      },

      -- Automatically attach to server
      auto_attach_to_server = {
        enable = false, -- set to true if you want auto attach
        file_pattern = { "*.ju.*" },
      },

      -- Automatically sync on save
      auto_start_sync = {
        enable = false, -- set to true if you want auto sync
        file_pattern = { "*.ju.*" },
      },

      -- Scroll options
      auto_download_ipynb = true,
      auto_close_tab = true,

      -- Shortsighted mode (only sync current cell)
      shortsighted = false,
    })
  end,
}
