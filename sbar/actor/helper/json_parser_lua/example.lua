#!/usr/bin/env lua

-- Example usage of the JSON parser library
local json = require 'json_parser'

-- Helper function to show string representation
local function repr(str)
	return '"' .. str:gsub('\n', '\\n'):gsub('\t', '\\t'):gsub('"', '\\"') .. '"'
end

print '=== JSON Parser Example ===\n'

-- Example 1: Simple object
print '1. Parsing a simple object:'
local simple_json = '{"name": "Alice", "age": 25, "active": true}'
local data, err = json.parse(simple_json)

if data then
	print('  Name:', data.name)
	print('  Age:', data.age)
	print('  Active:', data.active)
else
	print('  Error:', err.message)
end

-- Example 2: Array with mixed types
print '\n2. Parsing an array:'
local array_json = '[1, "hello", true, null, {"nested": "object"}]'
data, err = json.parse(array_json)

if data then
	print('  Array length:', #data)
	for i, value in ipairs(data) do
		if type(value) == 'table' then
			local keys = {}
			for k, _ in pairs(value) do
				table.insert(keys, k)
			end
			print('  [' .. i .. ']:', 'object with keys:', table.concat(keys, ', '))
		else
			print('  [' .. i .. ']:', value, '(' .. type(value) .. ')')
		end
	end
else
	print('  Error:', err.message)
end

-- Example 3: Complex nested structure
print '\n3. Parsing complex nested JSON:'
local complex_json = [[{
    "user": {
        "id": 12345,
        "profile": {
            "firstName": "John",
            "lastName": "Doe",
            "email": "john.doe@example.com"
        },
        "settings": {
            "theme": "dark",
            "notifications": {
                "email": true,
                "push": false,
                "sms": null
            }
        },
        "tags": ["developer", "lua", "json"]
    },
    "timestamp": "2023-07-26T12:00:00Z",
    "version": 1.2
}]]

data, err = json.parse(complex_json)

if data then
	print('  User ID:', data.user.id)
	print('  Full name:', data.user.profile.firstName .. ' ' .. data.user.profile.lastName)
	print('  Email:', data.user.profile.email)
	print('  Theme:', data.user.settings.theme)
	print('  Email notifications:', data.user.settings.notifications.email)
	print('  Tags:', table.concat(data.user.tags, ', '))
	print('  Timestamp:', data.timestamp)
	print('  Version:', data.version)
else
	print('  Error:', err.message)
end

-- Example 4: String escapes and Unicode
print '\n4. Parsing strings with escapes:'
local escape_json = '{"message": "Hello\\nWorld!\\t\\"Quoted\\"", "unicode": "\\u0048\\u0065\\u006C\\u006C\\u006F"}'
data, err = json.parse(escape_json)

if data then
	print('  Message:', repr(data.message)) -- Show escape sequences
	print('  Unicode:', data.unicode)
else
	print('  Error:', err.message)
end

-- Example 5: Error handling
print '\n5. Error handling example:'
local invalid_json = '{"incomplete": "object"' -- Missing closing brace
data, err = json.parse(invalid_json)

if data then
	print '  Unexpected success!'
else
	print('  Error message:', err.message)
	print('  Error location: line', err.line, 'column', err.column, 'offset', err.offset)
end

print '\n=== End of Examples ==='
