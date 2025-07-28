# JSON Parser API Specification

## Overview

Pure Lua JSON parser library with zero external dependencies.
Parses JSON strings into Lua tables. Lexer and parser internals are hidden from users.

## Module Name

```lua
local json = require("json_parser")
```

## Function Reference

### json.parse(json_string)

Description:
Parses a JSON string into a Lua table.

Parameters:

json_string (string) - JSON text to parse.

Returns:

table – Parsed Lua table if successful
nil, string – nil and an error message if parsing fails

Error Message Format:
Always includes position info (character index or line/column)

Example:
"Unexpected token '}' at line 2, column 5"

## Error Cases

- Invalid JSON syntax
- Unsupported Unicode (non-BMP characters)
- Unexpected token or structure

## Constraints

- Numbers are treated as Lua number (no integer/float distinction)
- Unicode support is limited to the Basic Multilingual Plane (BMP)
- Parser processes the entire input string at once
- Lexer and parser APIs are internal, not exposed to users
- JSON standard compliance: No comments, no trailing commas

## Usage Example

```lua
local json = require("json_parser")

local data, err = json.parse('{"key": 123, "nested": {"flag": true}}')
if not data then
    print("Parse error: " .. err)
else
    print(data.key)         --> 123
    print(data.nested.flag) --> true
end
```
