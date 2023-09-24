function ColorMyPencils(color)
	color = color or "dracula" -- "nord"
	vim.cmd.colorscheme(color)	
end
ColorMyPencils()
