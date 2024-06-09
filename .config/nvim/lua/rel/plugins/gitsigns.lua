return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local gitsigns = require("gitsigns")

    gitsigns.setup({
      word_diff = true,
      current_line_blame = true,
      on_attach = function(bufnr)
        local opts = { noremap = true, silent = true }
        local keymap = vim.keymap

        opts.buffer = bufnr

        -- Staging
        opts.desc = "Stage hunk"
        keymap.set('n', '<leader>hs', gitsigns.stage_hunk, opts)
        opts.desc = "Stage buffer"
        keymap.set('n', '<leader>hS', gitsigns.stage_buffer, opts)
        opts.desc = "Stage selected"
        keymap.set('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, opts)
        -- Reset
        opts.desc = "Reset hunk"
        keymap.set('n', '<leader>hr', gitsigns.reset_hunk, opts)
        opts.desc = "Reset buffer"
        keymap.set('n', '<leader>hR', gitsigns.reset_buffer, opts)
        opts.desc = "Reset selected"
        keymap.set('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, opts)
        -- Undo
        opts.desc = "Undo stage hunk"
        keymap.set('n', '<leader>hu', gitsigns.undo_stage_hunk, opts)
        -- Preview
        opts.desc = "Preview hunk"
        keymap.set('n', '<leader>hp', gitsigns.preview_hunk, opts)
        -- Blame
        opts.desc = "Blame line"
        keymap.set('n', '<leader>hb', function() gitsigns.blame_line{full=true} end, opts)
        opts.desc = "Toggle blame current line"
        keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame, opts)
        -- Diff
        opts.desc = "Diff"
        keymap.set('n', '<leader>hd', gitsigns.diffthis, opts)
        opts.desc = "Diff latest commit"
        keymap.set('n', '<leader>hD', function() gitsigns.diffthis('~') end, opts)
        opts.desc = "Toggle deleted"
        keymap.set('n', '<leader>td', gitsigns.toggle_deleted, opts)
      end,
    })
  end
}
