# Nvim Plugin Naming Conventions

Rules for organizing plugin files in `lua/plugins/`.

## Prefixes

| Prefix    | Purpose                   | Example                                      |
| --------- | ------------------------- | -------------------------------------------- |
| `extras-` | LazyVim extras imports    | `extras-lang.lua`, `extras-util.lua`         |
| `extend-` | Customize existing plugin | `extend-mini-files.lua`, `extend-snacks.lua` |
| _(none)_  | New standalone plugins    | `nvim-spider.lua`, `guess-indent.lua`        |

## Special Files

- `disabled.lua` - Disables unwanted plugins
- `example.lua` - LazyVim template (reference only)

## Adding New Plugins

1. **LazyVim extra**: Add to `extras-*.lua` with `{ import = "lazyvim.plugins.extras..." }`
2. **Extend existing**: Create `extend-<plugin>.lua` with opts overrides
3. **New plugin**: Create `<plugin-name>.lua` with full spec
