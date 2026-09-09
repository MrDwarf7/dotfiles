# Adding a custom tree-sitter parser to nvim

How to wire up a tree-sitter grammar that **isn't** in nvim-treesitter's
parser registry — e.g. one you're developing yourself, or one that exists
upstream but hasn't been added to `nvim-treesitter/lua/nvim-treesitter/parsers.lua`
yet. Worked example throughout: [`tree-sitter-txtar`](https://github.com/FollowTheProcess/tree-sitter-txtar).

If the grammar you want _is_ in nvim-treesitter's registry, don't use this —
just add its name to `lua/lang_tables.lua` and let `:TSUpdate` handle it.
Check first:

```sh
DATA="$(nvim --headless -c "lua print(vim.fn.stdpath('data'))" -c q 2>&1)"
grep -n "^  <lang> = {" "$DATA/lazy/nvim-treesitter/lua/nvim-treesitter/parsers.lua"
```

A match means it's already known to nvim-treesitter and none of this is
needed.

## Why this is needed at all

nvim-treesitter (the rewrite/`main` branch) ships a **static Lua table** of
known parsers (`lua/nvim-treesitter/parsers.lua`). There is no supported hook
in that version for registering a local/custom parser into it — so anything
not already in that table cannot be installed via `ts.install()`, and adding
its name to `lang_tables.lua`'s `ts_ensure_installed()` list will just error.

The fix is to skip nvim-treesitter's install pipeline entirely and do by hand
what it would have done: compile the grammar, drop the compiled `.so` and its
query files into the same runtime directories nvim-treesitter itself reads
from, then tell nvim to detect the filetype and start treesitter on it
manually.

## Step 0 — find your _real_ `stdpath('data')` first

Don't assume `~/.local/share/nvim`. If `XDG_DATA_HOME` is customized (common
in dotfiles setups), the actual parser/query directories live elsewhere, and
copying files to the XDG default will silently do nothing.

```sh
nvim --headless -c "lua print(vim.fn.stdpath('data'))" -c q 2>&1
```

(`print()` in `--headless` mode writes to stderr, not stdout — the `2>&1` is
required, not decorative. Without it, a `$(...)` capture silently gets an
empty string.)

Everything below writes into `<stdpath-data>/site/parser` and
`<stdpath-data>/site/queries/<lang>/` — confirm that's actually on your
runtimepath:

```sh
nvim --headless -c "lua print(vim.o.runtimepath)" -c q 2>&1 | tr ',' '\n' | grep '/site$'
```

(This bit me during the txtar setup: `~/.local/share/nvim/site/parser` had a
pile of parsers in it from some prior/stale setup, which made it _look_
correct. The live one was `~/.local/data/nvim/site/parser`, from
`XDG_DATA_HOME=~/.local/data`. Always verify with the command above instead
of trusting what looks like the right directory.)

## Step 1 — build the parser

In the grammar's repo (needs `grammar.js`; `src/parser.c` may already be
checked in):

```sh
cd /path/to/tree-sitter-<lang>

# Only if grammar.js has changed since parser.c was last generated.
# Check `git status` / `jj status` afterwards — regenerating can rewrite the
# vendored src/tree_sitter/*.h runtime headers as a no-op version bump even
# when nothing grammar-related changed. If that's all that changed, revert it
# (git checkout / jj restore) rather than committing pure noise.
tree-sitter generate

tree-sitter build -o <lang>.so
```

`*.so` / `*.dylib` are gitignored in essentially every tree-sitter grammar
repo's template, so building in-place is safe and won't dirty the repo.

## Step 2 — install the compiled parser + queries

```sh
DATA="$(nvim --headless -c "lua print(vim.fn.stdpath('data'))" -c q 2>&1)"

cp <lang>.so "$DATA/site/parser/<lang>.so"

mkdir -p "$DATA/site/queries/<lang>"
cp queries/*.scm "$DATA/site/queries/<lang>/"
```

The grammar repo's `queries/` directory typically has `highlights.scm`,
`injections.scm`, `locals.scm`, etc. — copy whatever it ships.

## Step 3 — filetype detection

If nvim doesn't already recognize the extension, add an `ftdetect` file (this
is the standard, decoupled nvim mechanism — auto-sourced, no need to touch
any existing config file):

`~/.config/nvim/ftdetect/<lang>.lua`:

```lua
vim.filetype.add({
  extension = {
    <ext> = "<lang>",
  },
})
```

**txtar example** (`~/.config/nvim/ftdetect/txtar.lua`):

```lua
vim.filetype.add({
  extension = {
    txtar = "txtar",
  },
})
```

## Step 4 — start treesitter for the filetype

Since the parser isn't in nvim-treesitter's registry, `nvim-treesitter`
itself won't attach highlighting for it. Start it natively via a `FileType`
autocmd instead. This repo's `lua/config/autocmds.lua` already had a commented
template for exactly this case — instantiate it per-language:

```lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "<lang>" },
  callback = function(ctx)
    vim.treesitter.start(ctx.buf, "<lang>")
  end,
})
```

**txtar example**, as added to `~/.config/nvim/lua/config/autocmds.lua`:

```lua
-- txtar isn't in nvim-treesitter's parser registry, so it can't go through
-- ts.install()/lang_tables.lua; the parser.so + queries are placed manually
-- under stdpath('data')/site, and highlighting is started natively here.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "txtar" },
  callback = function(ctx)
    vim.treesitter.start(ctx.buf, "txtar")
  end,
})
```

## Step 5 — verify

Headless smoke test — parses a real file and dumps the syntax tree, so you
don't need to eyeball highlighting in an interactive session to know it
worked:

```sh
nvim --headless /path/to/sample.<ext> -c "lua
local ft = vim.bo.filetype
local ok, parser = pcall(vim.treesitter.get_parser, 0)
local out = {'filetype=' .. ft, 'parser_ok=' .. tostring(ok)}
if ok then
  out[#out+1] = 'root=' .. parser:parse()[1]:root():sexpr():sub(1, 200)
else
  out[#out+1] = 'err=' .. tostring(parser)
end
vim.fn.writefile(out, '/tmp/ts_check.txt')
" -c "qa!"
cat /tmp/ts_check.txt
```

Expect `filetype=<lang>`, `parser_ok=true`, and an s-expr tree — not an error
about the parser failing to load (usually a wrong install path, see Step 0)
or filetype staying blank (Step 3 not wired up).

## Full command sequence (copy/paste, txtar as template)

```sh
cd ~/Documents/.local-build/tree-sitter-txtar
tree-sitter generate       # then check nothing but noise changed; revert if so
tree-sitter build -o txtar.so

DATA="$(nvim --headless -c "lua print(vim.fn.stdpath('data'))" -c q 2>&1)"
cp txtar.so "$DATA/site/parser/txtar.so"
mkdir -p "$DATA/site/queries/txtar"
cp queries/*.scm "$DATA/site/queries/txtar/"
```

Then create `ftdetect/txtar.lua` and add the `autocmds.lua` block, both shown
above.

## Gotchas / things learned doing this

- **`print()` in `--headless` mode writes to stderr, not stdout.** Every
  `$(nvim --headless -c "lua print(...)" -c q)` capture needs `2>&1` or it
  silently captures an empty string — this bit the first draft of this doc.
- **Verify `stdpath('data')`, don't assume it.** See Step 0 — an XDG override
  makes the "obvious" `~/.local/share/nvim` path wrong.
- **`tree-sitter generate` can produce noise-only diffs.** If `parser.c` was
  already checked in and up to date with `grammar.js`, regenerating may only
  touch vendored runtime headers (`src/tree_sitter/array.h` etc.) as a CLI
  version bump, with no actual grammar change. Diff before committing
  anything from that step.
- **`nvim-treesitter`'s parser list is a static table in this version** —
  there's no `parser_configs`-style merge point to register a custom/local
  parser into it. Don't add unregistered languages to
  `lang_tables.lua`'s `ts_ensure_installed()`; it'll error trying to resolve
  an install source that doesn't exist.
- **nvim-treesitter never persists a cloned source repo.** Its own install
  flow downloads a tarball into a temp cache dir, compiles it, copies the
  resulting `.so`/queries into `stdpath('data')/site`, then deletes the
  source. So there's no "correct" place to relocate a local grammar repo to —
  keeping it wherever you're developing it and copying only the build
  artifacts into `site/` mirrors exactly what nvim-treesitter itself does.
- **`*.so`/`*.dylib` are gitignored** in the standard tree-sitter grammar
  template, so `tree-sitter build -o <lang>.so` in the repo root is a safe,
  untracked build step.
