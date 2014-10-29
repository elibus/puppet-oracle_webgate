#!/bin/bash
set -e

INSTALL_LOCATION="$1"
BASEDIR="$(dirname $0)"

removeBackupDirs() {
  [ ! x"" = "$INSTALL_LOCATION/backup-Oracle*" ] && rm -fr "$INSTALL_LOCATION"/backup-Oracle*
}

removeBackupDirs
# Install binary first
PATCHINST=$(find "$BASEDIR" -type f -wholename "*binary*/patchinst")
for p in $PATCHINST; do
  cd "$(dirname $p)"
  "$p" -i -d "$INSTALL_LOCATION"
done

removeBackupDirs
# Install messages
PATCHINST=$(find "$BASEDIR" -type f -wholename "*message*/patchinst")
for p in $PATCHINST; do
  cd "$(dirname $p)"
  "$p" -i -d "$INSTALL_LOCATION"
done

