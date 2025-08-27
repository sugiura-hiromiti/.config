---@alias display_type string
---| 'builtin'
---| 'external'

---@class display_info
---@field id integer
---@field uuid string
---@field index integer 1 based. main display is 1
---@field label string|nil display label if exist
---@field frame coordinate
---@field spaces integer[]
---@field has-focus boolean

---@class coordinate
---@field x number
---@field y number
---@field w number
---@field h number

---@class space_info
---@field id integer
---@field uuid string
---@field index integer 1 based. main display is 1
---@field label string|nil space label if exist
---@field type layout_type
---@field display integer
---@field windows integer[] list of window id on the space
---@field first-window integer id of first window
---@field last-window integer id of last window
---@field has-focus boolean
---@field is-visible boolean
---@field is-native-fullscreen boolean

---@class window_info
---@field id integer
---@field pid integer
---@field app string
---@field title string
---@field scratchpad string
---@field frame coordinate
---@field role string
---@field subrole string
---@field root-window boolean
---@field display integer
---@field space integer
---@field level integer
---@field sub-level integer
---@field layer layer_type
---@field sub-layer layer_type
---@field opacity number
---@field split-type string
---@field split-child string
---@field stack-index integer
---@field can-move boolean
---@field can-resize boolean
---@field has-focus boolean
---@field has-shadow boolean
---@field has-parent-zoom boolean
---@field has-fullscreen-zoom boolean
---@field has-ax-reference boolean
---@field is-native-fullscreen boolean
---@field is-visible boolean
---@field is-minimized boolean
---@field is-hidden boolean
---@field is-floating boolean
---@field is-sticky boolean
---@field is-grabbed boolean

---@alias layer_type
---| 'above'
---| 'normal'
---| 'below'
---| 'auto'

---@alias space_info_type string
---| 'id'
---| 'uuid'
---| 'index'
---| 'label'
---| 'type'
---| 'display'
---| 'windows'
---| 'first-window'
---| 'last-window'
---| 'has-focus'
---| 'is-visible'
---| 'is-native-fullscreen'

---@alias layout_type string
---| 'float'
---| 'stack'
---| 'bsp'

---@alias position string
---| 'right'
---| 'left'
---| 'center'

---@alias yqt
---| 'window'
---| 'space'
---| 'display'

local jp = require 'actor.helper.json_parser_lua.json_parser'

local m = {}

--- apply `jq` query for yabai query info
---@param query_type yqt
---@param filter_type yqt|nil
---@param filter integer|nil
---@return display_info[]|space_info[]|window_info[]|display_info|space_info|window_info
m.query = function(query_type, filter_type, filter)
	local post_filter = ''
	if filter_type then
		post_filter = ' --' .. filter_type
		if filter then
			post_filter = post_filter .. ' ' .. filter
		end
	end

	local cmd = 'yabai -m query --' .. query_type .. 's' .. post_filter
	local cmd_rslt = assert(io.popen(cmd, 'r'), 'cmd execution has failed')

	local rslt_json_str = cmd_rslt:read '*a'
	cmd_rslt:close()

	local rslt = jp.parse(rslt_json_str)
	if not rslt then
		error 'failed to parse yabai query output json'
	end

	return rslt
end

-- NOTE: * === displays === *

m.display = {
	---@return display_info[]
	all = function()
		return m.query 'display'
	end,

	---@param index integer
	---@return display_info
	with_index = function(index)
		return m.query('display', 'display', index)
	end,

	---@return display_info
	focused = function()
		return m.query('display', 'display')
	end,

	---@return display_info
	builtin = function()
		local dis = m.display.all()

		if #dis == 1 then
			return dis[1]
		end

		local display_info
		for idx, di in ipairs(dis) do
			if di.frame.y ~= 0 then
				display_info = di
				goto rarara
			end
		end

		::rarara::

		return display_info
	end,

	---@return display_info[]
	external = function()
		local dis = m.display.all()

		local display_infos = {}
		for idx, di in ipairs(dis) do
			if di.frame.y == 0 then
				table.insert(display_infos, di)
			end
		end

		return display_infos
	end,

	---@return integer[]
	external_indices = function()
		local external = m.display.external()

		local indices = {}
		for _, di in ipairs(external) do
			table.insert(indices, di.index)
		end

		return indices
	end,

	space = {
		--- returns display_info with focused space
		---@return display_info
		on_focused = function()
			return m.query('display', 'space')
		end,

		--- returns display_info with specified space
		---@param space_index integer
		---@return display_info
		on_specified_ = function(space_index)
			return m.query('display', 'space', space_index)
		end,
	},

	window = {
		--- returns display_info with focused window
		---@return display_info
		on_focused = function()
			return m.query('display', 'window')
		end,

		--- returns display_info with specified window
		---@param window_id integer
		---@return display_info
		on_specified_ = function(window_id)
			return m.query('display', 'window', window_id)
		end,
	},
}

m.space = {
	---@return space_info[]
	all = function()
		return m.query 'space'
	end,

	---@return space_info[]
	visible = function()
		---@type space_info
		local spaces = m.space.all()

		local rslt = {}
		for _, space in ipairs(spaces) do
			if space['is-visible'] then
				table.insert(rslt, space)
			end
		end

		return rslt
	end,

	---@return space_info
	focused = function()
		return m.query('space', 'space')
	end,

	---@param space_index integer
	---@return space_info
	with_index = function(space_index)
		return m.query('space', 'space', space_index)
	end,

	---@return space_info[]
	with_fullscreen = function()
		local spaces = m.query 'space'

		local rslt = {}
		for _, space in ipairs(spaces) do
			if space['is-native-fullscreen'] then
				table.insert(rslt, space)
			end
		end

		return rslt
	end,

	display = {
		--- returns space info with focused display
		---@return space_info[]
		on_focused = function()
			return m.query('space', 'display')
		end,

		--- returns space info with specified display
		---@param display_index integer
		---@return space_info[]
		on_specified_ = function(display_index)
			return m.query('space', 'display', display_index)
		end,

		--- returns space infos with builtin display
		---@return space_info[]
		on_builtin = function()
			local builtin_display_index = m.display.builtin().index
			return m.space.display.on_specified_(builtin_display_index)
		end,

		--- returns space infos with external displays
		---@return space_info[]
		on_external = function()
			local external_display_indices = m.display.external_indices()

			local space_infos = {}
			for _, i in ipairs(external_display_indices) do
				local ex_space_infos = m.space.display.on_specified_(i)
				for _, space_info in ipairs(ex_space_infos) do
					table.insert(space_infos, space_info)
				end
			end

			return space_infos
		end,
	},

	window = {
		--- returns space info with focused window
		---@return space_info[]
		on_focused = function()
			return m.query('space', 'window')
		end,

		--- returns space info with specified window
		---@param window_id integer
		---@return space_info[]
		on_specified_ = function(window_id)
			return m.query('space', 'window', window_id)
		end,
	},
}

m.window = {
	---@return window_info[]
	all = function()
		return m.query 'window'
	end,

	---@return window_info[]
	visible = function()
		local windows = m.window.all()

		local rslt = {}
		for _, window in ipairs(windows) do
			if window['is-visible'] then
				table.insert(rslt, window)
			end
		end

		return rslt
	end,

	---@return window_info
	focused = function()
		return m.query('window', 'window')
	end,

	---@param window_id integer
	---@return window_info
	on_specified_ = function(window_id)
		return m.query('window', 'window', window_id)
	end,

	display = {
		---@return window_info[]
		on_focused = function()
			return m.query('window', 'display')
		end,

		---@param display_index integer
		---@return window_info
		on_specified_ = function(display_index)
			return m.query('window', 'display', display_index)
		end,

		---@return window_info[]
		on_builtin = function()
			local bdi = m.display.builtin().index
			return m.window.display.on_specified_(bdi)
		end,

		on_external = function()
			local edis = m.display.external_indices()

			local rslt = {}
			for _, edi in ipairs(edis) do
				local window_infos = m.window.display.on_specified_(edi)
				for _, window_info in ipairs(window_infos) do
					table.insert(rslt, window_info)
				end
			end

			return rslt
		end,
	},

	space = {
		---@return window_info[]
		on_focused = function()
			return m.query('window', 'space')
		end,

		on_specified_ = function(space_index)
			return m.query('window', 'space', space_index)
		end,
	},
}

return m
