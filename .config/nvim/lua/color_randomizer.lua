local colors = vim.fn.getcompletion('', 'color')
local dflts = { 'blue', 'darkblue', 'default', 'delek', 'desert', 'elflord', 'evening', 'industry', 'koehler', 'morning',
	'murphy', 'pablo', 'peachpuff', 'ron', 'shine', 'slate', 'torte', 'zellner' }

for _, dflt in ipairs(dflts) do
	for i, color in ipairs(colors) do
		if color == dflt then
			table.remove(colors, i)
		end
	end
end

math.randomseed(os.time())
local rnd = math.random(table.maxn(colors))
local color = table.remove(colors, rnd)

--custom edge case
math.randomseed(os.time() * rnd)
if color == 'catppuccin' then
	local catppuccin_flavours = { 'latte', 'frappe', 'macchiato', 'mocha' }
	rnd = math.random(table.maxn(catppuccin_flavours))
	vim.g.catppuccin_flavour = table.remove(catppuccin_flavours, rnd)

elseif color == 'edge' then
	local edge_styles = { 'default', 'aura', 'neon' }
	rnd = math.random(table.maxn(edge_styles))
	vim.g.edge_style = table.remove(edge_styles, rnd)
elseif color == 'tokyonight' then
	local tokyonight_styles = { 'storm', 'night', 'day' }
	rnd = math.random(table.maxn(tokyonight_styles))
	vim.g.tokyonight_style = table.remove(tokyonight_styles, rnd)
elseif color == 'wwdc17' then
	rnd = math.random(16) - 1
	vim.g.wwdc17_frame_color = rnd
end

--Make sure that this sentence is at the bottom of the file
vim.cmd('colorscheme ' .. color)
print(color)
