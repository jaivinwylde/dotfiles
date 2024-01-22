local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- Default mappings. Feel free to modify or remove as you wish.
	--
	-- BEGIN_DEFAULT_ON_ATTACH
	Nn("<C-]>", api.tree.change_root_to_node, opts("CD"))
	Nn("<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
	Nn("<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
	Nn("<C-t>", api.node.open.tab, opts("Open: New Tab"))
	Nn("<BS>", api.node.navigate.parent_close, opts("Close Directory"))
	Nn(">", api.node.navigate.sibling.next, opts("Next Sibling"))
	Nn("<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
	Nn(".", api.node.run.cmd, opts("Run Command"))
	Nn("-", api.tree.change_root_to_parent, opts("Up"))
	Nn("a", api.fs.create, opts("Create"))
	Nn("B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
	Nn("c", api.fs.copy.node, opts("Copy"))
	Nn("C", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
	Nn("[c", api.node.navigate.git.prev, opts("Prev Git"))
	Nn("]c", api.node.navigate.git.next, opts("Next Git"))
	Nn("d", api.fs.remove, opts("Delete"))
	Nn("D", api.fs.trash, opts("Trash"))
	Nn("E", api.tree.expand_all, opts("Expand All"))
	Nn("e", api.fs.rename_basename, opts("Rename: Basename"))
	Nn("]g", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
	Nn("[g", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
	Nn("F", api.live_filter.clear, opts("Clean Filter"))
	Nn("f", api.live_filter.start, opts("Filter"))
	Nn("g?", api.tree.toggle_help, opts("Help"))
	Nn("gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
	Nn("H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
	Nn("I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
	Nn("J", api.node.navigate.sibling.last, opts("Last Sibling"))
	Nn("K", api.node.navigate.sibling.first, opts("First Sibling"))
	Nn("<CR>", api.node.open.edit, opts("Open"))
	Nn("<Tab>", api.node.open.preview, opts("Open Preview"))
	Nn("o", api.node.open.edit, opts("Open"))
	Nn("O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
	Nn("p", api.fs.paste, opts("Paste"))
	Nn("P", api.node.navigate.parent, opts("Parent Directory"))
	Nn("q", api.tree.close, opts("Close"))
	Nn("R", api.tree.reload, opts("Refresh"))
	Nn("s", api.node.run.system, opts("Run System"))
	Nn("S", api.tree.search_node, opts("Search"))
	Nn("U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
	Nn("W", api.tree.collapse_all, opts("Collapse"))
	Nn("x", api.fs.cut, opts("Cut"))
	Nn("y", api.fs.copy.filename, opts("Copy Name"))
	Nn("Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
	Nn("<2-LeftMouse>", api.node.open.edit, opts("Open"))
	Nn("<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
	-- END_DEFAULT_ON_ATTACH

	-- Mappings migrated from view.mappings.list
	--
	-- You will need to insert "your code goes here" for any mappings with a custom action_cb
	Nn("K", api.node.show_info_popup, opts("Info"))
	Nn("s", api.node.open.horizontal, opts("Open: Horizontal Split"))
	Nn("v", api.node.open.vertical, opts("Open: Vertical Split"))
	Nn("r", api.fs.rename_sub, opts("Rename: Omit Filename"))
	Nn("<c-r>", api.fs.rename, opts("Rename"))
	Nn("m", api.marks.bulk.move, opts("Move Bookmarked"))
	Nn("t", api.marks.toggle, opts("Toggle Bookmark"))
	Nn("x", api.fs.cut, opts("Cut"))
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
