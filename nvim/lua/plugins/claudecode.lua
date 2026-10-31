-- Claude Code en ventana flotante (estilo lazygit).
-- El extra lazyvim.plugins.extras.ai.claudecode define el grupo <leader>a; aquí solo se ajusta.
local toggle_key = "<C-,>"

return {
  {
    "coder/claudecode.nvim",
    opts = {
      terminal = {
        provider = "snacks",
        snacks_win_opts = {
          position = "float",
          width = 0.9,
          height = 0.9,
          border = "rounded",
          keys = {
            -- ocultar sin matar la sesión (Esc se deja para Claude: interrumpe la respuesta)
            claude_hide = {
              toggle_key,
              function(self)
                self:hide()
              end,
              mode = { "t", "n" },
              desc = "Hide",
            },
          },
        },
      },
    },
    keys = {
      { toggle_key, "<cmd>ClaudeCodeFocus<cr>", desc = "Claude Code", mode = { "n", "x" } },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    },
  },
}
