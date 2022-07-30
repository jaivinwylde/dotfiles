require("nvim-tree").setup {
  sync_root_with_cwd = true,
  hijack_unnamed_buffer_when_opening = true,
  disable_netrw = true,
  create_in_closed_folder = true,
  auto_reload_on_write = true,
  reload_on_bufenter = true,
  actions = {
    open_file = {
      quit_on_open = true
    }
  },
  view = {
    adaptive_size = true,
    number = true,
    relativenumber = true,
    mappings = {
      list = {
        {key = "K", action = "toggle_file_info"},
        {key = "s", action = "split"},
        {key = "v", action = "vsplit"},
        {key = "r", action = "full_rename"},
        {key = "<c-r>", action = "rename"},
        {key = "m", action = "bulk_move"},
        {key = "t", action = "toggle_mark"},
        {key = "x", action = "cut"},
      }
    }
  },
  renderer = {
    highlight_opened_files = "all",
    indent_markers = {
      enable = true,
      inline_arrows = true
    },
    icons = {
      show = {
        folder_arrow = false
      }
    }
  }
}
