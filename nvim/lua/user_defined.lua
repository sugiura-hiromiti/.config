vim.cmd("smapclear")
local m = vim.keymap.set
local tsb = require("telescope.builtin")
local td = require("todo-comments")

local dial_pair = {
	mode = { "normal", "visual" },
	g = { "g", "" },
	direction = { ["a"] = "increment", ["x"] = "decrement" },
}

for _, mod in pairs(dial_pair.mode) do
	for _, g in pairs(dial_pair.g) do
		for key, value in pairs(dial_pair.direction) do
			m(mod:sub(1, 1), g .. "<c-" .. key .. ">", function()
				require("dial.map").manipulate(value, g .. mod)
			end)
		end
	end
end

local function table_contains(table, elem)
	for _, v in pairs(table) do
		if v == elem then
			return true
		end
	end
	return false
end

local function is_url(path)
	return path:match("^https?://") or path:match("^http?://")
end

m("i", "<esc>", function()
	local ft_no_update = vim.bo.ft:find("Telescope")
	if (not string.match(vim.bo.bt, "no") or vim.bo.modifiable) and not ft_no_update then
		vim.cmd("update")
	end
	vim.cmd("stopinsert")

	local has_format_ability = false
	local lsp_clients = vim.lsp.get_clients()
	for _, client in pairs(lsp_clients) do
		if client.server_capabilities.documentFormattingProvider then
			has_format_ability = true
			break
		else
		end
	end
	if has_format_ability then
		vim.lsp.buf.format({ async = true })
	end
end)
m("n", "<esc>", function()
	require("notify").dismiss({ pending = true, silent = true })
	vim.cmd("noh")
end)

-- NOTE: utility
m({ "n", "x" }, "k", "gk")
m({ "n", "x" }, "j", "gj")
m({ "n", "x" }, "$", "^")
m({ "n", "x" }, "^", "$")
m({ "n", "x" }, ">", "@:")
-- keep in mind of usage of `,` & `<`
m({ "n", "x" }, "<cr>", function()
	local special_ft = { "ssr" }
	local cfile = vim.fn.expand("<cfile>")
	if is_url(cfile) then
		vim.ui.open(cfile)
	elseif table_contains(special_ft, vim.bo.ft) then
		return "<cr>"
	else
		return ":Make "
	end
end, { expr = true })
m({ "n", "x" }, "<s-cr>", function()
	if vim.bo.ft == "ssr" then
		return "<s-cr>"
	else
		return ":!"
	end
end, { expr = true })
m({ "n", "x" }, "<del>", "<c-d>")
m({ "n", "i", "c", "x" }, "<c-tab>", "<cmd>tabnext<cr>")
m({ "n", "i", "c", "x" }, "<c-s-tab>", "<cmd>tabprevious<cr>")
m("t", "<esc>", "<c-\\><c-n>")

-- NOTE: emacs keybind
m("!", "<c-a>", "<home>")
m("!", "<c-e>", "<end>")
m("!", "<c-k>", "<right><c-c>v$hs")
m("!", "<c-u>", "<c-c>v^s")
m("!", "<a-d>", "<right><c-c>ves")
m("!", "<a-f>", "<c-right>")
m("!", "<a-b>", "<c-left>")

-- NOTE: lsp
m({ "n", "x" }, "<c-j>", "<cmd>Lspsaga diagnostic_jump_next<cr>")
m({ "n", "x" }, "<c-k>", "<cmd>Lspsaga diagnostic_jump_prev<cr>")
-- NOTE: telescope
m({ "n", "x" }, "/", tsb.live_grep)
m({ "n", "x" }, "<up>", td.jump_prev)
m({ "n", "x" }, "<down>", td.jump_next)

-- NOTE: spider
m({ "n", "o", "x" }, "w", function()
	require("spider").motion("w")
end)
m({ "n", "o", "x" }, "e", function()
	require("spider").motion("e")
end)
m({ "n", "o", "x" }, "b", function()
	require("spider").motion("b")
end)

-- NOTE: user command
local c = vim.api.nvim_create_user_command

c("Make", function(opts)
	local cmd = "<cr> "
	local args = opts.args
	local extra = ""
	local ft = vim.bo.filetype
	local path = vim.fn.expand("%:p")
	if ft == "rust" then -- langs which have to be compiled
		cmd = "!cargo "
		if args == "" then
			local file_name = type(path) == "string" and path or path[1]

			args = "r "
			if string.find(file_name, "/src/bin/") ~= nil then
				local _, l = string.find(file_name, "/src/bin/")
				local r = string.find(string.sub(file_name, l + 1), "/")
					or string.find(string.sub(file_name, l + 1), "%.")

				args = args .. "--bin " .. string.sub(file_name, l + 1, l + r - 1)
			elseif vim.fn.expand("%") ~= "main.rs" then
				args = "t "
			end
		else
			args = table.remove(opts.fargs, 1) -- insert 1st argument to `args`
		end
		table.insert(opts.fargs, 1, "-q")
		for _, a in ipairs(opts.fargs) do
			extra = extra .. " " .. a
		end
	elseif ft == "lisp" then
		cmd = "!sbcl --script "
		args = path .. " "
		extra = opts.args
	elseif ft == "scheme" then
		cmd = "!chibi-scheme "
		args = path .. " "
		extra = opts.args
	elseif ft == "cpp" or ft == "c" then
		cmd = "!NEOVIM_CXX_AUTO_RUNNED_FILE=" .. path .. " make"
	elseif ft == "java" then
		if path:find("test") ~= nil then
			cmd = "JavaTestRunnerCurrentClass"
		else
			if args == "s" then
				cmd = "JavaRunnerStopMain"
			else
				cmd = "JavaRunnerRunMain"
			end
		end
	elseif ft == "ruby" or ft == "swift" or ft == "lua" or ft == "python" or ft == "typescript" then -- langs which has interpreter
		local interpreter = ft
		if interpreter == "python" then
			interpreter = interpreter .. "3"
		elseif interpreter == "typescript" then
			if args == "html" then
				interpreter = "tsc"
				args = "&& open " .. vim.fn.expand("%:p:h") .. "/index.html"
			else
				interpreter = "tsx"
			end
		end
		if args == "t" then
			path = "test." .. ft
			args = ""
		end
		cmd = "!" .. interpreter .. " " .. path .. " "
	elseif ft == "html" then -- markup language
		cmd = "!open " .. path .. " "
	elseif ft == "markdown" then
		cmd =
			[[lua if require('peek').is_open() then require('peek').close() else require('peek').open() end]]
		args = ""
	end

	vim.cmd(cmd .. args .. extra)
end, { nargs = "*" })
c("RmSwap", function()
	vim.cmd("!rip ~/.local/state/nvim/swap/")
end, {})

-- NOTE: autocmd
local au_id = vim.api.nvim_create_augroup("my_au", { clear = true })
local a = vim.api.nvim_create_autocmd

a("filetype", {
	group = au_id,
	callback = function()
		local ft = vim.bo.ft
		if ft == "notify" then
			vim.bo.modifiable = true
		elseif ft == "noice" then
			vim.bo.ft = "markdown"
		end
	end,
})

a("bufreadpost", {
	group = au_id,
	callback = function()
		require("colorizer").attach_to_buffer(0)
	end,
})

local function diag_mark()
	vim.notify("attaching custom diag", vim.diagnostic.severity.INFO, { title = "diag_mark" })
	local all_bufs = vim.api.nvim_list_bufs()
	local bufs = {}
	for _, buf in pairs(all_bufs) do
		if vim.api.nvim_buf_is_loaded(buf) then
			table.insert(bufs, buf)
		end
	end

	local marks = {
		[" TODO: "] = vim.diagnostic.severity.INFO,
		[" HACK: "] = vim.diagnostic.severity.HINT,
		[" WARN: "] = vim.diagnostic.severity.WARN,
		[" PERF: "] = vim.diagnostic.severity.INFO,
		[" NOTE: "] = vim.diagnostic.severity.HINT,
		[" TEST: "] = vim.diagnostic.severity.INFO,
	}

	local ns = vim.api.nvim_create_namespace("diag_mark")
	for _, buf in pairs(bufs) do
		local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
		for i, line in ipairs(lines) do
			for mark, severity in pairs(marks) do
				local _, col_num = line:find(mark)
				local diag = { lnum = i - 1, col = col_num - 1, message = line, severity = severity }
				vim.diagnostic.set(ns, buf, { diag }, { virtual_text = false, float = false })
				vim.notify("found diag", vim.diagnostic.severity.INFO, { title = "diag_mark" })
			end
		end
	end
end

a({ "bufwritepost" }, {
	callback = function()
		vim.notify("attaching custom diag", vim.diagnostic.severity.INFO, { title = "diag_mark" })
		local all_bufs = vim.api.nvim_list_bufs()
		local bufs = {}
		for _, buf in pairs(all_bufs) do
			if vim.api.nvim_buf_is_loaded(buf) then
				table.insert(bufs, buf)
			end
		end

		local marks = {
			[" TODO: "] = vim.diagnostic.severity.INFO,
			[" HACK: "] = vim.diagnostic.severity.HINT,
			[" WARN: "] = vim.diagnostic.severity.WARN,
			[" PERF: "] = vim.diagnostic.severity.INFO,
			[" NOTE: "] = vim.diagnostic.severity.HINT,
			[" TEST: "] = vim.diagnostic.severity.INFO,
		}

		local ns = vim.api.nvim_create_namespace("diag_mark")
		for _, buf in pairs(bufs) do
			local diags = {}
			local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
			for i, line in ipairs(lines) do
				for mark, severity in pairs(marks) do
					local _, col_num = line:find(mark)
					if col_num ~= nil then
						local diag = { lnum = i - 1, col = col_num, message = line, severity = severity }
						table.insert(diags, diag)
					end
				end
			end
			vim.diagnostic.set(ns, buf, diags, { virtual_text = false, float = false })
			vim.notify("found diag", vim.diagnostic.severity.INFO, { title = "diag_mark" })
		end
	end,
})
