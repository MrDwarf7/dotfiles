# Neovim Deps and requirements

**SYNTAX**

Check [tree-sitter](https://github.com/tree-sitter/tree-sitter) for full list.

**DEPENDENCIES**

- Neovim
- [Universal-ctags](https://github.com/universal-ctags/ctags) with JSON format
- [FZF](https://github.com/junegunn/fzf)
- [ripgrep](https://github.com/BurntSushi/ripgrep): ripgrep recursively searches directories for a regex pattern
- [Ripper-tags](https://github.com/tmm1/ripper-tags)
- [prettierd](https://github.com/fsouza/prettierd) for formatter.nvim install via Mason `MasonInstall prettierd`
- Needed DAP, show `lua/plugins/nvim-dap.lua` install via Mason for `node` with `MasonInstall node-debug2-adapter`
- Needed LSP, show `lua/lsp/init.lua` installed automatically with Mason
- Terminal that supports ligatures for proper representation
