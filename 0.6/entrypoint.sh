#!/bin/bash

set -e

datadir="/home/lightning/data"

echo $(echo "$1" | cut -c1)

# If this script is called only with flags,
# We default to just using the lnd binary
if [[ $(echo "$1" | cut -c1) = "-" ]]; then
  echo "$0: Assuming arguments for lnd"

  set -- lnd "$@"
fi

if [[ $(echo "$1" | cut -c1) = "-" ]] || [[ "$1" = "lnd" ]]; then
  echo "Creating data directory ..."
  mkdir -p "$datadir"
  chmod 700 "$datadir"
  chown -R lnd "$datadir"

  echo "$0: setting data directory to $datadir"

  set -- "$@" -datadir="$datadir"
fi

if [[ "$1" = "lnd" ]] || [[ "$1" = "lncli" ]] ; then
  exec su-exec lightning "$@"
fi

                 

exec "$@"
