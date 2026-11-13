---
name: tuicr
description: Run a local code review with tuicr, the user's only local reviewer -- launch the TUI for the user (own tmux window, or a one-liner handoff without tmux), then read their comments back through the `tuicr review` JSON CLI and act on them. Use whenever work is committed or finished but not yet pushed (start the review in the same turn, without asking whether or which tool), when the user asks for a local review or to "review this in tuicr", or when they say a tuicr review is done and comments should be picked up.
user-invocable: true
---

# tuicr — local code review in the terminal

The user's local code reviewer. Repo: https://github.com/agavra/tuicr.
Upstream ships its own agent instructions (`skills/tuicr/SKILL.md` in that repo); this skill
replaces them, correcting the parts that don't fit this harness. Don't install upstream's.

If tuicr came from a system package manager, update it through that package manager, never
`tuicr update` -- the self-updater rewrites a binary the package manager owns. Upstream's wrapper
scripts aren't needed; refer to the launch recipes below.

## The two halves

- The **TUI** is the user's. They navigate the diff, press `c` to comment, `r` to mark a file
  reviewed, `q` to quit.
- `tuicr review` is **mine**. Three subcommands — `list`, `comments`, `add` — all printing pretty
  JSON to stdout and nothing else. There is no `--json` flag and no other format.

No push stream exists from the TUI to me. I poll `tuicr review comments`. The TUI persists its
session file as soon as a target becomes active, so the comments are readable *while* it is open.

Two stderr markers matter, both outside the alternate screen:

```
tuicr-session: <owner>/<repo>@<branch>/worktree       # at startup, names the slug
tuicr-summary: reviewed 3/3 files, 2 comments added   # on exit, always, even at zero comments
```

Redirecting stderr to a file at launch is the reliable way to get the slug and to detect exit.
Don't parse the pane instead.

## Launching it

Decide by whether **my own** Bash environment has `$TMUX`. A session started directly in a
terminal window has it unset; one running inside a tmux pane has it set. Check, don't assume.

### Inside tmux

Give it its own **tmux window**, never a split -- the TUI is much easier to read at full terminal
height. Don't use upstream's `tuicr-wrapper.sh` either: it blocks on `tmux wait-for` until the TUI
exits, which burns a Bash call for the length of a human review and caps out at the tool timeout.

```sh
mkdir -p /tmp/artifacts; log=/tmp/artifacts/tuicr-<slug>.log
me=$(tmux display-message -p -t "$TMUX_PANE" '#{session_name}')
win=$(tmux new-window -d -t "$me:" -n tuicr -P -F '#{window_id}' -c "$repo" \
  "cd '$repo' && tuicr -w 2> '$log'")
tmux select-window -t "$win"
```

- `-t "$me:"` is mandatory. Without a target, `new-window` uses the most recently active session,
  which is whatever session the user touched last, not mine. Hit 2026-10-01: the window landed in
  another agent-deck session and the user could not find it. `$TMUX_PANE` names my own pane, so
  `display-message -t "$TMUX_PANE"` resolves my session, not the user's.
- **Check `$TMUX_PANE` is set in the same call, every time.** It can disappear mid-session: after a
  session fork, my Bash ran under a detached parent with `$TMUX` and `$TMUX_PANE` unset. Then
  `-t ""` resolves to the user's active session, and the window lands in the wrong place again (hit
  2026-10-02). If it is unset, use the sections below instead. For an agent-deck session,
  `agent-deck list --json` maps the session title to its tmux session (`agentdeck_<title>_<id>`);
  match the title the user knows, not `$AGENTDECK_INSTANCE_ID`, which can name a different session
  after a fork.
- `-d` keeps the new window from stealing focus while it is being created, then `select-window`
  hands the user the review deliberately. No size arithmetic is needed, which also sidesteps the
  `split-window -p <percent>` "size missing" error that hits every TTY-less call I make.
- `-n tuicr` labels the window so the user can find it in the status line, and so the
  already-running check below has something obvious to match.
- The agent pane keeps its full height and stays where it was; the user switches windows to
  review and the window disappears on `q`, dropping them back.
- Scope is mandatory. `-w` for uncommitted work, `-r <revset>` for a range (`-r main..HEAD`),
  `pr <n>` for a GitHub PR, `--file <path>` for a file outside VCS or untracked. Passing nothing
  drops the user on the target selector, which is a worse handoff than picking for them.
- If new windows land in `/` or fail to start in the right directory, the tmux server's own cwd
  may have been deleted (common after worktree cleanup):
  `readlink /proc/$(tmux display-message -p '#{pid}')/cwd` ending in `(deleted)` confirms it.
  Every new pane inherits the dead cwd; the fix is restarting the server from `$HOME`, which is
  the user's call.
- Already running? `tmux list-panes -a -F '#{pane_current_command}' | grep -qx tuicr`. One repo can
  hold two sessions at once (a worktree one and a range one), and adding to the wrong one exits 0.

Reading the slug back:

```sh
grep -m1 '^tuicr-session:' "$log" | cut -d' ' -f2
```

Exit shows up in the same file as a `tuicr-summary:` line.

**Arm an exit watcher in the same turn as the launch.** Nothing wakes me when the user quits the
TUI, so without a watcher I learn about a finished review only when I happen to check. Right
after creating the window, run a Bash call with `run_in_background: true`:

```sh
until grep -q '^tuicr-summary:' "$log"; do sleep 2; done; grep '^tuicr-summary:' "$log"
```

It exits when the user quits, and the completion notification carries the summary line. Then read
the comments and act on them. Use `run_in_background`, not `Monitor`: one notification, not a stream.

### Not inside tmux, but launched from it

A background job (for example one spawned from a tmux-hosted `claude agents` view) can have
`$TMUX` unset while its launcher ran in tmux. Walk up the process tree to the first ancestor whose
environment has `TMUX_PANE` (`tr '\0' '\n' < /proc/<pid>/environ`). If that pane still exists
(`tmux display-message -p -t <pane> '#{session_name}'`), create the window in that session with
`-t "<session>:"` and keep `-d` without `select-window`, so the view the user is watching isn't
yanked away. Tell them the window index.

### No tmux at all

I cannot start the TUI. It needs a real terminal, so `!`-prefixed or Bash-tool invocation is out —
both are TTY-less and the TUI will not render. Hand over the one-liner and wait:

> Run `tuicr -w 2> /tmp/artifacts/tuicr-<slug>.log` in `<path>`, review, then quit. I'll pick the
> comments up from here.

Then find the session with `tuicr review list --repo <path>` and look for `"active": true`.

## Reading the review

```sh
tuicr review list --repo /path/to/repo     # that checkout's local sessions + its repo's PR sessions
tuicr review list --repo owner/repo        # every local and PR session for that forge repo
tuicr review list --all                    # every session, when the repo is unclear
tuicr review comments --repo <worktree> --session <slug>   # local session: --repo is required
tuicr review comments --session <slug>     # PR slugs are self-contained; no --repo needed
tuicr review comments --session <path-to-session.json>   # when a slug is ambiguous
```

Without `--repo`, a local slug resolves against `.` and reports "was not found" even when it is
correct. Pass the worktree, or run from inside it.

Slugs are not unique. Two `--file` reviews in the same repo both get
`<owner>/<repo>@~file/worktree/file`, and looking that slug up fails. `list --all` gives each
session's JSON `path`; pass that to `--session` instead.

`[]` with exit 0 from `list` also means "not a repo root" — a subdirectory returns the same. Pass
the root before concluding nothing is open. It *also* means a finished zero-comment review:
exiting with no comments leaves no session file, so `list --repo` and `list --all` both return
`[]` moments after a genuine review and the `tuicr-summary:` line is the only record. Log stderr
to a file at launch or that record is gone.

Comment JSON carries `id`, `path`, `start_line`, `end_line`, `side`, `comment_type`, `author`,
`lifecycle_state`, `content`. Act on `comment_type`: `issue` blocks, `suggestion` gets implemented
or answered, `note` gets acknowledged, `praise` needs nothing. `none` (untyped) gets read on its
merits; treat it as a request unless it plainly isn't one.

Poll about every 30s while a review is open, comparing `id`s against the previous read. Read
immediately when the user says they're done, and re-read once more before claiming the work is
finished, in case they kept going while I worked.

Empty is not automatically suspicious: if every changed file is marked reviewed, zero comments is
a real "nothing to flag" — treat the review as complete and don't ask. Only ask when files are
left unreviewed or no `tuicr-summary:` line ever appeared.

`file_count` is not the changed-file count, so it is a weak signal. On a three-file
`-r origin/main..HEAD` range the summary read `reviewed 3/4 files` with every real file marked —
tuicr counts an extra entry that `git diff --name-only` does not list. Compare `reviewed_count`
against `git diff --name-only <revset>` rather than against `file_count`, and when they agree
treat the review as complete.

## Reconstructing the diff

To review a patch myself, or to map a comment's line back to code, rebuild the diff the user sees.
The slug's source segment says which:

| Slug segment | Diff |
|---|---|
| `worktree/<head>`, `staged-and-unstaged/<head>` | `git diff HEAD` |
| `staged/<head>` | `git diff --cached` |
| `unstaged/<head>` | `git diff` |
| `commits/<base>..<head>` | `git diff <base>~1..<head>` |
| `pr/<n>` | `gh pr diff <n>` |
| `pristine` | none; every tracked file shown in full |

Range endpoints are inclusive and printed oldest-first, so `<base>` without `~1` drops the first
commit and shifts every line number derived from it. Check the file list with `--name-only` on
the same range; per the note above, don't expect it to match `file_count` exactly.

## Writing comments

In a user-led review of code I wrote: don't. No self-review comments, no impersonating the user.

For an agent review the user asked for, `tuicr review add --repo <worktree> --session <slug>
--target-file <path> --line <n> --side new --type issue --username Claude "<text>"`. Omit
`--target-file` for a review-level comment, add `--end-line` for a range, `--side old` for removed
lines. `--repo` follows the same rule as `comments`: required for a local slug, not for a PR slug
or a session JSON path. `--type` defaults to `none`, so pass it.

For structured input, `--input` takes literal JSON, `@file.json`, or `-` for stdin. One object per
call (an array is a parse error), the file key is `file` not `path`, and the target type is
inferred from which fields are present:

```sh
tuicr review add --repo <worktree> --session <slug> --username Claude --input \
  '{"file":"src/main.rs","line":42,"side":"new","comment_type":"issue","content":"Handle the empty case."}'
```

Then verify by re-reading `comments`: a line outside the diff stores, echoes back, and exits 0
while never rendering — successful-looking to me, invisible to the user. Check each `start_line`
exists on the side given, and keep the returned `id`s to tell my comments apart in later reads.

## What this workflow does not have

- **No browser tab, no port, no server.** Nothing to open for the user and nothing to clean up;
  the tmux window closes when the user presses `q`.
- **No resolve step.** Nothing marks a comment resolved from the CLI side -- `lifecycle_state` is
  read-only there. Report what I addressed in chat instead.
- **Don't ask for a paste.** `y` inside the TUI copies to the *tmux buffer* when `$TMUX` is set,
  not the system clipboard. The CLI is the transport; the clipboard/`--stdout` export is a
  fallback for when it isn't.
