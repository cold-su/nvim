<div align="center">

<h1>Neovim</h1>

<p>一套紧凑、开箱即用的现代 Neovim 配置</p>

<p>
  <img src="https://img.shields.io/badge/Neovim-%3E%3D%200.11-57A143?style=flat-square&logo=neovim&logoColor=white" alt="Neovim >= 0.11">
  <img src="https://img.shields.io/badge/Lua-2C2D72?style=flat-square&logo=lua&logoColor=white" alt="Lua">
  <img src="https://img.shields.io/badge/Plugin_Manager-lazy.nvim-7E57C2?style=flat-square" alt="lazy.nvim">
  <img src="https://img.shields.io/badge/Platform-Linux-FCC624?style=flat-square&logo=linux&logoColor=black" alt="Linux">
</p>

<p>
  <a href="#features">特性</a> ·
  <a href="#installation">安装</a> ·
  <a href="#lsp">LSP</a> ·
  <a href="#keymaps">键位</a> ·
  <a href="#plugins">插件</a>
</p>

</div>

---

<a id="features"></a>

## ✨ 特性

- 基于 `lazy.nvim` 的插件管理与按需加载
- 基于 Neovim 原生 API 的 LSP，按文件类型通过 Mason 自动安装
- `blink.cmp` 补全：LSP、路径、代码片段、Buffer、Ripgrep、命令/搜索历史及自定义词库
- Tree-sitter 解析器自动安装，内置自定义语法高亮
- Biome、LSP 格式化，Go 自动整理 imports
- 浮动文件树、FZF 搜索、Git hunk、浮动终端、Markdown 预览与渲染
- 自定义状态栏、折叠、渐变浮窗边框、代码片段和文件类型行为

## 📦 环境要求

- 最新稳定版 Neovim（建议 `>= 0.11`）
- `git`
- 推荐安装 Nerd Font
- 搜索与预览工具：`ripgrep`、`fd`、`bat`、`fzf`
- Node.js 与 npm：用于部分 LSP 和构建 Markdown Preview
- `tree-sitter-cli`
- `F5` 可选运行时：`node`、`ts-node`、`python`、`go`、`bash`、`lua`、`javac`、`gcc`、`google-chrome-stable`
- 可选 Python provider：设置 `PYTHON` 环境变量

```bash
export PYTHON="$(command -v python3)"
```

> [!TIP]
> LSP Server、Biome 和 Tree-sitter parser 无需手动逐个安装，首次打开对应文件时会自动安装。

<a id="installation"></a>

## 🚀 安装

> [!WARNING]
> 安装前请备份现有的 `~/.config/nvim`。

```bash
git clone https://github.com/cold-su/nvim ~/.config/nvim
nvim
```

首次启动会自动安装 `lazy.nvim` 和插件。修改 `lua/plugins/` 后执行：

```vim
:Lazy sync
```

常用维护命令：

```vim
:Lazy          " 插件管理
:Mason         " LSP/工具管理
:TSUpdate      " 更新 parser
:StartupTime   " 启动性能分析
```

## 🗂️ 目录结构

```text
.
├── init.lua                 # 配置入口
├── lua/
│   ├── options.lua          # 基础选项、autocmd、折叠
│   ├── keymap.lua           # 全局键位
│   ├── lazyinit.lua         # lazy.nvim 初始化
│   ├── lspinit.lua          # LSP 自动安装与启用
│   ├── blink-cmp-history.lua
│   ├── plugins/             # 插件配置
│   └── ui/                  # 高亮与渐变边框
├── lsp/                     # 原生 LSP Server 配置
├── ftplugin/                # 文件类型专属行为
├── snippets/                # VS Code 格式代码片段
├── word.txt                 # blink.cmp 自定义词库
└── lazy-lock.json           # 插件版本锁
```

<a id="lsp"></a>

## 🔧 LSP 与格式化

| 文件类型 | LSP Server | 格式化 |
| --- | --- | --- |
| Lua | `lua_ls` | LSP fallback |
| Solidity | `solidity_ls` | LSP fallback |
| JavaScript、TypeScript、React | `vtsls`、`tailwindcss` | Biome |
| Vue | `vue_ls`、`vtsls`、`tailwindcss` | LSP，保存时格式化 |
| HTML | `html`、`tailwindcss` | LSP fallback |
| CSS、SCSS、Less | `cssls`、`tailwindcss` | LSP fallback |
| JSON、JSONC | `jsonls` | Biome |
| Go、go.mod、go.work、templates | `gopls` | 保存时整理 imports 并格式化 |
| sh、Bash、Zsh | `bashls` | LSP fallback |

JavaScript、TypeScript、JSON/JSONC 文件会自动安装 Biome。Tailwind LSP 仅在项目存在 `tailwind.config.*` 时找到项目根目录。

### LSP 键位

| 模式 | 键 | 功能 |
| --- | --- | --- |
| Normal | `gd` | 跳转定义 |
| Normal | `gD` | 跳转声明 |
| Normal | `gy` | 跳转类型定义 |
| Normal | `gi` | 跳转实现 |
| Normal | `gr` | Finder：引用、定义与实现 |
| Normal | `K` | 悬浮文档 |
| Normal、Visual | `ga` | Code Action |
| Normal | `F2` | 重命名 |
| Normal | `Ctrl-e` | 当前 Buffer 诊断 |
| Normal | `\e` | Workspace 诊断 |
| Visual | `=` | 格式化选区 |

诊断信息会在 `CursorHold` 时以浮窗显示；LSP semantic tokens 被禁用，以保持自定义高亮一致。

<a id="keymaps"></a>

## ⌨️ 全局键位

### 基础编辑

| 模式 | 键 | 功能 |
| --- | --- | --- |
| Normal、Visual | `;` | 输入命令（`:`） |
| Normal | `,` | 执行寄存器 `q` 中的宏 |
| Normal | `\` | 清除搜索高亮 |
| Normal | `\-tab` | 将空格转换为 tab |
| Normal | `Enter` | 光标位于匹配项时清除高亮，否则正常回车 |
| Normal | `+` / `_` | 数字自增 / 自减 |
| Normal | `Backspace` | 删除当前词并进入插入 |
| Insert | `Ctrl-h` | 删除到词首 |
| Normal、Insert | `Ctrl-j` | 从下一个逗号处断行 |
| Normal、Visual | `Ctrl-s` | 交互式替换 |
| Normal、Visual | `Ctrl-s` | 智能保存：创建目录，必要时 sudo |
| Normal | `Ctrl-q` | 强制退出 |
| Normal | `R` | 重载当前文件 |
| Normal | `W` | 关闭当前 Buffer |
| Normal | `x` | 删除字符且不覆盖剪贴板 |
| Visual | `Backspace`、`x`、`c` | 删除或修改且不覆盖剪贴板 |
| Visual | `p`、`P` | 粘贴并保留原寄存器 |
| Visual | `<`、`Shift-Tab` | 左缩进并保持选区 |
| Visual | `>`、`Tab` | 右缩进并保持选区 |
| Normal、Insert、Visual | `Alt-Shift-Up` / `Alt-Shift-Down` | 上下移动行或选区 |
| Normal | `Alt-a` | 全选 |
| Normal、Insert | `Ctrl-u` | 清空当前行 |
| Normal | `Space` | 在首列、首个非空字符、行尾间跳转 |
| Normal、Visual | `0` | 匹配括号跳转 |
| Visual | `t` / `T` | 下划线与驼峰互转；`T` 首字母大写 |
| Insert | `(` `[` `{` `"` `'` `` ` `` | 自动补全配对字符 |
| Insert | `Backspace` | 成对删除括号或引号 |
| Normal、Insert、Visual | `Shift+WheelUp` / `Shift+WheelDown` | 横向滚动 |
| Normal、Visual | `Ctrl-/` | 注释 |

命令行模式中 `Ctrl-a` / `Ctrl-e` 跳到首尾，`Up` / `Down` 浏览历史。

### 选择与移动

| 模式 | 键 | 功能 |
| --- | --- | --- |
| Normal、Insert、Visual | `Shift-Up` / `Shift-Down` | 向上/下选择文本 |
| Normal、Insert、Visual | `Ctrl-Shift-Up` / `Ctrl-Shift-Down` | 快速移动 10 行 |
| Normal、Insert、Visual | `Ctrl-Shift-Left` / `Ctrl-Shift-Right` | 跳到行首 / 行尾 |
| Visual | `v` / `V` | 扩大 / 缩小选区 |

### 窗口、Buffer 与折叠

| 模式 | 键 | 功能 |
| --- | --- | --- |
| Normal | `sv` / `sp` | 左右 / 上下分屏 |
| Normal | `sc` / `so` | 关闭当前 / 关闭其他窗口 |
| Normal | `s` + Arrow | 聚焦对应窗口 |
| Normal | `Ctrl-Space` | 切换窗口 |
| Normal | `s=` | 平均窗口大小 |
| Normal | `Alt-,` / `Alt-.` | 缩小 / 增大窗口 |
| Normal | `ss` | 下一个 Buffer |
| Normal、Insert、Visual | `Alt-Left` / `Alt-Right` | 上一个 / 下一个 Buffer |
| Normal | `-` | 折叠或展开；无折叠时创建段落折叠 |
| Visual | `-` | 折叠选区 |
| Normal | `\w` | 切换自动换行 |
| Normal | `tt` | 下方打开 10 行终端 |

手动折叠和 undo 历史会持久化到 `cache/`，重新打开文件时恢复光标位置和视图。

## 🔍 搜索、补全与 AI

### FZF-Lua

| 键 | 功能 |
| --- | --- |
| `Ctrl-p` | 项目文件 |
| `Ctrl-f` | 全局文本搜索 |
| `Ctrl-b` | Buffer 列表 |
| `Ctrl-l` | 当前 Buffer 行搜索 |
| `Ctrl-g` | Git 变更文件 |
| `Ctrl-h` | 当前目录历史文件 |

搜索根目录使用启动 Neovim 时的 `$PWD`。

### Blink.cmp

| 模式 | 键 | 功能 |
| --- | --- | --- |
| Insert | `Tab` | 选择下一项、触发补全或跳到下个 snippet 占位符 |
| Insert | `Up` / `Down` | 上一项 / 下一项 |
| Insert | `Enter` | 接受补全 |
| Insert | `Ctrl-y` | 选择并接受 |
| Insert | `Ctrl-e` | 取消补全 |
| Insert | `Ctrl-k` | 切换补全和文档 |
| Command-line | `Tab` | 显示、插入或接受补全 |

补全源：`lsp`、`path`、`snippets`、`buffer`、`ripgrep`、`datword`（`word.txt`）、命令历史和搜索历史。

### GitHub Copilot

| 模式 | 键 | 功能 |
| --- | --- | --- |
| Insert | `Right` | 接受建议；无建议时正常右移 |
| Insert | `Ctrl-Up` / `Ctrl-Down` | 上一个 / 下一个建议 |

## 🌲 文件树、Git 与终端

### Nvim Tree

按 `T` 打开居中的浮动文件树，首次打开以 `$PWD` 为根目录。

| 文件树内 | 功能 |
| --- | --- |
| `a` / `A` | 新建 |
| `r` | 重命名 |
| `Left` | 关闭目录 |
| `Right` / `Enter` | 打开节点 |
| `Backspace` | 上级目录 |
| `P` | 将选中目录设为根 |
| `Esc` | 关闭文件树 |
| `(` / `)` | 上一个 / 下一个 Git 变更 |
| `<` / `>` | 上一个 / 下一个诊断 |
| `?` | 帮助 |

其余复制、剪切、粘贴、删除、过滤等键位沿用 Nvim Tree 默认映射。

### Gitsigns

| 键 | 功能 |
| --- | --- |
| `(` / `)` | 上一个 / 下一个 hunk |
| `C` | 预览当前 hunk |
| `\g` | Diff 当前文件 |

### Floaterm 与一键运行

| 模式 | 键 | 功能 |
| --- | --- | --- |
| Normal、Terminal | `Ctrl-t` | 打开、隐藏浮动终端 |
| Normal、Insert、Terminal | `F5` | 保存并运行当前文件 |

`F5` 支持 JavaScript、TypeScript、HTML、Python、Go、shell、Lua、Java、C 和 Markdown。窄窗口使用底部终端，宽窗口使用居中浮窗。

## 📝 Markdown 与文件类型增强

### Markdown

| 模式 | 键 | 功能 |
| --- | --- | --- |
| Normal | `Enter` | 切换当前任务 `[ ]` / `[x]`，然后正常回车 |
| Normal | Double-click | 切换任务并保存 |
| Visual | `B` / `I` | 加粗 / 斜体 |
| Visual | `T` | 转为待办项 |
| Visual | `` ` `` | 行内代码 |
| Visual | `C` | 代码块 |
| Normal | `F5` | 浏览器预览 |
| Normal | `F6` | 切换编辑器内 Markdown 渲染 |

Markdown 使用 2 空格缩进，并高亮任务起始日期 `S:YYYY-MM-DD`、截止日期 `D:YYYY-MM-DD`、今日和未来两天的 Deadline。

### 其他文件类型

- Go：保存前执行 `source.organizeImports`；Visual `D` 包裹为 `/** ... */`。
- TypeScript：Visual `D` 添加文档注释，Visual `T` 包裹 `try/catch`。
- Vue：Visual `D` 包裹为 `<!-- ... -->`。
- Snippets：覆盖通用、TypeScript/JavaScript/Vue、Go、HTML、Markdown、SQL、Vim、systemd 和 desktop 文件。

<a id="plugins"></a>

## 🧩 其他插件

| 插件 | 用途 |
| --- | --- |
| [yaocccc/visual-multi.nvim](https://github.com/yaocccc/visual-multi.nvim) | 多光标编辑 |
| [yaocccc/babel.nvim](https://github.com/yaocccc/babel.nvim) | `mm` 翻译当前词或选区为中文 |
| [yaocccc/vim-comment](https://github.com/yaocccc/vim-comment) | ~~Normal `??` 行注释；Visual `/` 行注释、`?` 块注释~~ |
| [yaocccc/vim-surround](https://github.com/yaocccc/vim-surround) | 添加、修改、删除包围字符 |
| [yaocccc/vim-echo](https://github.com/yaocccc/vim-echo) | Visual `C` 为 JS/TS/Vue 插入 `console.log` |
| [yaocccc/vim-fcitx2en](https://github.com/yaocccc/vim-fcitx2en) | 离开 Insert 模式时切换英文输入法 |
| [yaocccc/nvim-lines.lua](https://github.com/yaocccc/nvim-lines.lua) | 状态栏与标签栏 |
| [yaocccc/nvim-foldsign](https://github.com/yaocccc/nvim-foldsign) | Sign column 折叠标记 |
| [Mr-LLLLL/interestingwords.nvim](https://github.com/Mr-LLLLL/interestingwords.nvim) | `ff` 高亮当前词，`FF` 清除全部 |
| [uga-rosa/ccc.nvim](https://github.com/uga-rosa/ccc.nvim) | `:CccPick` 颜色选择，`:CccHighlighterEnable` 颜色高亮 |
| [nvimdev/indentmini.nvim](https://github.com/nvimdev/indentmini.nvim) | 缩进参考线 |
| [yianwillis/vimcdoc](https://github.com/yianwillis/vimcdoc) | 中文帮助文档 |

### 多光标常用键位

| 键 | 功能 |
| --- | --- |
| `Ctrl-n` | 查找并添加下一个匹配 |
| `Ctrl-d` | 添加全部匹配 |
| `Ctrl-Up` / `Ctrl-Down` | 向上 / 下添加光标 |
| `Ctrl-x` | 在当前字符添加光标 |
| `Ctrl-w` | 按词添加 |
| `Ctrl-Left` / `Ctrl-Right` | 开始或扩展选区 |
| `Tab` | 切换扩展模式 |
| `q` | 移除当前区域 |
| `Esc` | 清除多光标 |

---

## 📄 许可

本仓库为个人配置，欢迎参考、Fork 和按需修改。
