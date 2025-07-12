local m = {}

---comment
---@param ts_node userdata
---@param condition function this function takes one argument ts_node and returns bool
---@return table
m.flat_filter_node = function(ts_node, condition)
	if ts_node:child(0) == nil then
		if condition(ts_node) then
			return { ts_node }
		else
			return {}
		end
	else
		local child_count = ts_node:child_count()

		local rslt = {}
		for i = 0, child_count - 1, 1 do
			local typed_nodes_in_child_node = m.flat_filter_node(ts_node:child(i), condition)
			for _, node in ipairs(typed_nodes_in_child_node) do
				table.insert(rslt, node)
				-- rslt.insert(node)
			end
		end

		return rslt
	end
end

---@class buf_range
---@field start_row integer
---@field start_column integer
---@field end_row integer
---@field end_column integer
---@param buf_nr integer?
---@return [buf_range]
m.get_comment_positions = function(buf_nr)
	local ts_parser = vim.treesitter.get_parser(buf_nr, nil, { error = false })

	if ts_parser == nil then
		return {}
	end

	local ts_tree = ts_parser:parse(true)[1]
	local buf_ts_node = ts_tree:root()

	local my_ts_api = require 'my_lua_api.ts'

	local comment_nodes = my_ts_api.flat_filter_node(buf_ts_node, function(given_node)
		local is_comment = given_node:type():find 'comment'
		return is_comment ~= nil
	end)

	local comments = {}
	for _, comment_node in ipairs(comment_nodes) do
		local start_row, start_column, end_row, end_column = comment_node:range()
		---@type buf_range
		local range = { start_row = start_row, start_column = start_column, end_row = end_row, end_column = end_column }

		table.insert(comments, range)
	end

	return comments
end

return m
