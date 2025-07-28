yabai -m window --focus "$( \
	yabai -m query --windows --space \
		| jq -re "sort_by(.id) | map(.id) | nth(index($( \
			yabai -m query --windows --window | jq '.id')) - 1) // last")"
