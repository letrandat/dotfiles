return {
  "okuuva/auto-save.nvim",
  event = { "InsertLeave", "TextChanged" },
  opts = {
    enabled = true,
    trigger_events = {
      immediate_save = { "BufLeave", "FocusLost" },
      defer_save = { "InsertLeave", "TextChanged" },
      cancel_deferred_save = { "InsertEnter" },
    },
    condition = function(buf)
      -- Exclude harpoon buffers
      local fn = vim.fn
      if fn.getbufvar(buf, "&filetype") == "harpoon" then
        return false
      end

      -- Exclude claudecode diff buffers by buffer name patterns
      local bufname = vim.api.nvim_buf_get_name(buf)
      if bufname:match("%(proposed%)") or bufname:match("%(NEW FILE %- proposed%)") or bufname:match("%(New%)") then
        return false
      end

      -- Exclude by buffer variables (claudecode sets these)
      if
        vim.b[buf].claudecode_diff_tab_name
        or vim.b[buf].claudecode_diff_new_win
        or vim.b[buf].claudecode_diff_target_win
      then
        return false
      end

      -- Exclude by buffer type (claudecode diff buffers use "acwrite")
      local buftype = fn.getbufvar(buf, "&buftype")
      if buftype == "acwrite" then
        return false
      end

      return true -- Safe to auto-save
    end,
    write_all_buffers = false,
    noautocmd = false,
    debounce_delay = 1000,
  },
}
