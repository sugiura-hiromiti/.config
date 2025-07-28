layout=$(yabai -m query --spaces --space | jq '.type')

if [ ${layout} = '"bsp"' ]; then
	yabai -m window --focus prev || yabai -m window --focus last
elif [ ${layout} = '"stack"' ]; then
	yabai -m window --focus stack.prev || yabai -m window --focus stack.last
elif [ ${layout} = '"float"' ]; then
	focused_window_index=$(yabai -m query --windows --space | jq 'map(."has-focus") | index(true)')
	window_count=$(yabai -m query --windows --space | jq 'to_entries[] | select(.value["has-focus"]) | .key')
	focused_window_index=$((focused_window_index-1))

	if [ ${focused_window_index} -eq -1 ]; then
		yabai -m window --focus $(yabai -m query --windows --space | jq ".[$((window_count - 1))].id")
	else
		yabai -m window --focus $(yabai -m query --windows --space | jq ".[${focused_window_index}].id")
	fi
fi
