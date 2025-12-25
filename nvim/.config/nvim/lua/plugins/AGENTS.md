# Nvim Plugin Naming Conventions

Rules for organizing plugin files in `lua/plugins/`.

## Prefixes

| Prefix    | Purpose                   | Example                                      |
| --------- | ------------------------- | -------------------------------------------- |
| `extend-` | Customize existing plugin | `extend-mini-files.lua`, `extend-snacks.lua` |
| _(none)_  | New standalone plugins    | `nvim-spider.lua`, `guess-indent.lua`        |

## Special Files

- `disabled.lua` - Disables unwanted plugins
- `example.lua` - LazyVim template (reference only)

## Adding New Plugins

1. **Extend existing**: Create `extend-<plugin>.lua` with opts overrides
2. **New plugin**: Create `<plugin-name>.lua` with full spec
