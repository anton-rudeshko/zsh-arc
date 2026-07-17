# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A single-file zsh plugin (`zsh-arc.plugin.zsh`) providing aliases and functions for Yandex's `arc` VCS. Modeled on Oh My Zsh's `git` plugin — the naming scheme mirrors OMZ git aliases with `arc` substituted for `git` (e.g. `gco`→`aco`, `gcb`→`acb`). When adding an alias, check the corresponding OMZ git alias first and keep the mapping consistent.

There is no build, no test suite, no linter. Changes are made directly to `zsh-arc.plugin.zsh`.

## Conventions

- **Every alias/function starts with `a`** (for `arc`), sorted alphabetically within grouped blocks in the file.
- **`arc_current_branch`** parses `arc info` output (not `.arc` files) — reuse it, don't reimplement branch detection.
- **Shadowing:** some aliases shadow real binaries (`ab`, `ac`, `amt`). Inside alias bodies, call the real tool via `command` (e.g. `command grep`, `command xargs`) so the alias doesn't recurse into itself.
- **`awip`/`aunwip`** implement a work-in-progress commit pair; the wip commit uses `--no-verify` and `[skip ci]`.
- **Mount aliases** (`amnt`/`aumnt`/`armnt`) are conditionally defined only when `__ARC_MOUNT`/`__ARC_STORE` (or `__ARC_LANDING`) env vars are set.

## Keeping README in sync

`README.md` contains a full alias table that must be updated whenever aliases change in the plugin. The two files are expected to stay consistent.

## Local development

Load the working copy instead of the installed bundle (absolute path required):

```
antigen bundle /Users/rudeshko/dev/zsh-arc --no-local-clone
```
