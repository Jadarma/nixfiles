#!/usr/bin/env bash

function help() {
    cat << EOF
NAME: homelabconf

DESCRIPTION:
    A helper script that allows editing the homelab configs by SSH-ing into
    it, mounting the files using SSHFS, and opening them in a local editor.
    Automatically handles unmounting after editor is closed.

SYNOPSIS:
    homelabconf [OPTIONS...] [remoteAddr]

ARGUMENTS:
    remoteAddr                 Optionally specify the SSH connection string explicitly.
                               Default is 'server@homelab:/home/server/homelab'

OPTIONS:
    -h, --help                 Print this message and exit.
    -d, --mount-dir            Where on the local system should the config files be mounted.
                               By default '/tmp/homelab' is used.

EXAMPLE:
    homelabconf
    homelabconf server@homelab:/home/server/homelab
EOF
    exit 0
}

mountPoint='/tmp/homelab'
remoteAddr='server@homelab:/home/server/homelab'

options=$(getopt -n nasmount -o 'hd:r' -l 'help,mount-dir:' -- "$@")
eval set -- "$options"

while [ -n "${1+set}" ]; do
    case "$1" in
        -h|--help)
            help;;
        -d|--mount-dir)
            mountPoint="$2"; shift 2;;
        --)
            shift; break;;
        *)
            exit 1;;
    esac
done

if [ -n "${1+set}" ]; then
    remoteAddr="$1"
    shift
fi

if [ -n "${1+set}" ]; then
    echo 'Too many arguments' >&2
    exit 1
fi

cleanup () {
    echo 'Cleaning up...'
    sleep 2s
    fusermount3 -u "$mountPoint"
    [[ $mountPoint != /tmp/* ]] || rm -r "$mountPoint"
}

echo 'Mounting server configs...'
mkdir -p "$mountPoint"
sshfs -o "uid=$UID" "$remoteAddr" "$mountPoint"

trap cleanup EXIT

echo 'Opening editor...'
codium --user-data-dir "$mountPoint/.vscode/data" --log 'off' --new-window --wait  "$mountPoint"
