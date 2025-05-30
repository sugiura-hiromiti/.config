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
			print(prefix .. key, ': ', value ~= nil and value or 'nil')
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

return methods
