#!/bin/bash
#
# uninstall-user.sh

BINDIR="/home/steam/bin"
DATADIR="/home/steam/.local/share/asamanager"

for f in "${BINDIR}/asamanager" \
         "${DATADIR}/uninstall.sh"
do
  if [ -f "$f" ]; then
    rm "$f"
  fi
done
