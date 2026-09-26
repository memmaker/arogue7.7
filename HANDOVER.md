# Advanced Rogue 7.7 — RVIP handover (2026-09-25)

Ported with the XRogue port as template (`~/Games/xrogue`, same curses shim,
X11/web frontends). Differences from XRogue that cost time:

- **Daemon/fuse arguments were `int`** but callers pass `&player` etc.: on
  arm64 the pointer was cut to 32 bits (crash in `doctor()` on the first
  turn). `daemon()`/`fuse()` now take `void *` and store `d_.varg`;
  prototypes in `rogue.h`.
- Saves: `rs_read_long/ulong` read 4 bytes into an 8-byte long (as XRogue).
  When editing `rs_read_daemons`, mind the brace-less `else` (a stray extra
  read broke every restore: "Cannot restore file").
- `mdport.c`: `md_readchar()` decodes terminal escape sequences; with the
  shim keys arrive decoded, so it returns them directly (arrows → hjkl).
  `md_gethomedir()` now prefers `$HOME` (play.sh puts saves in `save/`).
- Help list (`helpstr[]` in `rogue.c`) has no blank separators: the Enter
  menu groups by the first key of each group (`grp_start[]` in `rvip.c`).
- Tiles: `port/mktiles.py` reads monster/item names from the C tables and
  matches NetHack tiles by name (`EXTRA` aliases for the rest). The Oryx
  (Rogue PC) set covers far too few monsters for this game.
- Testing: `XROGUE_DUMP=<file>` dumps the panes; `~/Games/rvip-tools/xsend`
  sends keys to the map window. Class choice: `1`, `Escape`, `y`.
- Prompt line (RVIP step 5 / W4, 2026-09-26): the live message row is shown in a
  box over the map by `RvipWM.prompt` (rvip-wm.js). A key hides it only while
  the game waits for a command, so a question stays up until answered.
  Here: `be_prompt(r)` from `msg_refresh()` in `port/wcurses.c` (row 0 text),
  `js_key(wc_cmd_prompt)` in `port/be_web.c`; `be_x11.c` has an empty stub.
