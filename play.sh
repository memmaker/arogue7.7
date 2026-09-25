#!/bin/sh
# Advanced Rogue 7.7, X11 frontend (curses shim, port/): tiled map on top,
# Messages + Status below left, Inventory right (layout in port/be_x11.c;
# override with XROGUE_MAP/_MSG/_STATUS/_INV="x,y"). Saves and scores in save/.
cd "$(dirname "$0")" || exit 1
mkdir -p save
export HOME="$PWD/save" ROGUEHOME="$PWD/save"
if [ -f save/arogue77.sav ]; then exec ./arogue77-x11 save/arogue77.sav "$@"; fi
exec ./arogue77-x11 "$@"
