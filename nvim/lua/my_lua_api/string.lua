local mod = {}

---@return string escaped, integer count
---@param text string
mod.escape_escape_sequence = function(text)
	return text:gsub('([%(%)%.%%%+%-%*%?%[%]%^%$])', '%%%1')
end

return mod
