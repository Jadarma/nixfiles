#!/usr/bin/env sh
#----------------------------------------------------------------------------------------------------------------------
# Mako Status
# Helper command for the `custom/mako` waybar module, acts like two scripts in one.
# If called with `toggle` as the first argument, toggles 'Do Not Disturb' mode, hiding and suppressing notifications.
# Otherwise, it returns the JSON status for the module.
#----------------------------------------------------------------------------------------------------------------------

DND_MODE='do-not-disturb'
makoctl mode | grep -q $DND_MODE && IS_DND=1 || IS_DND=0

if [ "$1" = "toggle" ]; then
  [ "$IS_DND" = 1 ] && OPT='-r' || OPT='-a'
  makoctl mode "$OPT" $DND_MODE >/dev/null
  pkill -SIGRTMIN+1 waybar
  exit
fi

NOTIFICATION_COUNT=$(makoctl list | nix run nixpkgs#jq -- '.data[] | length')
if [ "$IS_DND" = 1 ]; then
  TOOLTIP="Do Not Disturb ($NOTIFICATION_COUNT)"
  CLASS='do-not-disturb'
  PERCENTAGE=0
else
  PERCENTAGE=100
  if [ "$NOTIFICATION_COUNT" -gt 0 ]; then
    TOOLTIP="$NOTIFICATION_COUNT New Notification(s)."
    CLASS='alert'
  else
    TOOLTIP='No Notifications'
    CLASS='clear'
  fi
fi

# TODO: Forgive me for this hack, find a nicer way to package this script.
nix run nixpkgs#jq -- --unbuffered --compact-output -n \
  --arg text "$NOTIFICATION_COUNT" \
  --arg tooltip "$TOOLTIP" \
  --arg class "$CLASS" \
  --arg percentage "$PERCENTAGE" \
  '{$text, $tooltip, $class, percentage: $percentage | tonumber}'
