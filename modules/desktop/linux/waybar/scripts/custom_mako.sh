#!/usr/bin/env bash
set -euo pipefail
#----------------------------------------------------------------------------------------------------------------------
# Mako Status
# Helper command for the `custom/mako` waybar module, acts like two scripts in one.
# If called with `toggle` as the first argument, toggles 'Do Not Disturb' mode, hiding and suppressing notifications.
# Otherwise, it returns the JSON status for the module.
#----------------------------------------------------------------------------------------------------------------------

is_dnd=1
makoctl mode | grep -q 'do-not-disturb' || is_dnd=0

if [ "${1:-}" = "toggle" ]; then
  opt=$(if [ "$is_dnd" = 1 ]; then echo '-r'; else echo '-a'; fi)
  makoctl mode "$opt" 'do-not-disturb' >/dev/null
  pkill -SIGRTMIN+1 waybar
  exit 0
fi

notification_count=$(\
  busctl --json=short --user call org.freedesktop.Notifications /fr/emersion/Mako fr.emersion.Mako ListNotifications \
  | nix run nixpkgs#jq -- '.data[] | length'\
)

if [ "$is_dnd" = 1 ]; then
  tooltip="Do Not Disturb ($notification_count)"
  class='do-not-disturb'
  percentage=0
else
  if [ "$notification_count" -gt 0 ]; then
    tooltip="$notification_count New Notification(s)."
    class='alert'
  else
    tooltip='No Notifications'
    class='clear'
  fi
  percentage=100
fi

# TODO: Forgive me for this hack, find a nicer way to package this script.
# shellcheck disable=SC2016
nix run nixpkgs#jq -- --unbuffered --compact-output -n \
  --arg text "$notification_count" \
  --arg tooltip "$tooltip" \
  --arg class "$class" \
  --arg percentage "$percentage" \
  '{$text, $tooltip, $class, percentage: $percentage | tonumber}'
