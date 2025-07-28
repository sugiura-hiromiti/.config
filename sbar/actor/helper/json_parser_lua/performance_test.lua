#!/usr/bin/env lua

-- Performance test for JSON parser
local json = require 'json_parser'

-- Generate a large JSON string for testing
local function generate_large_json(size_kb)
	local parts = {}
	table.insert(parts, '{"users": [')

	local target_size = size_kb * 1024
	local current_size = 0
	local user_count = 0

	while current_size < target_size do
		if user_count > 0 then
			table.insert(parts, ',')
		end

		local user_json = string.format(
			[[{
            "id": %d,
            "name": "User%d",
            "email": "user%d@example.com",
            "active": %s,
            "profile": {
                "firstName": "First%d",
                "lastName": "Last%d",
                "age": %d,
                "address": {
                    "street": "%d Main Street",
                    "city": "City%d",
                    "zipCode": "%05d"
                }
            },
            "preferences": {
                "theme": "%s",
                "notifications": {
                    "email": %s,
                    "push": %s,
                    "sms": %s
                }
            },
            "tags": ["tag%d", "category%d", "group%d"]
        }]],
			user_count,
			user_count,
			user_count,
			user_count % 2 == 0 and 'true' or 'false',
			user_count,
			user_count,
			20 + (user_count % 50),
			user_count,
			user_count % 100,
			user_count % 100000,
			user_count % 2 == 0 and 'dark' or 'light',
			user_count % 3 == 0 and 'true' or 'false',
			user_count % 3 == 1 and 'true' or 'false',
			user_count % 3 == 2 and 'null' or 'false',
			user_count % 10,
			user_count % 20,
			user_count % 5
		)

		table.insert(parts, user_json)
		current_size = current_size + #user_json
		user_count = user_count + 1
	end

	table.insert(parts, '], "metadata": {"total": ')
	table.insert(parts, tostring(user_count))
	table.insert(parts, ', "generated": "2023-07-26T12:00:00Z"}}')

	return table.concat(parts)
end

-- Measure parsing time
local function measure_parse_time(json_string, description)
	local start_time = os.clock()
	local result, err = json.parse(json_string)
	local end_time = os.clock()

	local elapsed_ms = (end_time - start_time) * 1000
	local size_kb = math.floor(#json_string / 1024)

	if result then
		print(
			string.format(
				'%s: %d KB parsed in %.2f ms (%.2f KB/ms)',
				description,
				size_kb,
				elapsed_ms,
				size_kb / elapsed_ms
			)
		)
		return elapsed_ms, size_kb
	else
		print(string.format('%s: Parse error - %s', description, err.message))
		return nil, size_kb
	end
end

print '=== JSON Parser Performance Test ===\n'

-- Test different sizes
local test_sizes = { 10, 50, 100, 500, 1000 } -- KB

for _, size_kb in ipairs(test_sizes) do
	print(string.format('Generating %d KB JSON...', size_kb))
	local large_json = generate_large_json(size_kb)

	local elapsed_ms, actual_size_kb = measure_parse_time(large_json, string.format('Test %d KB', size_kb))

	if elapsed_ms then
		-- Check if it meets the performance requirement (1MB in 100ms)
		local projected_1mb_time = (elapsed_ms / actual_size_kb) * 1024
		local meets_requirement = projected_1mb_time <= 100

		print(
			string.format(
				'  Projected 1MB parse time: %.2f ms %s',
				projected_1mb_time,
				meets_requirement and '(✓ meets requirement)' or '(✗ too slow)'
			)
		)
	end
	print()
end

-- Test with a complex nested structure
print 'Testing complex nested structure...'
local complex_json =
	'{"level1": {"level2": {"level3": {"level4": {"level5": {"data": "deep nesting test", "array": [1, 2, 3, {"nested": true}], "values": {"a": 1, "b": 2, "c": 3, "d": 4, "e": 5, "f": 6, "g": 7, "h": 8, "i": 9, "j": 10}}}}}}, "arrays": [[1, 2, [3, 4, [5, 6]]], {"mixed": [true, false, null, "string", 123.45]}]}'

measure_parse_time(complex_json, 'Complex nested structure')

print '\n=== Performance Test Complete ==='
