-- Override molten-nvim configuration to fix statusline loading issue
return {
  "benlubas/molten-nvim",
  enabled = false, -- Disabled in favor of jupynium
  keys = {
    -- Run cell
    { "<Leader><CR>", function() vim.cmd("normal! vip") vim.cmd("MoltenEvaluateVisual") vim.cmd("MoltenShowOutput") vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false) end, desc = "Run cell", mode = "n" },
    { "<Leader><CR>", ":<C-u>MoltenEvaluateVisual<CR>gv", desc = "Run selection", mode = "v" },
    -- Cell navigation
    { "]c", function() vim.fn.search("# %%", "W") end, desc = "Next cell", mode = { "n", "v" } },
    { "[c", function() vim.fn.search("# %%", "bW") end, desc = "Previous cell", mode = { "n", "v" } },
    -- Output control
    { "<Leader>mo", "<Cmd>MoltenShowOutput<CR>", desc = "Show output" },
    { "<Leader>mh", "<Cmd>MoltenHideOutput<CR>", desc = "Hide output" },
  },
  dependencies = {
    {
      "rebelot/heirline.nvim",
      optional = true,
      opts = function(_, opts)
        local utils = require "heirline.utils"
        local molten_component = {
          provider = function()
            local ok, molten_status = pcall(require, "molten.status")
            if not ok then return "" end

            local init_status = molten_status.initialized()
            local kernel_status = molten_status.kernels()
            local info = (init_status ~= "" and init_status .. ": ") .. kernel_status
            return info ~= "" and info or ""
          end,
          condition = function()
            local ok, molten_status = pcall(require, "molten.status")
            if not ok then return false end
            return molten_status.initialized() ~= ""
          end,
          padding = { left = 1, right = 1 },
          hl = function()
            local theme_hl = utils.get_highlight "@comment.note"
            return {
              bg = theme_hl.bg,
              fg = theme_hl.fg,
            }
          end,
        }

        -- Remove any existing molten components and add ours
        local spacer = { provider = " " }
        table.insert(opts.statusline, #opts.statusline, spacer)
        table.insert(opts.statusline, #opts.statusline, molten_component)
      end,
    },
  },
}
