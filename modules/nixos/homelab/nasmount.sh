#!/usr/bin/env bash
set -euo pipefail

function help() {
    cat << EOF
NAME: nasmount

DESCRIPTION:
    A helper script that mounts NFS shares from a local homelab instance into
    temporary directories.
    Assumes working with TrueNAS and ZFS datasets.
    Use 'sudo umount /path/to/mountpoint' to disconnect the share after it is
    no longer needed.

SYNOPSIS:
    nasmont [OPTIONS...] dataset [mountpoint]

ARGUMENTS:
    dataset                The name of the ZFS dataset that is being mounted.
                           Note that TrueNAS NFS shares *do not* support
                           nested datasets; child datasets will show up as
                           empty directories.
    mountpoint             If specified, mounts to this (existing) path.
                           If omitted, defaults to '/tmp/nasmount/$dataset'
                           and is autocreated.

OPTIONS:
    -h, --help             Print this message and exit.
    -r, --read-only        Mount the share as read only.
    -s <arg>, --host=<arg> Change the hostname (or IP) of the NAS server.
                           Default is 'nas'.

EXAMPLE:
    nasmount -r vault
    is equivalent to
    sudo mount -t nfs \
      -o 'nfsvers=4.2,proto=tcp,_netdev,fg,hard,defaults,noatime,ro' \
      'nas:/mnt/vault' '/tmp/nasmount/vault'
EOF
    exit 0
}

host='nas'
readonly='rw'
mkdir=''
dataset=''
source=''
target=''

options=$(getopt -n nasmount -o 'hrs:' -l 'help,read-only,host:' -- "$@")
eval set -- "$options"

while [ -n "${1+set}" ]; do
    case "$1" in
        -h|--help)
            help;;
        -r|--read-only)
            readonly='ro'; shift;;
        -s|--host)
            host="$2"; shift 2;;
        --)
            shift; break;;
        *)
            exit 1;;
    esac
done

if [ -n "${1+set}" ]; then
    dataset="$1"
    source="$host:/mnt/$dataset"
    shift
else
    echo 'Dataset to mount was not specified.' >&2
    exit 1
fi

if [ -n "${1+set}" ]; then
    target="$1"
    shift
else
    target="/tmp/nasmount/$dataset"
    mkdir=1
fi

sudo mount -t nfs \
  -o "nfsvers=4.2,proto=tcp,_netdev,fg,hard,defaults,noatime,$readonly" \
  ${mkdir:+--mkdir} \
  "$source" "$target"
