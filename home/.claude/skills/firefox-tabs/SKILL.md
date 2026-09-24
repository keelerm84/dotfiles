---
name: firefox-tabs
description: Inspect and reorganize the user's running Firefox via the `fftabs` CLI — list open tabs across all windows, open URLs into named tab groups, move/group/close tabs, dedupe duplicate-URL tabs, manage windows, and list/restore recently-closed tabs. Use whenever the user asks to see, find, organize, clean up, group, or rearrange their Firefox tabs/windows/tab-groups, or to open a URL into a specific tab group.
---

# Firefox Tab Control (`fftabs`)

A locally-installed CLI that drives the user's **running Firefox** through a
companion WebExtension (`firefox-tab-control@mkeeler`) over a native-messaging bridge.
Source repo: `~/code/keelerm84/firefox-tab-control.git/main`.

## Preconditions

- Firefox must be **running** with the "Firefox Tab Control" extension loaded.
- If a command fails with "cannot reach the extension", Firefox isn't running or
  the extension is disabled. It's normally installed permanently as a signed XPI,
  so first have the user check `about:addons` → Extensions and enable "Tab
  Control" if it's off. (For dev iteration it can instead be side-loaded via
  `about:debugging#/runtime/this-firefox` → Load Temporary Add-on →
  `extension/manifest.json`, but a temporary add-on is dropped on restart.)

## Usage

Always pass `--json` when you need to parse output. Ids (tab/window/session)
come from `list`, `windows`, and `closed`.

```sh
fftabs list --json                      # all tabs, all windows
fftabs list --window 12 --json          # one window
fftabs windows --json                   # window summary (ids, tab counts, groups)
fftabs groups --json                    # tab groups

fftabs open <url> --window 12 --group "Work"   # PREFERRED for agents: explicit window + group
fftabs open <url> --group "Work"        # named group, but targets the FOCUSED workspace (see Notes)
fftabs open <url> --last-focused        # open in the last-focused window (skip workspace targeting)
fftabs group 5 9 13 --group "Reading"   # add existing tabs to a group
fftabs ungroup 5 9
fftabs move 5 9 --window 12             # move tabs to another window
fftabs close 5 9 13
fftabs activate 9                       # focus a tab + its window
fftabs new-window --url <url> --json    # fresh window with one tab; returns {"windowId": W}
fftabs new-window --tabs 5,9            # pull existing tabs into a new window
fftabs window 12 --state maximized      # resize/restate a window

fftabs dedupe --dry-run --json          # PREVIEW duplicate-URL removal
fftabs dedupe                           # actually close duplicates (keeps most-recent copy)
fftabs dedupe --keep first --ignore-fragment

fftabs closed --json                    # recently-closed tabs/windows
fftabs restore <sessionId>              # restore a closed session
```

## Working pattern for "reorganize my tabs"

1. `fftabs list --json` and/or `fftabs windows --json` to read current state.
2. Decide the plan and **show it to the user before destructive steps**.
3. For duplicate cleanup, run `fftabs dedupe --dry-run --json` first and confirm
   before running it for real — `close`/`dedupe` are not undoable except via
   `fftabs closed` / `restore`.
4. Apply changes with `group` / `move` / `close` / `window`.

## Notes

- **`open` targets the *currently focused* workspace — which is almost never the
  right target for an agent. Resolve your own workspace and pass `--window`.**
  Without `--window`, `open` picks the Firefox window on the virtual desktop
  focused *at the instant the command runs* (and opens a fresh window there if
  that desktop has none). That default is correct for a command the user types —
  their focus **is** that terminal — but wrong when an agent runs it in the
  background: the user is looking at some other workspace, so the tab lands
  beside an unrelated session and they have to hunt for it. Overrides:
  - `--window W` — force a specific window by id. **Use this.**
  - `--last-focused` — the old "last-focused window" behavior. Also not your
    workspace; no better than the default here.
  - Requires a supported compositor to know the focused workspace (**sway** via
    `swaymsg` today; pluggable for others). On unsupported environments `open`
    transparently falls back to the last-focused window.
- **Getting the `--window` id: run the script. Do not derive it by hand.**

  ```sh
  ~/.claude/skills/firefox-tabs/bin/my-firefox-window
  ```

  It prints one line and its exit code is the instruction:

  | Output | Exit | What to do |
  |--------|------|------------|
  | `window=<id> workspace=<name>` | 0 | `fftabs ... --window <id>` |
  | `no-firefox-window workspace=<name>` | 3 | Create a window and move it here (recipe below) |
  | `ambiguous workspace=<name> candidates=<ids>` | 4 | Ask which one — do not guess |
  | `error: <reason>` | 1 | Fix the cause or ask |

  **Any non-zero exit means stop. Never fall back to a bare `fftabs open`** — that is the
  failure this whole rule exists to prevent, and it has happened repeatedly.

  What the script does, and why it is a script rather than steps you follow: it derives the
  workspace from **the calling process's own ancestry** (`/proc/<pid>/stat` up to the terminal
  emulator), finds that terminal in `swaymsg -t get_tree`, and joins the `app_id == "firefox"`
  container on that workspace to an `fftabs` window id by active-tab title. It resolves a live
  `SWAYSOCK` itself via `pgrep -x sway`, since the inherited one is routinely stale and names a
  sway session that is gone.

  Three traps it exists to close, each of which has cost a misplaced tab:
  - **`tmux display-message -p '#{client_tty}'` follows the user.** With no `-t` target it
    returns whichever client was most recently active, so it reports a different workspace
    minute to minute as the user moves. When inside a pane, the script instead identifies *its
    own* session by matching `tmux list-panes -a -F '#{pane_pid} #{session_name}'` against its
    ancestry, then takes that session's client — and refuses if the session has no attached
    client, or clients in more than one terminal.
  - **A background job has no terminal in its ancestry at all** — it runs under a detached
    daemon. The script then reads `TMUX`/`TMUX_PANE` from the nearest ancestor's environment
    (the pane the job was launched from), refuses if that tmux server has since restarted or
    the pane is gone, and resolves the pane's session to a terminal as above. Never resolve a
    pane with `tmux display-message -t <pane>`: for a missing pane it exits 0 with an empty
    session, which tmux then resolves to its default — following the user again.
  - **A Claude session is often not inside tmux at all** (`$TMUX` unset, ancestry runs straight
    into kitty). Any tmux-first derivation is wrong from the start in that shape.
  - **`$KITTY_PID` is stale inside tmux**, and geometry cannot join sway to fftabs — every
    window is reported at `0,0` in a different coordinate space from sway's `rect`.

- **If your workspace has no Firefox window, CREATE one — never borrow another
  workspace's window.** Dropping the tab "grouped, but in some other window"
  is the exact failure the `--window` rule exists to prevent (this mistake has
  been made before). Recipe (sway):
  1. `fftabs new-window --url <url> --json` → `{"windowId": W}`. The tab id is
     the sole entry in `fftabs list --window W --json`.
  2. Firefox opens the new window on the **focused** workspace, which is still
     not yours — move it: in `swaymsg -t get_tree`, find the
     `app_id == "firefox"` container whose `name` is
     `<tab title> — Mozilla Firefox` on the focused workspace, then
     `swaymsg '[con_id=<C>] move container to workspace "<your ws name>"'`
     (workspace name from the derivation above; quoting handles spaces).
  3. A fresh window has no tab groups — create the work's group in it:
     `fftabs group <tabId> --group <name> --window W`.
  4. Tell the user a new Firefox window was created on the work's workspace.
  Only when the focused workspace already IS yours is plain
  `fftabs open --group <name>` (no `--window`) an acceptable shortcut.
- Tab groups are per-window; opening/grouping matches or creates the group in
  the target window. Moving a tab between windows (`move`, `new-window --tabs`)
  drops its group membership — re-`group` it afterward.
- `dedupe` matches on a canonicalized URL (scheme/host lowercased, trailing
  path slash ignored — `…/theme` == `…/theme/`); add `--ignore-fragment` to
  also collapse `#anchor` variants. It skips pinned tabs unless
  `--include-pinned`, and keeps the most-recently-accessed copy unless `--keep`
  says otherwise.
- Full command reference: `fftabs --help` or the repo README.
