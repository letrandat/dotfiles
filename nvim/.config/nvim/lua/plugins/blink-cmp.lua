return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",
      -- Configure Tab to accept completion when menu is visible
      -- Otherwise use default Tab behavior
      ["<Tab>"] = {
        function(cmp)
          if cmp.is_visible() then
            return cmp.accept()
          else
            return cmp.snippet_forward()
          end
        end,
        "fallback",
      },
      ["<S-Tab>"] = {
        function(cmp)
          if cmp.is_visible() then
            return cmp.select_prev()
          else
            return cmp.snippet_backward()
          end
        end,
        "fallback",
      },
    },
    completion = {
      -- Enable ghost text (inline suggestions)
      ghost_text = {
        enabled = true,
      },
      menu = {
        -- Show completion menu automatically
        auto_show = true,
      },
    },
  },
}
