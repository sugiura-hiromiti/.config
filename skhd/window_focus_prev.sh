layout=$(yabai -m query --spaces --space | jq '.type')

if [ ${layout} = '"bsp"' ]; then
	yabai -m window --focus next || yabai -m window --focus first
elif [ ${layout} = '"stack"' ]; then
	yabai -m window --focus stack.next || yabai -m window --focus stack.first
elif [ ${layout} = '"float"' ]; then
	focused_window_index=$(yabai -m query --windows --space | jq 'map(."has-focus") | index(true)')
	window_count=$(yabai -m query --windows --space | jq 'to_entries[] | select(.value["has-focus"]) | .key')
	focused_window_index=$((focused_window_index+1))

	if [ ${focused_window_index} -eq ${window_count} ]; then
		yabai -m window --focus $(yabai -m query --windows --space | jq ".[0].id")
	else
		yabai -m window --focus $(yabai -m query --windows --space | jq ".[${focused_window_index}].id")
	fi
fi
