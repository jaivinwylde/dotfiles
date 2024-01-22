local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

-- Add to jump
Nn("<leader>ha", mark.add_file)
-- Open
Nn("<leader>ho", ui.toggle_quick_menu)
-- Goto jump
for pos = 1, 9 do
	Nn("[" .. pos, function()
		ui.nav_file(pos)
	end)
end
-- Goto next and prev
Nn("<leader>hp", ui.nav_prev)
Nn("<leader>hn", ui.nav_next)
