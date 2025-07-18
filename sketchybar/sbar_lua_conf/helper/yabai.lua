---@alias display_type string
---| 'builtin'
---| 'external'

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
	print(cmd)
	local cmd_rslt = assert(io.popen(cmd, 'r'), 'failed to execute `' .. cmd .. '`')

	local rslt_list = {}
	for line in cmd_rslt:lines '*l' do
		table.insert(rslt_list, line)
	end

	cmd_rslt:close()
	return rslt_list
end

---@return string[]
m.active_displays = function()
	local uuids = m.query('display', '.[].uuid')
	return uuids
end

---comment
---@param display_type display_type
---@return string[]
local display_filter = function(display_type)
	local uuid_candidates = display_uuid_list[display_type]
	local active_displays = m.active_displays()

	local dbgr = require('sbar_lua_conf.helper.dbg').print_table
	dbgr(uuid_candidates, 'uuid_candidates')
	dbgr(active_displays, 'active_displays')
	local rslt = {}
	for _, candidate in ipairs(uuid_candidates) do
		for _, display in ipairs(active_displays) do
			if candidate == display then
				print('candidate ' .. candidate)
				print('display ' .. display)
				table.insert(rslt, display)
			end
		end
	end

	return rslt
end

---@return string uuid
m.builtin_display = function()
	return display_filter('builtin')[1]
end

---@return string[] uuid
m.external_display = function()
	return display_filter 'external'
end

---@param display_type display_type
---@return integer[]
local display_index_of = function(display_type)
	local uuid_list = display_filter(display_type)

	local jq_query = '.[] | select('
	for _, uuid in ipairs(uuid_list) do
		jq_query = jq_query .. '.uuid == ' .. uuid .. ' or '
	end

	-- we don't need to care about when uuid not found
	jq_query = jq_query:sub(1, -5) .. ') | .index'

	local matched_display = m.query('display', jq_query)
	return matched_display
end

m.builtin_display_index = function()
	return display_index_of('builtin')[1]
end

m.external_display_indices = function()
	return display_index_of 'external'
end

return m
