# JSON Parser Requirements Specification (Lua Implementation)

## 1. Background
- Lua standard libraries do not provide JSON parsing, so an RFC 8259-compliant implementation with zero external dependencies is required.
- The goal is a lightweight and general-purpose parser that works on embedded environments (LuaJIT, etc.) and game scripting environments.
- For better debugging and maintainability, **explicit separation of lexical analysis (Lexer) and parsing (Parser)** will be implemented.

## 2. Scope

### 2.1 Input
- UTF-8 encoded string (file I/O handled by the user)

### 2.2 Output
- Lua table
  - JSON object → key-value pairs
  - JSON array → 1-based integer keys
  - JSON primitives → Lua types (boolean, number, string, nil)

## 3. Functional Requirements

### 3.1 Core Functionality
- Public API: `decode(json_string)` only
- Internally performs two-stage processing: Lexer → Parser
- Returns position information (offset, line, column) when an error occurs

### 3.2 RFC 8259 Compliance
- Supported elements:
  - Object `{ ... }`
  - Array `[ ... ]`
  - String (escape sequences: `\", \\, \/, \b, \f, \n, \r, \t, \uXXXX`)
  - Numbers (integer, decimal, exponential; all treated as Lua `number` type)
  - `true` / `false` / `null`
- Ignores whitespace (space, tab, LF, CR)

### 3.3 Unicode Escapes
- Converts `\uXXXX` to UTF-8 (BMP range only)
- Surrogate pairs are not supported (converted as individual code points)

### 3.4 Error Handling
- Error return format:
  ```lua
  nil, { message = "Unexpected token '}'", offset = 45, line = 3, column = 15 }
  ```

## 4. Non-Functional Requirements

### 4.1 Dependencies
- No external Lua modules or C extensions
- Single Lua file structure (`json.lua`)

### 4.2 Portability
- Compatible with Lua 5.3 / 5.4 / LuaJIT 2.1

### 4.3 Performance
- Able to parse ~1MB JSON within 100ms (Lua 5.4 reference)
- Safe recursion depth up to 100 levels

## 5. Design Approach

### 5.1 Lexer
- Scans the entire input string and generates a token list
- Token types:
  - `{`, `}`, `[`, `]`, `:`, `,`
  - String, Number, true, false, null
  - EOF
- Token structure:
  - Type
  - Value
  - offset / line / column

### 5.2 Parser
- Performs recursive descent parsing on the token list
- Functions:
  - `parse_value()`
  - `parse_object()`
  - `parse_array()`
  - `parse_string()`
  - `parse_number()`
  - `parse_literal()`

## 6. Constraints
- No `encode` function (decode-only library)
- No support for JSON5 or comments
- No Unicode normalization (raw values preserved)

## 7. Future Extensions
- Streaming parsing
- Partial parsing (specific key extraction)
- Enhanced error messages (line/column highlights)

## 8. Testing Plan
- Valid cases: nesting, escape sequences, number formats
- Invalid cases: unclosed braces, invalid tokens, invalid escapes
