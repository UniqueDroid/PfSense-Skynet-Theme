#!/bin/sh
# SkyNet theme for pfSense – installer for Diagnostics > Command Prompt.
#
#   install / update:
#     fetch -qo - https://raw.githubusercontent.com/UniqueDroid/PfSense-Skynet-Theme/main/install.sh | sh
#   remove:
#     fetch -qo - https://raw.githubusercontent.com/UniqueDroid/PfSense-Skynet-Theme/main/install.sh | sh -s -- uninstall
#
# Only touches SkyNet*.css in /usr/local/www/css. It does not change the
# configuration – pick the theme under System > General Setup > webConfigurator.

BASE="${SKYNET_BASE:-https://raw.githubusercontent.com/UniqueDroid/PfSense-Skynet-Theme/main/css}"
DEST="${SKYNET_DEST:-/usr/local/www/css}"
FILES="SkyNet SkyNet-Green SkyNet-Red SkyNet-White"
OLD="SkyNet-Blue" # former names, removed on install and uninstall

if [ ! -d "$DEST" ]; then
	echo "ERROR: $DEST not found – is this a pfSense box?"
	exit 1
fi

if [ "${1:-install}" = "uninstall" ]; then
	for f in $FILES $OLD; do
		if [ -f "$DEST/$f.css" ]; then
			rm -f "$DEST/$f.css" && echo "removed  $DEST/$f.css"
		fi
	done
	echo "Done. If a SkyNet theme was selected, pfSense falls back to its default theme."
	exit 0
fi

fail=0
for f in $FILES; do
	tmp="/tmp/skynet-$f.$$"
	if fetch -q -o "$tmp" "$BASE/$f.css" && grep -q "SkyNet theme for the pfSense webGUI" "$tmp"; then
		mv -f "$tmp" "$DEST/$f.css" && chmod 644 "$DEST/$f.css" && echo "installed $DEST/$f.css"
	else
		rm -f "$tmp"
		echo "ERROR: could not download $BASE/$f.css"
		fail=1
	fi
done

if [ "$fail" = 0 ]; then
	for f in $OLD; do
		if [ -f "$DEST/$f.css" ]; then
			rm -f "$DEST/$f.css" && echo "removed  $DEST/$f.css (now: SkyNet)"
		fi
	done
	echo "Done. Select the theme: System > General Setup > webConfigurator > Theme > SkyNet"
fi
exit $fail
