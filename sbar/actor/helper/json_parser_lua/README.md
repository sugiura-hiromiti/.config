# JSON Parser for Lua

A lightweight, RFC 8259-compliant JSON parser written in pure Lua with zero external dependencies. Designed for embedded environments, game scripting, and general-purpose JSON parsing.

## Features

- **RFC 8259 Compliant**: Full support for JSON specification
- **Zero Dependencies**: Pure Lua implementation, no external modules or C extensions
- **Cross-Platform**: Compatible with Lua 5.3, 5.4, and LuaJIT 2.1
- **Detailed Error Reporting**: Provides line, column, and offset information for parse errors
- **Unicode Support**: Handles `\uXXXX` escape sequences (BMP range)
- **Two-Stage Processing**: Separate lexer and parser for better maintainability

## Installation

Simply copy `json_parser.lua` to your project directory or Lua path.

## Usage

```lua
local json = require("json_parser")

-- Parse JSON string
local data, err = json.parse('{"key": 123, "nested": {"flag": true}}')
if not data then
    print("Parse error:", err.message)
    print("At line", err.line, "column", err.column)
else
    print(data.key)         --> 123
    print(data.nested.flag) --> true
end
```

## API Reference

### json.parse(json_string)

Parses a JSON string into a Lua table.

**Parameters:**

- `json_string` (string): JSON text to parse

**Returns:**

- On success: `table` - Parsed Lua table
- On error: `nil, error_info` where `error_info` contains:
  - `message` (string): Error description
  - `offset` (number): Character position in input
  - `line` (number): Line number
  - `column` (number): Column number

## Supported JSON Types

| JSON Type | Lua Type | Notes                       |
| --------- | -------- | --------------------------- |
| Object    | table    | Key-value pairs             |
| Array     | table    | 1-based integer indices     |
| String    | string   | UTF-8 encoded               |
| Number    | number   | All numbers as Lua `number` |
| Boolean   | boolean  | `true`/`false`              |
| null      | nil      | Lua `nil`                   |

## String Escape Sequences

- `\"` - Quotation mark
- `\\` - Backslash
- `\/` - Forward slash
- `\b` - Backspace
- `\f` - Form feed
- `\n` - Line feed
- `\r` - Carriage return
- `\t` - Tab
- `\uXXXX` - Unicode character (BMP only)

## Error Handling

The parser provides detailed error information including:

```lua
local data, err = json.parse('{"invalid": }')
if not data then
    print("Error:", err.message)  --> "Unexpected token: }"
    print("Line:", err.line)      --> 1
    print("Column:", err.column)  --> 13
    print("Offset:", err.offset)  --> 13
end
```

## Performance

- Target: Parse ~1MB JSON within 100ms (Lua 5.4 reference)
- Safe recursion depth: Up to 100 levels
- Memory efficient: Single-pass parsing with minimal allocations

## Limitations

- **Decode Only**: No JSON encoding functionality
- **BMP Unicode**: Unicode support limited to Basic Multilingual Plane
- **No Surrogate Pairs**: High/low surrogate pairs not supported
- **No Extensions**: Strict JSON only (no comments, trailing commas, etc.)
- **Memory Usage**: Entire input processed at once (no streaming)

## Examples

### Basic Usage

```lua
local json = require("json_parser")

-- Simple values
local str = json.parse('"Hello, World!"')  --> "Hello, World!"
local num = json.parse('42')               --> 42
local bool = json.parse('true')            --> true
local null_val = json.parse('null')        --> nil

-- Objects and arrays
local obj = json.parse('{"name": "John", "age": 30}')
print(obj.name)  --> "John"
print(obj.age)   --> 30

local arr = json.parse('[1, 2, 3, "four"]')
print(arr[1])    --> 1
print(arr[4])    --> "four"
```

### Complex Nested Structure

```lua
local complex_json = [[{
    "users": [
        {
            "id": 1,
            "name": "Alice",
            "active": true,
            "preferences": {
                "theme": "dark",
                "notifications": false
            }
        },
        {
            "id": 2,
            "name": "Bob",
            "active": false,
            "preferences": null
        }
    ],
    "metadata": {
        "version": "1.0",
        "timestamp": "2023-01-01T00:00:00Z"
    }
}]]

local data, err = json.parse(complex_json)
if data then
    print(data.users[1].name)  --> "Alice"
    print(data.users[1].preferences.theme)  --> "dark"
    print(data.metadata.version)  --> "1.0"
end
```

### Error Handling

```lua
local invalid_json = '{"unclosed": "string'
local data, err = json.parse(invalid_json)
if not data then
    print("Parse failed:")
    print("  Message:", err.message)
    print("  Position:", err.offset)
    print("  Line:", err.line)
    print("  Column:", err.column)
end
```

## Testing

Run the included test suite:

```bash
lua test.lua
```

The test suite covers:

- All JSON data types
- String escape sequences
- Unicode handling
- Nested structures
- Error conditions
- Edge cases

## License

This implementation is provided as-is for educational and practical use. Feel free to modify and distribute according to your needs.

## Contributing

This is a reference implementation based on the provided specifications. For issues or improvements, please refer to the original requirements documentation.
