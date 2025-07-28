local methods = {}

---comment
---@param tbl table
---@param prefix string | nil
methods.print_table = function(tbl, prefix)
	if prefix == nil then
		prefix = 'table.'
	end

	for key, value in pairs(tbl) do
		if type(value) == 'table' then
			methods.print_table(value, prefix .. key .. '.')
		else
			if value == nil then
				value = 'nil'
			end
			print(prefix .. key, ': ', value)
		end
	end
end

---comment
---@param tbl table
methods.print_keys = function(tbl)
	print '---'
	for key, _ in pairs(tbl) do
		print(key)
	end
end

---comment
---@param tbl table
---@return string
methods.stringify_table = function(tbl)
	local rslt = ''
	for key, value in pairs(tbl) do
		if key == nil then
			key = 'nil'
		end
		if value == nil then
			value = 'nil'
		end
		if type(value) == 'table' then
			rslt = rslt .. ' ' .. methods.stringify_table(value)
		else
			rslt = rslt .. ' ' .. key .. ':' .. value
		end
	end

	return rslt
end

return methods
