# yabai and skhd helper function
# Add this to your .zshrc or .bashrc
  n=$1  # Takes the target index as an argument
  current_index="$(yabai -m query --spaces --display | jq 'map(select(."is-native-fullscreen" == false))[-1].index')"

  if [ "$current_index" -ge "$n" ]; then
      yabai -m window --space "${n}"
      yabai -m space --focus "${n}"
  else
      yabai -m space --create
      focus_index="$(yabai -m query --spaces --display | jq 'map(select(."is-native-fullscreen" == false))[-1].index')"
      yabai -m window --space "${focus_index}"
      yabai -m space --focus "${focus_index}"
  fi

