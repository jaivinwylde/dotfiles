local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

-- Add to jump
Nn("<leader>ha", mark.add_file)
-- Open
Nn("<leader>ho", ui.toggle_quick_menu)
-- Goto jump
Nn("[", function()
	local input = tonumber(vim.api.nvim_eval("nr2char(getchar())"))

	if input then
		ui.nav_file(tonumber(input))
	end
end)
-- Goto next and prev
Nn("<leader>hp", ui.nav_prev)
Nn("<leader>hn", ui.nav_next)
