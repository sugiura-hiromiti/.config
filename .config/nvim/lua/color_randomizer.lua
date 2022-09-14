local colors = vim.fn.getcompletion('', 'color')
local dflts = { 'blue', 'darkblue', 'default', 'delek', 'desert', 'elflord', 'evening', 'industry', 'koehler',
	--'lunaperche',
	'morning',
	'murphy', 'pablo', 'peachpuff', 'quiet', 'ron', 'shine', 'slate', 'torte', 'zellner' }

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

vim.cmd('colorscheme ' .. color)
print(color)
