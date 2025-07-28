-- JSON Parser Library for Lua
-- RFC 8259 compliant JSON parser with zero external dependencies
-- Supports Lua 5.3, 5.4, and LuaJIT 2.1

local json_parser = {}

-- Token types
local TOKEN_TYPES = {
	LBRACE = 'LBRACE', -- {
	RBRACE = 'RBRACE', -- }
	LBRACKET = 'LBRACKET', -- [
	RBRACKET = 'RBRACKET', -- ]
	COLON = 'COLON', -- :
	COMMA = 'COMMA', -- ,
	STRING = 'STRING',
	NUMBER = 'NUMBER',
	TRUE = 'TRUE',
	FALSE = 'FALSE',
	NULL = 'NULL',
	EOF = 'EOF',
}

-- Lexer implementation
local Lexer = {}
Lexer.__index = Lexer

function Lexer.new(input)
	return setmetatable({
		input = input,
		pos = 1,
		line = 1,
		column = 1,
		length = #input,
	}, Lexer)
end

function Lexer:current_char()
	if self.pos > self.length then
		return nil
	end
	return string.sub(self.input, self.pos, self.pos)
end

function Lexer:peek_char(offset)
	offset = offset or 1
	local peek_pos = self.pos + offset
	if peek_pos > self.length then
		return nil
	end
	return string.sub(self.input, peek_pos, peek_pos)
end

function Lexer:advance()
	if self.pos <= self.length then
		local char = string.sub(self.input, self.pos, self.pos)
		self.pos = self.pos + 1
		if char == '\n' then
			self.line = self.line + 1
			self.column = 1
		else
			self.column = self.column + 1
		end
		return char
	end
	return nil
end

function Lexer:skip_whitespace()
	while true do
		local char = self:current_char()
		if not char then
			break
		end
		if char == ' ' or char == '\t' or char == '\n' or char == '\r' then
			self:advance()
		else
			break
		end
	end
end

function Lexer:error(message)
	return nil, {
		message = message,
		offset = self.pos,
		line = self.line,
		column = self.column,
	}
end

function Lexer:parse_string()
	local start_pos = self.pos
	local start_line = self.line
	local start_column = self.column

	-- Skip opening quote
	self:advance()

	local result = {}

	while true do
		local char = self:current_char()
		if not char then
			return self:error 'Unterminated string'
		end

		if char == '"' then
			self:advance()
			break
		elseif char == '\\' then
			self:advance()
			local escape_char = self:current_char()
			if not escape_char then
				return self:error 'Unterminated string escape'
			end

			if escape_char == '"' then
				table.insert(result, '"')
			elseif escape_char == '\\' then
				table.insert(result, '\\')
			elseif escape_char == '/' then
				table.insert(result, '/')
			elseif escape_char == 'b' then
				table.insert(result, '\b')
			elseif escape_char == 'f' then
				table.insert(result, '\f')
			elseif escape_char == 'n' then
				table.insert(result, '\n')
			elseif escape_char == 'r' then
				table.insert(result, '\r')
			elseif escape_char == 't' then
				table.insert(result, '\t')
			elseif escape_char == 'u' then
				-- Unicode escape sequence
				self:advance()
				local hex_digits = ''
				for i = 1, 4 do
					local hex_char = self:current_char()
					if not hex_char or not string.match(hex_char, '[0-9a-fA-F]') then
						return self:error 'Invalid unicode escape sequence'
					end
					hex_digits = hex_digits .. hex_char
					self:advance()
				end
				self.pos = self.pos - 1 -- Back up one since we'll advance at end of loop

				-- Convert hex to number
				local code_point = tonumber(hex_digits, 16)
				if code_point <= 0x7F then
					table.insert(result, string.char(code_point))
				elseif code_point <= 0x7FF then
					table.insert(result, string.char(0xC0 + math.floor(code_point / 0x40)))
					table.insert(result, string.char(0x80 + (code_point % 0x40)))
				elseif code_point <= 0xFFFF then
					table.insert(result, string.char(0xE0 + math.floor(code_point / 0x1000)))
					table.insert(result, string.char(0x80 + math.floor((code_point % 0x1000) / 0x40)))
					table.insert(result, string.char(0x80 + (code_point % 0x40)))
				else
					return self:error 'Unicode code point outside BMP not supported'
				end
			else
				return self:error('Invalid escape sequence: \\' .. escape_char)
			end
			self:advance()
		else
			table.insert(result, char)
			self:advance()
		end
	end

	return {
		type = TOKEN_TYPES.STRING,
		value = table.concat(result),
		offset = start_pos,
		line = start_line,
		column = start_column,
	}
end

function Lexer:parse_number()
	local start_pos = self.pos
	local start_line = self.line
	local start_column = self.column

	local number_str = ''

	-- Handle negative sign
	if self:current_char() == '-' then
		number_str = number_str .. self:advance()
	end

	-- Parse integer part
	local char = self:current_char()
	if char == '0' then
		number_str = number_str .. self:advance()
	elseif char and string.match(char, '[1-9]') then
		while true do
			char = self:current_char()
			if char and string.match(char, '[0-9]') then
				number_str = number_str .. self:advance()
			else
				break
			end
		end
	else
		return self:error 'Invalid number'
	end

	-- Parse decimal part
	if self:current_char() == '.' then
		number_str = number_str .. self:advance()
		local has_digits = false
		while true do
			char = self:current_char()
			if char and string.match(char, '[0-9]') then
				number_str = number_str .. self:advance()
				has_digits = true
			else
				break
			end
		end
		if not has_digits then
			return self:error 'Invalid number: missing digits after decimal point'
		end
	end

	-- Parse exponent part
	char = self:current_char()
	if char == 'e' or char == 'E' then
		number_str = number_str .. self:advance()
		char = self:current_char()
		if char == '+' or char == '-' then
			number_str = number_str .. self:advance()
		end
		local has_digits = false
		while true do
			char = self:current_char()
			if char and string.match(char, '[0-9]') then
				number_str = number_str .. self:advance()
				has_digits = true
			else
				break
			end
		end
		if not has_digits then
			return self:error 'Invalid number: missing digits in exponent'
		end
	end

	local number_value = tonumber(number_str)
	if not number_value then
		return self:error 'Invalid number format'
	end

	return {
		type = TOKEN_TYPES.NUMBER,
		value = number_value,
		offset = start_pos,
		line = start_line,
		column = start_column,
	}
end

function Lexer:parse_literal(expected, token_type)
	local start_pos = self.pos
	local start_line = self.line
	local start_column = self.column

	for i = 1, #expected do
		if self:current_char() ~= string.sub(expected, i, i) then
			return self:error 'Invalid literal'
		end
		self:advance()
	end

	return {
		type = token_type,
		value = expected,
		offset = start_pos,
		line = start_line,
		column = start_column,
	}
end

function Lexer:next_token()
	self:skip_whitespace()

	local char = self:current_char()
	if not char then
		return {
			type = TOKEN_TYPES.EOF,
			value = nil,
			offset = self.pos,
			line = self.line,
			column = self.column,
		}
	end

	local start_pos = self.pos
	local start_line = self.line
	local start_column = self.column

	if char == '{' then
		self:advance()
		return {
			type = TOKEN_TYPES.LBRACE,
			value = '{',
			offset = start_pos,
			line = start_line,
			column = start_column,
		}
	elseif char == '}' then
		self:advance()
		return {
			type = TOKEN_TYPES.RBRACE,
			value = '}',
			offset = start_pos,
			line = start_line,
			column = start_column,
		}
	elseif char == '[' then
		self:advance()
		return {
			type = TOKEN_TYPES.LBRACKET,
			value = '[',
			offset = start_pos,
			line = start_line,
			column = start_column,
		}
	elseif char == ']' then
		self:advance()
		return {
			type = TOKEN_TYPES.RBRACKET,
			value = ']',
			offset = start_pos,
			line = start_line,
			column = start_column,
		}
	elseif char == ':' then
		self:advance()
		return {
			type = TOKEN_TYPES.COLON,
			value = ':',
			offset = start_pos,
			line = start_line,
			column = start_column,
		}
	elseif char == ',' then
		self:advance()
		return {
			type = TOKEN_TYPES.COMMA,
			value = ',',
			offset = start_pos,
			line = start_line,
			column = start_column,
		}
	elseif char == '"' then
		return self:parse_string()
	elseif char == '-' or string.match(char, '[0-9]') then
		return self:parse_number()
	elseif char == 't' then
		return self:parse_literal('true', TOKEN_TYPES.TRUE)
	elseif char == 'f' then
		return self:parse_literal('false', TOKEN_TYPES.FALSE)
	elseif char == 'n' then
		return self:parse_literal('null', TOKEN_TYPES.NULL)
	else
		return self:error('Unexpected character: ' .. char)
	end
end

function Lexer:tokenize()
	local tokens = {}
	while true do
		local token, err = self:next_token()
		if not token then
			return nil, err
		end
		table.insert(tokens, token)
		if token.type == TOKEN_TYPES.EOF then
			break
		end
	end
	return tokens
end

-- Parser implementation
local Parser = {}
Parser.__index = Parser

function Parser.new(tokens)
	return setmetatable({
		tokens = tokens,
		pos = 1,
		length = #tokens,
	}, Parser)
end

function Parser:current_token()
	if self.pos > self.length then
		return self.tokens[self.length] -- Return EOF token
	end
	return self.tokens[self.pos]
end

function Parser:advance()
	if self.pos <= self.length then
		self.pos = self.pos + 1
	end
end

function Parser:error(message)
	local token = self:current_token()
	return nil, {
		message = message,
		offset = token.offset,
		line = token.line,
		column = token.column,
	}
end

function Parser:expect(token_type)
	local token = self:current_token()
	if token.type ~= token_type then
		return self:error('Expected ' .. token_type .. ' but got ' .. token.type)
	end
	self:advance()
	return token
end

function Parser:parse_value()
	local token = self:current_token()

	if token.type == TOKEN_TYPES.LBRACE then
		return self:parse_object()
	elseif token.type == TOKEN_TYPES.LBRACKET then
		return self:parse_array()
	elseif token.type == TOKEN_TYPES.STRING then
		self:advance()
		return token.value
	elseif token.type == TOKEN_TYPES.NUMBER then
		self:advance()
		return token.value
	elseif token.type == TOKEN_TYPES.TRUE then
		self:advance()
		return true
	elseif token.type == TOKEN_TYPES.FALSE then
		self:advance()
		return false
	elseif token.type == TOKEN_TYPES.NULL then
		self:advance()
		return nil
	else
		return self:error('Unexpected token: ' .. token.type)
	end
end

function Parser:parse_object()
	local obj = {}

	local token, err = self:expect(TOKEN_TYPES.LBRACE)
	if not token then
		return nil, err
	end

	-- Handle empty object
	if self:current_token().type == TOKEN_TYPES.RBRACE then
		self:advance()
		return obj
	end

	while true do
		-- Parse key
		local key_token = self:current_token()
		if key_token.type ~= TOKEN_TYPES.STRING then
			return self:error 'Expected string key in object'
		end
		local key = key_token.value
		self:advance()

		-- Parse colon
		token, err = self:expect(TOKEN_TYPES.COLON)
		if not token then
			return nil, err
		end

		-- Parse value
		local value, parse_err = self:parse_value()
		if parse_err then
			return nil, parse_err
		end

		obj[key] = value

		-- Check for comma or end
		local next_token = self:current_token()
		if next_token.type == TOKEN_TYPES.RBRACE then
			self:advance()
			break
		elseif next_token.type == TOKEN_TYPES.COMMA then
			self:advance()
			-- Check for trailing comma (not allowed in JSON)
			if self:current_token().type == TOKEN_TYPES.RBRACE then
				return self:error 'Trailing comma not allowed in JSON'
			end
		else
			return self:error "Expected ',' or '}' in object"
		end
	end

	return obj
end

function Parser:parse_array()
	local arr = {}

	local token, err = self:expect(TOKEN_TYPES.LBRACKET)
	if not token then
		return nil, err
	end

	-- Handle empty array
	if self:current_token().type == TOKEN_TYPES.RBRACKET then
		self:advance()
		return arr
	end

	while true do
		-- Parse value
		local value, parse_err = self:parse_value()
		if parse_err then
			return nil, parse_err
		end

		table.insert(arr, value)

		-- Check for comma or end
		local next_token = self:current_token()
		if next_token.type == TOKEN_TYPES.RBRACKET then
			self:advance()
			break
		elseif next_token.type == TOKEN_TYPES.COMMA then
			self:advance()
			-- Check for trailing comma (not allowed in JSON)
			if self:current_token().type == TOKEN_TYPES.RBRACKET then
				return self:error 'Trailing comma not allowed in JSON'
			end
		else
			return self:error "Expected ',' or ']' in array"
		end
	end

	return arr
end

function Parser:parse()
	local value, err = self:parse_value()
	if err then
		return nil, err
	end

	-- Ensure we've consumed all tokens except EOF
	if self:current_token().type ~= TOKEN_TYPES.EOF then
		return self:error 'Unexpected token after JSON value'
	end

	return value
end

-- Public API
function json_parser.parse(json_string)
	if type(json_string) ~= 'string' then
		return nil, {
			message = 'Input must be a string',
			offset = 1,
			line = 1,
			column = 1,
		}
	end

	-- Lexical analysis
	local lexer = Lexer.new(json_string)
	local tokens, lex_err = lexer:tokenize()
	if not tokens then
		return nil, lex_err
	end

	-- Parsing
	local parser = Parser.new(tokens)
	local result, parse_err = parser:parse()
	if not result and parse_err then
		return nil, parse_err
	end

	return result
end

return json_parser
