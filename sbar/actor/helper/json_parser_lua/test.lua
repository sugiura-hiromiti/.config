#!/usr/bin/env lua

-- Test script for JSON parser
local json = require 'json_parser'

-- Test cases
local test_cases = {
	-- Basic values
	{ '"hello"', 'hello' },
	{ '123', 123 },
	{ '123.45', 123.45 },
	{ '-42', -42 },
	{ '1.23e-4', 1.23e-4 },
	{ 'true', true },
	{ 'false', false },
	{ 'null', nil },

	-- Empty containers
	{ '{}', {} },
	{ '[]', {} },

	-- Simple object
	{ '{"key": "value"}', { key = 'value' } },
	{ '{"num": 42, "bool": true}', { num = 42, bool = true } },

	-- Simple array
	{ '[1, 2, 3]', { 1, 2, 3 } },
	{ '["a", "b", "c"]', { 'a', 'b', 'c' } },

	-- Nested structures
	{ '{"nested": {"inner": "value"}}', { nested = { inner = 'value' } } },
	{ '{"array": [1, 2, {"nested": true}]}', { array = { 1, 2, { nested = true } } } },

	-- String escapes
	{ '{"escaped": "Hello\\nWorld\\t\\"quoted\\""}', { escaped = 'Hello\nWorld\t"quoted"' } },
	{ '{"unicode": "\\u0048\\u0065\\u006C\\u006C\\u006F"}', { unicode = 'Hello' } },

	-- Complex example
	[[{
        "name": "John Doe",
        "age": 30,
        "active": true,
        "address": {
            "street": "123 Main St",
            "city": "Anytown"
        },
        "hobbies": ["reading", "swimming", "coding"],
        "metadata": null
    }]],
}

-- Error test cases
local error_cases = {
	'{"unclosed": ',
	'{"trailing": "comma",}',
	'[1, 2, 3,]',
	'{"invalid": invalid}',
	'{"number": 123.}',
	'{"string": "unclosed',
	'{"unicode": "\\uZZZZ"}',
	'{key: "value"}', -- unquoted key
	"{'single': 'quotes'}", -- single quotes
}

-- Helper function to compare tables
local function tables_equal(t1, t2)
	if type(t1) ~= type(t2) then
		return false
	end
	if type(t1) ~= 'table' then
		return t1 == t2
	end

	for k, v in pairs(t1) do
		if not tables_equal(v, t2[k]) then
			return false
		end
	end
	for k, v in pairs(t2) do
		if not tables_equal(v, t1[k]) then
			return false
		end
	end
	return true
end

-- Helper function to print table
local function print_table(t, indent)
	indent = indent or 0
	local spaces = string.rep('  ', indent)

	if type(t) ~= 'table' then
		if type(t) == 'string' then
			print(spaces .. '"' .. t .. '"')
		elseif t == nil then
			print(spaces .. 'null')
		else
			print(spaces .. tostring(t))
		end
		return
	end

	print(spaces .. '{')
	for k, v in pairs(t) do
		io.write(spaces .. '  ' .. tostring(k) .. ': ')
		if type(v) == 'table' then
			print ''
			print_table(v, indent + 2)
		else
			if type(v) == 'string' then
				print('"' .. v .. '"')
			elseif v == nil then
				print 'null'
			else
				print(tostring(v))
			end
		end
	end
	print(spaces .. '}')
end

-- Run tests
print '=== JSON Parser Tests ===\n'

local passed = 0
local total = 0

-- Test valid cases
print 'Testing valid JSON:'
for i, test_case in ipairs(test_cases) do
	if type(test_case) == 'string' then
		-- Simple string test
		local result, err = json.parse(test_case)
		total = total + 1
		if result ~= nil then
			print(string.format('✓ Test %d: %s', i, test_case))
			passed = passed + 1
		else
			print(string.format('✗ Test %d: %s', i, test_case))
			print('  Error:', err.message)
		end
	else
		-- Test with expected result
		local input, expected = test_case[1], test_case[2]
		local result, err = json.parse(input)
		total = total + 1

		if result == nil and err then
			print(string.format('✗ Test %d: %s', i, input))
			print('  Error:', err.message)
		elseif (result == nil and expected == nil) or tables_equal(result, expected) then
			print(string.format('✓ Test %d: %s', i, input))
			passed = passed + 1
		else
			print(string.format('✗ Test %d: %s', i, input))
			print '  Expected:'
			print_table(expected, 1)
			print '  Got:'
			print_table(result, 1)
		end
	end
end

print '\nTesting error cases:'
for i, error_case in ipairs(error_cases) do
	local result, err = json.parse(error_case)
	total = total + 1
	if result == nil and err then
		print(string.format('✓ Error test %d: %s', i, error_case))
		print('  Error:', err.message, 'at line', err.line, 'column', err.column)
		passed = passed + 1
	else
		print(string.format('✗ Error test %d: %s', i, error_case))
		print '  Expected error but got result'
	end
end

print(string.format('\n=== Results: %d/%d tests passed ===', passed, total))

-- Test the complex example from API spec
print '\n=== API Example Test ==='
local api_example = '{"key": 123, "nested": {"flag": true}}'
local data, err = json.parse(api_example)
if not data then
	print('Parse error: ' .. err.message)
else
	print('data.key =', data.key) -- Should be 123
	print('data.nested.flag =', data.nested.flag) -- Should be true
end
