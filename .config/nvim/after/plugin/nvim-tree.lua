local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	Nn("_", api.tree.change_root_to_node, opts("CD"))
	Nn("-", api.tree.change_root_to_parent, opts("Up"))
	Nn("<c-t>", api.node.open.tab, opts("Open: New Tab"))
	Nn("<bs>", api.node.navigate.parent_close, opts("Close Directory"))
	Nn(">", api.node.navigate.sibling.next, opts("Next Sibling"))
	Nn("<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
	Nn(".", api.node.run.cmd, opts("Run Command"))
	Nn("P", api.node.navigate.parent, opts("Parent Directory"))
	Nn("R", api.tree.reload, opts("Refresh"))

	Nn("B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
	Nn("C", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
	Nn("H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
	Nn("I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))

	Nn("E", api.tree.expand_all, opts("Expand All"))
	Nn("W", api.tree.collapse_all, opts("Collapse"))

	Nn("[c", api.node.navigate.git.prev, opts("Prev Git"))
	Nn("]c", api.node.navigate.git.next, opts("Next Git"))
	Nn("]g", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
	Nn("[g", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))

	Nn("F", api.live_filter.clear, opts("Clean Filter"))
	Nn("f", api.live_filter.start, opts("Filter"))
	Nn("s", api.tree.search_node, opts("Search"))

	Nn("g?", api.tree.toggle_help, opts("Help"))

	Nn("<c-j>", api.node.navigate.sibling.last, opts("Last Sibling"))
	Nn("<c-k>", api.node.navigate.sibling.first, opts("First Sibling"))

	Nn("<cr>", api.node.open.edit, opts("Open"))
	Nn("o", api.node.open.edit, opts("Open"))
	Nn("s", api.node.open.horizontal, opts("Open: Horizontal Split"))
	Nn("v", api.node.open.vertical, opts("Open: Vertical Split"))

	Nn("y", api.fs.copy.filename, opts("Copy Name"))
	Nn("Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
	Nn("gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))

	Nn("K", api.node.show_info_popup, opts("Info"))

	Nn("r", api.fs.rename_basename, opts("Rename: Basename"))
	Nn("<c-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
	Nn("e", api.fs.rename, opts("Rename"))
	Nn("t", api.marks.toggle, opts("Toggle Bookmark"))
	Nn("m", api.marks.bulk.move, opts("Move Bookmarked"))
	Nn("c", api.fs.copy.node, opts("Copy"))
	Nn("x", api.fs.cut, opts("Cut"))
	Nn("p", api.fs.paste, opts("Paste"))
	Nn("a", api.fs.create, opts("Create"))
	Nn("d", api.fs.trash, opts("Trash"))
end

require("nvim-tree").setup({
	on_attach = on_attach,
	sync_root_with_cwd = true,
	hijack_unnamed_buffer_when_opening = true,
	disable_netrw = true,
	auto_reload_on_write = true,
	reload_on_bufenter = true,
	actions = {
		open_file = {
			quit_on_open = true,
			resize_window = true,
		},
	},
	view = {
		adaptive_size = true,
		number = true,
		relativenumber = true,
		width = "20%",
	},
	diagnostics = {
		enable = true,
		show_on_dirs = false,
		debounce_delay = 50,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	renderer = {
		root_folder_label = false,
		highlight_opened_files = "all",
		indent_markers = {
			enable = true,
			inline_arrows = true,
		},
		icons = {
			show = {
				folder_arrow = false,
			},
			glyphs = {
				git = {
					unstaged = "⏺",
					untracked = "🗙",
					deleted = "",
				},
			},
		},
	},
})
