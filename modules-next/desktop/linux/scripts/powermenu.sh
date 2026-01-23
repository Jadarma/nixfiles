#!/usr/bin/env bash
# ---------------------------------------------------------------------------------------------------------------------
# POWER MENU
#
# Show a wofi prompt in for various power options.
# ---------------------------------------------------------------------------------------------------------------------

# Do not run if a wofi menu is already triggered.
if pgrep wofi; then
  >&2 echo 'Wofi already running, not interrupting menu.' 
  exit 1
fi

OPTION=$(\
  printf '🔒 Lock\n💤 Suspend\n🔌 Shutdown\n♻️ Reboot\n⚙️ UEFI\n🚪 Logout' |
  wofi --dmenu -D orientation=horizontal --lines=1 -i --cache-file=/dev/null -p "Power Options:"\
)

case "$OPTION" in
  *Suspend)  exec systemctl suspend;;
  *Shutdown) exec systemctl poweroff;;
  *Reboot)   exec systemctl reboot;;
  *UEFI)     exec systemctl reboot --firmware-setup;;
  *Lock)     exec loginctl lock-session;;
  *Logout)   exec loginctl terminate-user "$(id -un)";;
esac
