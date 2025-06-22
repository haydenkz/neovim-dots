return {
	{
		"nvim-tree/nvim-tree.lua",
		view = {
			width=30,
		},
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			vim.keymap.set('n', '<space>tt', '<cmd>NvimTreeToggle<cr>')
			vim.keymap.set('n', '<space>t', '<cmd>NvimTreeFocus<cr>')
			require("nvim-tree").setup() 
		end,
	},
	{
		"kyazdani42/nvim-web-devicons",
	},
}
