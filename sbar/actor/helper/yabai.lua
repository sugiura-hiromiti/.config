---@alias display_type string
---| 'builtin'
---| 'external'

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

local m = {}
local display_uuid_list = {
	builtin = { '"37D8832A-2D66-02CA-B9F7-8F30A301B230"' },
	external = { '"16DAB7E0-4640-4786-BD7C-4B21D071C236"', '"5573DD48-47D0-44E6-837D-8E468DE2E329"' },
}

--- apply `jq` query for yabai query info
---@alias yqt
---| 'window'
---| 'space'
---| 'display'
---@param query_type yqt
---@param jq_query string
---@return string[]
m.query = function(query_type, jq_query)
	local cmd = 'yabai -m query --' .. query_type .. "s | jq '" .. jq_query .. "'"
	local cmd_rslt = assert(io.popen(cmd, 'r'), 'cmd execution has failed')

	local rslt_list = {}
	for line in cmd_rslt:lines '*l' do
		table.insert(rslt_list, line)
	end

	cmd_rslt:close()
	return rslt_list
end

---comment
---@param pos position
---@return position
m.position = function(pos)
	if DISPLAY_INDEX ~= GUI_INFO.builtin_display_index then
		pos = 'center'
	end
	return pos
end

-- ---@type string[]
-- m.active_display_uuids = m.query('display', '.[].uuid')
--
-- ---@param display_type display_type
-- ---@return string[]
-- local display_filter = function(display_type)
-- 	local uuid_candidates = display_uuid_list[display_type]
-- 	local active_displays = m.active_display_uuids
--
-- 	local rslt = {}
-- 	for _, candidate in ipairs(uuid_candidates) do
-- 		for _, display in ipairs(active_displays) do
-- 			if candidate == display then
-- 				table.insert(rslt, display)
-- 			end
-- 		end
-- 	end
--
-- 	return rslt
-- end
--
-- ---@type string uuid
-- m.builtin_display = display_filter('builtin')[1]
--
-- ---@type string[] uuid
-- m.external_displays = display_filter 'external'
--
-- ---@return integer
-- m.focused_display_index = function()
-- 	local idx = m.query('display', '.[] | select(."has-focus" == true) | .index')[1]
-- 	return assert(tonumber(idx), 'expect display index to be number: ' .. idx)
-- end
--
-- ---@return boolean
-- m.bar_is_in_focused_display = function()
-- 	return m.focused_display_index() == DISPLAY_INDEX
-- end
-- ---@param display_type display_type
-- ---@return integer[]
-- local display_index_of = function(display_type)
-- 	local uuid_list = display_filter(display_type)
--
-- 	local jq_query = '.[] | select('
-- 	for _, uuid in ipairs(uuid_list) do
-- 		jq_query = jq_query .. '.uuid == ' .. uuid .. ' or '
-- 	end
--
-- 	-- we don't need to care about when uuid not found
-- 	jq_query = jq_query:sub(1, -5) .. ') | .index'
--
-- 	local matched_display = m.query('display', jq_query)
-- 	local rslt = {}
-- 	for _, display_index in ipairs(matched_display) do
-- 		local numbered_index = tonumber(display_index)
-- 		table.insert(rslt, numbered_index)
-- 	end
--
-- 	return rslt
-- end
--
-- ---@type integer
-- m.builtin_display_index = display_index_of('builtin')[1]
--
-- ---@type integer[]
-- m.external_display_indices = display_index_of 'external'
--
-- ---@type boolean
-- m.bar_is_builtin = DISPLAY_INDEX == m.builtin_display_index
--
-- print('builtin_display_index:', m.builtin_display_index)
-- print('bar_is_builtin:', m.bar_is_builtin)
--
-- ---@param pos string
-- ---@return string
-- m.position = function(pos)
-- 	if not m.bar_is_builtin then
-- 		pos = 'center'
-- 	end
--
-- 	return pos
-- end
--
-- ---@param key space_info_type
-- ---@param value string| integer|boolean
-- ---@param field space_info_type
-- ---@return string[] | integer[] | boolean[]
-- local function filtered_space(key, value, field)
-- 	if type(value) == 'string' then
-- 		value = '"' .. value .. '"'
-- 	end
-- 	local infos = m.query('space', '.[] | select(."' .. key .. '"' .. ' == ' .. value .. ') | .' .. field)
--
-- 	---@type string[] | integer[] | boolean[]
-- 	local rslt = {}
--
-- 	for _, info in ipairs(infos) do
-- 		if info == 'true' then
-- 			table.insert(rslt, true)
-- 		elseif info == 'false' then
-- 			table.insert(rslt, false)
-- 		elseif field == 'uuid' or field == 'label' or field == 'type' then
-- 			table.insert(rslt, info)
-- 		elseif field == 'windows' then
-- 			--  TODO: convert string to array
-- 			table.insert(rslt, info)
-- 		else
-- 			table.insert(rslt, assert(tonumber(info), 'field: ' .. field .. ' is not number: ' .. info))
-- 		end
-- 	end
--
-- 	return infos
-- end
--
-- ---@param key space_info_type
-- ---@return string | boolean | integer
-- local focused_space_ = function(key)
-- 	local info = filtered_space('has-focus', true, key)
-- 	return info[1]
-- end
--
-- ---@param key space_info_type
-- ---@return string[] | integer[] | boolean[]
-- local function on_builtin_spaces_(key)
-- 	local builtin_display_index = m.builtin_display_index()
-- 	local info = filtered_space('display', builtin_display_index, key)
-- 	return info
-- end
--
-- ---@return number
-- m.focused_space_index = function()
-- 	local idx = focused_space_ 'index'
-- 	---@diagnostic disable-next-line: return-type-mismatch
-- 	return idx
-- end
--
-- ---@return layout_type
-- m.focused_space_layout = function()
-- 	---@diagnostic disable-next-line: return-type-mismatch
-- 	return focused_space_ 'type'
-- end
--
-- ---@return string
-- m.focused_space_label = function()
-- 	---@diagnostic disable-next-line: return-type-mismatch
-- 	return focused_space_ 'label'
-- end
--
-- ---@return number[]
-- m.on_builtin_spaces_index = function()
-- 	local idx = on_builtin_spaces_ 'index'
-- 	---@diagnostic disable-next-line: return-type-mismatch
-- 	return idx
-- end
--
-- ---@return layout_type[]
-- m.on_builtin_spaces_layout = function()
-- 	---@diagnostic disable-next-line: return-type-mismatch
-- 	return on_builtin_spaces_ 'type'
-- end
--
-- ---@return string[]
-- m.on_builtin_spaces_label = function()
-- 	---@diagnostic disable-next-line: return-type-mismatch
-- 	return on_builtin_spaces_ 'label'
-- end
--

return m
