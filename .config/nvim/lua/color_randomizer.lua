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
if color == 'catppuccin' then
   local catppuccin_flavors = { 'latte', 'frappe', 'macchiato', 'mocha' }
   math.randomseed(os.time())
   rnd = math.random(table.maxn(catppuccin_flavors))
   vim.g.catppuccin_flavor = table.remove(catppuccin_flavors, rnd)
elseif color == 'edge' then
   local edge_styles = { 'default', 'aura', 'neon' }
   math.randomseed(os.time())
   rnd = math.random(table.maxn(edge_styles))
   vim.g.tokyonight_style = table.remove(edge_styles, rnd)
elseif color == 'tokyonight' then
   local tokyonight_styles = { 'storm', 'night', 'day' }
   math.randomseed(os.time())
   rnd = math.random(table.maxn(tokyonight_styles))
   vim.g.tokyonight_style = table.remove(tokyonight_styles, rnd)
end

--make sure that this is end of file
vim.g.colors_name = color
