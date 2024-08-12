#!/usr/bin/env bash
# ---------------------------------------------------------------------------------------------------------------------
# SNIP
#
# Wrapper script that handles the generic use-case of taking screenshots.
# By default, it captures the whole screen and saves it in the designated screenshot directory.
# Also displays a notification if successful.
#
# Available arguments:
# -s : Allows the user to select a specific region. Takes precedence over -w.
# -w : Makes a snip of the currently focused window.
# -a : Allows the image to be edited before saving.
# -c : Copies the image to clipboard rather than saving it to disk.
# ---------------------------------------------------------------------------------------------------------------------

# Bound variables.
ALTERATION=0 # Should the snip be edited.
CLIPBOARD=0 # Should the snip be pasted to clipboard.
SELECTION=0 # What to screenshot, 0 for screen, 1 for region, 2 for window.
WINDOW=0    # If the user requested a window.
LOCATION="" # Where the final snip will go.

# Parse arguments.
while getopts "acsw" OPTION; do
  case $OPTION in
  a) ALTERATION=1 ;;
  c) CLIPBOARD=1 ;;
  s) SELECTION=1 ;;
  w) WINDOW=1 ;;
  *) exit 1 ;;
  esac
done

if [[ "$SELECTION" != "1" && "$WINDOW" == "1" ]]; then
  SELECTION=2
fi

# Screenshot will be saved to a file regardless, so it can be displayed in the notification.
TMP_FILE=$(mktemp /tmp/snip.XXXXXX)
trap 'rm $TMP_FILE' EXIT

# Take the screenshot.
case "$SELECTION" in
  '0')
    OUTPUT=$(hyprctl -j monitors | jq -r '.[] | select(.focused == true) | .name')
    grim -o "$OUTPUT" "$TMP_FILE" || exit 2
    ;;
  '1')
    grim -g "$(slurp)" "$TMP_FILE" || exit 2
    ;;
  '2') 
    WINDOW=$(hyprctl -j activewindow)
    [ "$WINDOW" == "{}" ] && exit 2
    grim -g "$(echo "$WINDOW" | jq '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | tr -d '"')" "$TMP_FILE" || exit 2;
    ;;
esac

# Alter if necessary.
[ "$ALTERATION" == "1" ] && swappy -f "$TMP_FILE" -o "$TMP_FILE"

# Move the image to the destination, either clipboard or screenshots dir.
if [ "$CLIPBOARD" == "1" ]; then
  LOCATION="Clipboard"
  wl-copy --type image/png < "$TMP_FILE"
else
  LOCATION="$(xdg-user-dir SCREENSHOTS)"
  LOCATION="${LOCATION:="${XDG_PICTURES_DIR:-$HOME}"}/snip-$(date +%s).png"
  cp "$TMP_FILE" "$LOCATION"
fi

# Send a notification to confirm screenshot was successful.
notify-send \
  --app-name='snip' \
  --urgency='low' \
  --icon="$TMP_FILE" \
  --expire-time=5000 \
  "Screenshot Saved!" \
  "<i>$LOCATION</i>"
