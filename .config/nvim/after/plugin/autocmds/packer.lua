local group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	group = group,
	pattern = "lua/user/packer.lua",
	command = "so <afile> | PackerSync",
	desc = "Sync plugins when the packer file changes.",
})
