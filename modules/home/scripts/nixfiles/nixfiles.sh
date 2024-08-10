#!/usr/bin/env bash

# Get the location of the nixfiles dir.
# In order or priority:
# - "$NIXFILES_DIR"
# - "$XDG_REPO_DIR/nixfiles"
# - "~/repo/nixfiles"
NIXFILES_DIR="${NIXFILES_DIR:="${XDG_REPO_DIR:-"$HOME/repo"}/nixfiles"}"

if [ ! -d "$NIXFILES_DIR" ]; then
   >&2 echo 'Nixfiles dir not found!'
   exit 2
fi

# Check that direnv was allowed, otherwise we do not have the `use flake` which provides VSCodium.
if [ "$(cd "$NIXFILES_DIR" && direnv status --json | jq '.state.foundRC.allowed')" != '0' ]; then
   >&2 echo "Direnv for $NIXFILES_DIR must be allowed first."
   exit 3 
fi

# Start the editor.
# Ensure the script is run from a ZSH interactive shell, otherwise the direnv won't load.
zsh -ic "cd $NIXFILES_DIR && just code"
