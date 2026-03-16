### Context

- Using the multiplexer using Unix domains, exactly as described in the docs: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains.
- Using the technique suggested by @wez in #3648  to use a user var called `IS_NVIM` (set/unset by Neovim on entry/exit) to control if a key should be relayed to Neovim
- Using the [`wezterm-move`](https://github.com/letieu/wezterm-move.nvim) plugin in Neovim with a simplified version of the suggested WezTerm Lua code in my WezTerm setup, using a user var instead of the process name to determine if a key should be relayed to Neovim instead of being consumed by WezTerm

### The problem

Using the IS_NVIM user var in my WezTerm Lua code to control if keys should be relayed to Neovim generally works like a charm. But if I have Neovim running when detaching from the multiplexer (or just quit WezTerm), and subsequently attach again, the IS_NVIM user var is no longer set, meaning that the keystrokes I want to pass through to Neovim are not passed through.

I have tried using the `WEZTERM_PROG` user var set by shell integration, and that exposes the same problem, confirmed by logging the value from my WezTerm Lua code.

This indicates - as suggested by @wez in [this comment](https://github.com/wez/wezterm/discussions/3648#discussioncomment-10103702) - user vars are not synchronized on attach after a detach.
