json="./folders.json"
# Dont use this, it is bad
jq -r 'to_entries[] | "\(.key):\(.value)"' "$json" |
while IFS=: read -r current_dir target; do
    [ ! -d "$target" ] && mkdir -p "$target"
    echo $current_dir
    echo $target
    stow -t "$target" "$current_dir"
done

