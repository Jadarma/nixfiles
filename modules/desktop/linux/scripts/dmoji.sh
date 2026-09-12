#!/usr/bin/env bash
# ---------------------------------------------------------------------------------------------------------------------
# EMOJI SELECTOR
#
# Opens a menu that displays all Unicode emojis and allows them to be copied to the clipboard.
# The entries are sorted by frequency and recency.
#
# Note: This functionality is already built-in to Noctalia's launcher.
#       But the frecency and better emoji metadata make this search slightly more useful.
#       Kept as A/B test.
# ---------------------------------------------------------------------------------------------------------------------

# Fetch emoji data from here and store it in a local database.
# To renew the emoji store, update the link, then delete the database and rerun the script.
URL="https://raw.githubusercontent.com/muan/emojilib/v3.0.12/dist/emoji-en-US.json"
DATA_BASE="$XDG_CACHE_HOME/dmoji.db"

if [[ ! -f "$DATA_BASE" ]]; then
  notify-send -u low "😀 Emoji Selector" "Updating emoji cache…"

  frece init "$DATA_BASE" <(\
    curl -s "$URL" | jq --raw-output '
      to_entries[]
        | .value[0] as $desc
        | {
            emoji: .key,
            description: ($desc | split("_") | map(./"" | first |= ascii_upcase | add) | join(" ")),
            tags: (.value[1:] | map(select(inside($desc) | not)))
          }
        |
          .emoji + " " + .description + if(.tags | length > 0)
            then "\t" + (.tags | join(", "))
            else ""
          end
      '\
  )
fi

# Show the menu and wait for a selection.
line=$(frece print "$DATA_BASE" | noctalia dmenu -p 'Search Emoji…')
[[ -z $line ]] && exit

# Increment entry and paste.
frece increment "$DATA_BASE" "$line"
echo -n "$line" | cut -d ' ' -f 1 | tr -d '\n' | wl-copy
