local map = vim.keymap.set

local nv = { 'n', 'v' }
local conf_home = os.getenv 'XDG_CONFIG_HOME'
local clr_rndm;
if conf_home then
	clr_rndm = conf_home .. '/nvim/lua/color_randomizer.lua'
else
	clr_rndm = '~/.config/nvim/lua/color_randomizer.lua'
end

map(nv, ':', ';') --exchange : & ;
map(nv, ';', ':')
map('n', '<esc>', ':noh<cr>') --<esc> to noh
map('n', 'W', 'wi') --move & insert
map('n', 'E', 'ea')
map('n', 'B', 'bi')
map('n', '<a-k>', ':bprev<cr>') --buffer
map('n', '<a-j>', ':bnext<cr>')
map('n', '<up>', '"zdd<up>"zP') --move line
map('n', '<down>', '"zdd"zp')
map('v', '<up>', '"zx<up>"zP`[V`]')
map('v', '<down>', '"zx"zp`[V`]')
--ideas:mapping something to <left> & <right> in normal mode
--map('n', 'm', ':w<cr>:make<cr>') --make shortcut
map(nv, ',', '@:') --like '.', repeat previous command

--use <tab> instead <space> with non coc commands
map('n', '<tab>b',
	[[<cmd> lua if vim.o.background=='dark' then vim.o.background='light' else vim.o.background='dark' end<cr>]])
map('n', '<tab>r', '<cmd> e $MYVIMRC<cr>')
map('n', '<tab>w', '<cmd> wa | lua vim.lsp.buf.formatting()<cr>')
map('n', '<tab>d', '<cmd> bd<cr>')
map('n', '<tab>c', '<cmd> so ' .. clr_rndm .. '<cr>')

--emacs keybind
map('i', '<c-n>', '<down>')
map('i', '<c-p>', '<up>')
map('i', '<c-b>', '<left>')
map('i', '<c-f>', '<right>')
map('i', '<c-a>', '<c-c>^i')
map('i', '<c-e>', '<end>')
map('i', '<c-d>', '<del>')
map('i', '<c-k>', '<right><c-c>v$hs')
map('i', '<c-t>', '<c-c><left>"zx"zpa')
map('i', '<c-y>', '<c-r>"')
map('i', '<a-d>', '<c-c>ciw')
map('i', '<a-f>', '<c-right>')
map('i', '<a-b>', '<c-left><left>')

--split pane and change size
map(nv, '<', '<c-w>W')
map(nv, '>', '<c-w>w')
map(nv, '_', ':<c-u>sp<cr>')
map(nv, '<bar>', ':<c-u>vs<cr>')
map(nv, '`', '<c-w>>')
map(nv, '-', '<c-w><')
map(nv, '\\', '<c-w>+')
map(nv, '=', '<c-w>-')

--lsp related config moves to lsp.lua
----lsp saga
local keymap = vim.keymap.set
-- Lsp finder find the symbol definition implement reference
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap("n", "<space>f", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

-- Code action
keymap("n", "<space>a", "<cmd>Lspsaga code_action<CR>", { silent = true })
keymap("v", "<space>a", "<cmd>Lspsaga range_code_action<CR>", { silent = true })

-- Rename
keymap("n", "<space>n", "<cmd>Lspsaga rename<CR>", { silent = true })

-- Definition preview
keymap("n", "<space>p", "<cmd>Lspsaga preview_definition<CR>", { silent = true })

-- Diagnsotic jump can use `<c-o>` to jump back
keymap("n", "<c-k>", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "<c-j>", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

--+---------------------------------------------------------------------------+
--|If you want only jump to error, see https://github.com/glepnir/lspsaga.nvim|
--+---------------------------------------------------------------------------+

-- Outline
keymap("n", "<space>o", "<cmd>LSoutlineToggle<CR>", { silent = true })

-- Hover Doc
keymap("n", "<space>h", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

-- Float terminal
keymap("n", "<A-t>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
-- if you want pass somc cli command into terminal you can do like this. Open lazygit in lspsaga float terminal
--keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", { silent = true })
-- close floaterm
keymap("t", "<A-t>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
