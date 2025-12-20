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
      local fn = vim.fn

      if fn.getbufvar(buf, "&filetype") == "harpoon" then
        return false
      end
      return true
    end,
    write_all_buffers = false,
    noautocmd = false,
    debounce_delay = 1000,
  },
}
