#!/bin/bash
#
# uninstall.sh

BINDIR="/usr/bin"
# shellcheck disable=SC2034
DATADIR="/usr/share/asamanager"
LIBEXECDIR="/usr/libexec/asamanager"
INITSCRIPT=

if [ -f "/etc/rc.d/init.d/asamanager" ]; then
  INITSCRIPT="/etc/rc.d/init.d/asamanager"
  if [ -f "/etc/rc.d/init.d/functions" ]; then
    chkconfig asamanager off
  fi
elif [ -f "/etc/init.d/asamanager" ]; then
  INITSCRIPT="/etc/init.d/asamanager"
  if [ -f "/lib/lsb/init-functions" ]; then
    update-rc.d -f asamanager remove
  elif [ -f "/sbin/runscript" ]; then
    rc-update del asamanager default
  fi
elif [ -f "/etc/systemd/system/asamanager.service" ]; then
  INITSCRIPT="/etc/systemd/system/asamanager.service"
  systemctl disable asamanager.service
fi

if [ -n "$INITSCRIPT" ]; then
  for f in "${INITSCRIPT}" \
           "${BINDIR}/asamanager" \
           "${LIBEXECDIR}/asamanager.init" \
           "${LIBEXECDIR}/asamanager-uninstall.sh"
  do
    if [ -f "$f" ]; then
      rm "$f"
    fi
  done
fi

# remove bash_completion.d
if [ -f "/etc/bash_completion.d/asamanager" ]; then
   rm "/etc/bash_completion.d/asamanager"
fi
