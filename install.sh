json="./folders.json"

cat "$json" | jq -r 'to_entries[] | "\(.current_dir): \(.target)"' |
while IFS=: read -r key value; do
    stow -t $target $current_dir
done

