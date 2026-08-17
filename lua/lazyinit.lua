local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", {
	git = { timeout = 120, depth = 1 },
	ui = {
		border = "rounded",
	},
})
require("visual-multi").setup({
  wrap = true,
  case_sensitive = true,
  mappings = {
	find_next = "<C-d>",
	select_all = "<c-s-d>",
	select_left = "<C-Left>",
	select_right = "<C-Right>",
	add_cursor_up = "<C-Up>",
	add_cursor_down = "<C-Down>",
	add_cursor = "<C-x>",
	add_cursor_word = "<C-w>",
	skip_region = false,
	remove_region = "q",
	insert_paste = "<C-v>",
	undo = "u",
	redo = "<C-r>",
  },
})
