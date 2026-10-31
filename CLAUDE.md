# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A personal dotfiles repo living directly at `~/.config` (macOS, previously also used on NixOS/Linux). There is no build, lint, or test step. Changes take effect when the relevant program reloads its config.

Tracked configs:
- `nvim/`: a LazyVim-based Neovim config
- `ghostty/`: Ghostty terminal config
- `.zshrc` and `.p10k.zsh`: Oh My Zsh with the Powerlevel10k theme

Everything else under `~/.config` is untracked app state. `.gitignore` excludes only a few directories (`StardewValley`, `github-copilot`, `.DS_Store`), so run `git status` before committing so you don't pick up unrelated app directories by accident.

## Wiring outside this repo

- `.zshrc` and `.p10k.zsh` don't get loaded from `~/.config` automatically. They have to be symlinked into `$HOME` (for example `ln -s ~/.config/.p10k.zsh ~/.p10k.zsh`, as noted at the top of `.zshrc`). The shell config depends on Oh My Zsh at `~/.oh-my-zsh` and on the `zsh-autosuggestions` and `zsh-syntax-highlighting` plugins.
- `nvim/lua/config/lazy.lua` has **no lazy.nvim bootstrap clone**. It was removed on purpose so the same config works on NixOS, where lazy.nvim is provided externally. On a fresh machine, lazy.nvim has to already exist at `stdpath("data")/lazy/lazy.nvim`. Don't add the bootstrap back unless asked.

## Neovim architecture

- `init.lua` → `lua/config/lazy.lua` sets up lazy.nvim. It imports LazyVim core, then LazyVim language extras (typescript, json, python, rust, clangd, java), then every spec file in `lua/plugins/`.
- Language support is split across two places: LazyVim `lang` extras are enabled in `lua/config/lazy.lua`, and extra Treesitter parsers, Mason tools, and flutter-tools are added in `lua/plugins/languages.lua`. Those use `opts = function(_, opts) vim.list_extend(...)` so they extend LazyVim's defaults instead of replacing them.
- `lazyvim.json` holds extras enabled through the `:LazyExtras` UI (currently `ai.copilot`). `lua/plugins/copilot.lua` overrides that extra: it uses inline suggestions only (`copilot-cmp` disabled, accept with `<C-l>`), and Copilot is off for markdown, help, and gitcommit.
- Claude Code integration uses the LazyVim `ai.claudecode` extra (imported in `lua/config/lazy.lua`), which provides the `<leader>a` group via `coder/claudecode.nvim`. `lua/plugins/claudecode.lua` overrides it to open as a lazygit-style snacks float, with `<C-,>` to show/hide it.
- `lua/plugins/ui.lua` sets the Nightfox colorscheme with transparency (paired with Ghostty's `background-opacity`), plus customizations for lualine and noice.
- `lua/plugins/example.lua` is the stock LazyVim example. It returns `{}` early and is never loaded.
- `lazy-lock.json` pins plugin commits. Plugin updates change it, and it gets committed along with config changes.
- Lua formatting follows `nvim/stylua.toml`: 2-space indent, 120 columns. Format with `stylua nvim/`.
- Some code comments are in Spanish.

Useful checks after editing the Neovim config: `nvim --headless "+Lazy! sync" +qa` (install/update plugins and update the lockfile), and `:checkhealth` / `:Lazy` from inside Neovim.

## Theming

The terminal and editor share a theme. Ghostty uses `theme = Nightfox` and Neovim uses `nightfox`. If you change one, keep the other consistent. `ghostty/themes/catppuccin-mocha` is a leftover custom theme file that is no longer active. Reload Ghostty's config with Cmd+Shift+, (comma).
