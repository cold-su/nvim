<div align="center">

<h1>Neovim</h1>

<p>A compact, batteries-included modern Neovim configuration</p>

<p>
  <img src="https://img.shields.io/badge/Neovim-%3E%3D%200.11-57A143?style=flat-square&logo=neovim&logoColor=white" alt="Neovim >= 0.11">
  <img src="https://img.shields.io/badge/Lua-2C2D72?style=flat-square&logo=lua&logoColor=white" alt="Lua">
  <img src="https://img.shields.io/badge/Plugin_Manager-lazy.nvim-7E57C2?style=flat-square" alt="lazy.nvim">
  <img src="https://img.shields.io/badge/Platform-Linux-FCC624?style=flat-square&logo=linux&logoColor=black" alt="Linux">
</p>

<p><strong>English</strong> / <a href="README.md">中文</a></p>

<p>
  <a href="#features">Features</a> ·
  <a href="#installation">Installation</a> ·
  <a href="#lsp">LSP</a> ·
  <a href="#keymaps">Keymaps</a> ·
  <a href="#plugins">Plugins</a>
</p>

</div>

---

<a id="features"></a>

## ✨ Features

- Plugin management and lazy loading with `lazy.nvim`
- Native Neovim LSP with on-demand Mason installation by filetype
- `blink.cmp` completion from LSP, paths, snippets, buffers, Ripgrep, command/search history, and a custom dictionary
- Automatic Tree-sitter parser installation with custom syntax highlights
- Biome and LSP formatting, including automatic Go import organization
- Floating file tree, FZF search, Git hunks, floating terminal, and Markdown preview/rendering
- Custom statusline, folds, gradient floating borders, snippets, and filetype behavior

## 📦 Requirements

- Latest stable Neovim (`>= 0.11` recommended)
- `git`
- A Nerd Font is recommended
- Search and preview tools: `ripgrep`, `fd`, `bat`
- Node.js and npm for several LSP servers and building Markdown Preview
- Optional runtimes used by `F5`: `node`, `ts-node`, `python`, `go`, `bash`, `lua`, `javac`, `gcc`, `google-chrome-stable`
- Optional Python provider: export the `PYTHON` environment variable

```bash
export PYTHON="$(command -v python3)"
```

> [!TIP]
> LSP servers, Biome, and Tree-sitter parsers are installed automatically when a matching filetype is opened.

<a id="installation"></a>

## 🚀 Installation

> [!WARNING]
> Back up your existing `~/.config/nvim` first.

```bash
git clone https://github.com/yaocccc/nvim ~/.config/nvim
nvim
```

The first launch bootstraps `lazy.nvim` and installs plugins. After changing `lua/plugins/`, run:

```vim
:Lazy sync
```

Useful maintenance commands:

```vim
:Lazy          " Plugin manager
:Mason         " LSP and tool manager
:TSUpdate      " Update parsers
:StartupTime   " Profile startup time
```

## 🗂️ Structure

```text
.
├── init.lua                 # Entrypoint
├── lua/
│   ├── options.lua          # Options, autocmds, and folds
│   ├── keymap.lua           # Global keymaps
│   ├── lazyinit.lua         # lazy.nvim bootstrap
│   ├── lspinit.lua          # Automatic LSP installation and activation
│   ├── blink-cmp-history.lua
│   ├── plugins/             # Plugin specs
│   └── ui/                  # Highlights and gradient borders
├── lsp/                     # Native LSP server configs
├── ftplugin/                # Filetype-specific behavior
├── snippets/                # VS Code-style snippets
├── word.txt                 # blink.cmp custom completion dictionary
└── lazy-lock.json           # Plugin lockfile
```

<a id="lsp"></a>

## 🔧 LSP and Formatting

| Filetypes | LSP Server | Formatting |
| --- | --- | --- |
| Lua | `lua_ls` | LSP fallback |
| Solidity | `solidity_ls` | LSP fallback |
| JavaScript, TypeScript, React | `vtsls`, `tailwindcss` | Biome |
| Vue | `vue_ls`, `vtsls`, `tailwindcss` | LSP, format on save |
| HTML | `html`, `tailwindcss` | LSP fallback |
| CSS, SCSS, Less | `cssls`, `tailwindcss` | LSP fallback |
| JSON, JSONC | `jsonls` | Biome |
| Go, go.mod, go.work, templates | `gopls` | Organize imports and format on save |
| sh, Bash, Zsh | `bashls` | LSP fallback |

Biome is auto-installed for JavaScript, TypeScript, and JSON/JSONC. Tailwind LSP resolves a project only when `tailwind.config.*` exists.

### LSP Keymaps

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `gd` | Go to definition |
| Normal | `gD` | Go to declaration |
| Normal | `gy` | Go to type definition |
| Normal | `gi` | Go to implementation |
| Normal | `gr` | Finder for references, definitions, and implementations |
| Normal | `K` | Hover documentation |
| Normal, Visual | `ga` | Code Action |
| Normal | `F2` | Rename |
| Normal | `Ctrl-e` | Buffer diagnostics |
| Normal | `\e` | Workspace diagnostics |
| Visual | `=` | Format selection |

Diagnostics open in a floating window on `CursorHold`. LSP semantic tokens are disabled to preserve the custom highlight scheme.

<a id="keymaps"></a>

## ⌨️ Global Keymaps

### General Editing

| Mode | Key | Action |
| --- | --- | --- |
| Normal, Visual | `;` | Open the command line (`:`) |
| Normal | `,` | Replay the macro in register `q` |
| Normal | `\` | Clear search highlights |
| Normal | `Enter` | Clear highlight when on a match; otherwise act as Enter |
| Normal | `+` / `_` | Increment / decrement number |
| Normal | `Backspace` | Replace the current word |
| Insert | `Ctrl-h` | Delete back to the start of the word |
| Normal, Insert | `Ctrl-j` | Split at the next comma |
| Normal, Visual | `Ctrl-s` | Interactive substitute |
| Normal, Visual | `S` | Smart save with directory creation and sudo support |
| Normal | `Q` | Force quit |
| Normal | `R` | Reload the current file |
| Normal | `W` | Close the current buffer |
| Normal | `x` | Delete a character without replacing the clipboard |
| Visual | `Backspace`, `x`, `c` | Delete or change without replacing the clipboard |
| Visual | `p`, `P` | Paste while preserving the original register |
| Visual | `<`, `Shift-Tab` | Indent left and keep the selection |
| Visual | `>`, `Tab` | Indent right and keep the selection |
| Normal, Insert, Visual | `Alt-Up` / `Alt-Down` | Move a line or selection |
| Normal | `Alt-a` | Select all |
| Normal, Insert | `Ctrl-u` | Clear the current line |
| Normal | `Space` | Cycle first column, first nonblank character, and EOL |
| Normal, Visual | `0` | Jump to matching pair |
| Visual | `t` / `T` | Convert snake/camel case; `T` capitalizes the first letter |
| Insert | `(` `[` `{` `"` `'` `` ` `` | Auto-pair delimiters and quotes |
| Insert | `Backspace` | Delete paired delimiters or quotes |

In command-line mode, `Ctrl-a` / `Ctrl-e` jump to the beginning/end, while `Up` / `Down` browse history.

### Selection and Movement

| Mode | Key | Action |
| --- | --- | --- |
| Normal, Insert, Visual | `Shift-Up` / `Shift-Down` | Extend the selection vertically |
| Normal, Insert, Visual | `Ctrl-Shift-Up` / `Ctrl-Shift-Down` | Move 10 lines |
| Normal, Insert, Visual | `Ctrl-Shift-Left` / `Ctrl-Shift-Right` | Jump to line start / end |
| Visual | `v` / `V` | Expand / shrink the selection |

### Windows, Buffers, and Folds

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `sv` / `sp` | Vertical / horizontal split |
| Normal | `sc` / `so` | Close current / other windows |
| Normal | `s` + Arrow | Focus a directional window |
| Normal | `Ctrl-Space` | Cycle windows |
| Normal | `s=` | Equalize window sizes |
| Normal | `Alt-,` / `Alt-.` | Shrink / enlarge the window |
| Normal | `ss` | Next buffer |
| Normal, Insert, Visual | `Alt-Left` / `Alt-Right` | Previous / next buffer |
| Normal | `-` | Toggle a fold, or create a paragraph fold when none exists |
| Visual | `-` | Fold the selection |
| Normal | `\w` | Toggle wrapping |
| Normal | `tt` | Open a 10-line terminal split below |

Manual folds and undo history persist under `cache/`. Cursor position and views are restored when files reopen.

## 🔍 Search, Completion, and AI

### FZF-Lua

| Key | Action |
| --- | --- |
| `Ctrl-p` | Project files |
| `Ctrl-a` | Live grep |
| `Ctrl-b` | Buffer list |
| `Ctrl-l` | Current-buffer lines |
| `Ctrl-g` | Git status files |
| `Ctrl-h` | Old files in the current directory |

Searches are rooted at the `$PWD` from which Neovim was started.

### Blink.cmp

| Mode | Key | Action |
| --- | --- | --- |
| Insert | `Tab` | Select next item, trigger completion, or jump to the next snippet stop |
| Insert | `Up` / `Down` | Previous / next item |
| Insert | `Enter` | Accept completion |
| Insert | `Ctrl-y` | Select and accept |
| Insert | `Ctrl-e` | Cancel completion |
| Insert | `Ctrl-k` | Toggle completion and documentation |
| Command-line | `Tab` | Show, insert, or accept completion |

Sources: `lsp`, `path`, `snippets`, `buffer`, `ripgrep`, `datword` (`word.txt`), command history, and search history.

### GitHub Copilot

| Mode | Key | Action |
| --- | --- | --- |
| Insert | `Right` | Accept a suggestion, or move right if none is visible |
| Insert | `Ctrl-Up` / `Ctrl-Down` | Previous / next suggestion |

## 🌲 File Tree, Git, and Terminal

### Nvim Tree

Press `T` to open the centered floating tree. Its initial root is `$PWD`.

| In tree | Action |
| --- | --- |
| `a` / `A` | Create |
| `r` | Rename |
| `Left` | Close directory |
| `Right` / `Enter` | Open node |
| `Backspace` | Parent directory |
| `P` | Change root to the selected node |
| `Esc` | Close the tree |
| `(` / `)` | Previous / next Git change |
| `<` / `>` | Previous / next diagnostic |
| `?` | Help |

Copy, cut, paste, delete, filtering, and other actions retain Nvim Tree's default mappings.

### Gitsigns

| Key | Action |
| --- | --- |
| `(` / `)` | Previous / next hunk |
| `C` | Preview the current hunk |
| `\g` | Diff the current file |

### Floaterm and Quick Run

| Mode | Key | Action |
| --- | --- | --- |
| Normal, Terminal | `Ctrl-t` | Toggle the floating terminal |
| Normal, Insert, Terminal | `F5` | Save and run the current file |

`F5` supports JavaScript, TypeScript, HTML, Python, Go, shell, Lua, Java, C, and Markdown. Narrow windows use a bottom terminal; wide windows use a centered float.

## 📝 Markdown and Filetype Enhancements

### Markdown

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `Enter` | Toggle the current task between `[ ]` / `[x]`, then Enter |
| Normal | Double-click | Toggle a task and save |
| Visual | `B` / `I` | Bold / italic |
| Visual | `T` | Turn into a task |
| Visual | `` ` `` | Inline code |
| Visual | `C` | Fenced code block |
| Normal | `F5` | Browser preview |
| Normal | `F6` | Toggle in-editor Markdown rendering |

Markdown uses two-space indentation and highlights task start dates (`S:YYYY-MM-DD`), deadlines (`D:YYYY-MM-DD`), today's deadline, and deadlines in the next two days.

### Other Filetypes

- Go: run `source.organizeImports` before save; Visual `D` wraps with `/** ... */`.
- TypeScript: Visual `D` adds a documentation comment; Visual `T` wraps in `try/catch`.
- Vue: Visual `D` wraps with `<!-- ... -->`.
- Snippets cover general, TypeScript/JavaScript/Vue, Go, HTML, Markdown, SQL, Vim, systemd, and desktop files.

<a id="plugins"></a>

## 🧩 Additional Plugins

| Plugin | Purpose |
| --- | --- |
| [yaocccc/visual-multi.nvim](https://github.com/yaocccc/visual-multi.nvim) | Multiple cursors |
| [yaocccc/babel.nvim](https://github.com/yaocccc/babel.nvim) | Translate the current word or selection into Chinese with `mm` |
| [yaocccc/vim-comment](https://github.com/yaocccc/vim-comment) | Normal `??` for line comments; Visual `/` for line and `?` for block comments |
| [yaocccc/vim-surround](https://github.com/yaocccc/vim-surround) | Add, change, and delete surroundings |
| [yaocccc/vim-echo](https://github.com/yaocccc/vim-echo) | Insert `console.log` for JS/TS/Vue with Visual `C` |
| [yaocccc/vim-fcitx2en](https://github.com/yaocccc/vim-fcitx2en) | Switch to English input on InsertLeave |
| [yaocccc/nvim-lines.lua](https://github.com/yaocccc/nvim-lines.lua) | Statusline and tabline |
| [yaocccc/nvim-foldsign](https://github.com/yaocccc/nvim-foldsign) | Fold signs in the sign column |
| [Mr-LLLLL/interestingwords.nvim](https://github.com/Mr-LLLLL/interestingwords.nvim) | Highlight the current word with `ff`; clear all with `FF` |
| [uga-rosa/ccc.nvim](https://github.com/uga-rosa/ccc.nvim) | Color picker with `:CccPick`; color highlighting with `:CccHighlighterEnable` |
| [nvimdev/indentmini.nvim](https://github.com/nvimdev/indentmini.nvim) | Indent guides |
| [yianwillis/vimcdoc](https://github.com/yianwillis/vimcdoc) | Chinese help documentation |

### Common Multi-Cursor Keymaps

| Key | Action |
| --- | --- |
| `Ctrl-n` | Find and add the next match |
| `Ctrl-d` | Add all matches |
| `Ctrl-Up` / `Ctrl-Down` | Add a cursor above / below |
| `Ctrl-x` | Add a cursor at the current character |
| `Ctrl-w` | Add by word |
| `Ctrl-Left` / `Ctrl-Right` | Start or extend a selection |
| `Tab` | Toggle extend mode |
| `q` | Remove the current region |
| `Esc` | Clear multiple cursors |

---

## 📄 License

This is a personal configuration; feel free to learn from it, fork it, and adapt it.
