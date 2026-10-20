---
name: de-ai
description: Find and fix AI-writing tells in prose (READMEs, docs, reports, HTML pages) using the prose-lint repo (Vale with ai-tells, proselint and the custom Claudisms style, plus the proselint CLI). Use when the user asks to de-AI text, remove AI tells or claudisms, or run vale / proselint on writing.
---

# de-ai

1. **Find prose-lint.** It's usually `C:\Workspace\prose-lint`. Otherwise ask the user where it is, or clone https://github.com/mathoory/prose-lint into a temporary folder. Don't install anything.
2. **Read its `CLAUDE.md`.** It holds the rules for fixing hits and for leaving false positives alone.
3. **Run the script on the files the user named.** If they named none, run it on the repo's prose files: `*.md` and visible-text HTML, skipping generated and vendored files.
   - Bash: `bash "<prose-lint>/delint" <files>`
   - PowerShell: `& "<prose-lint>\delint.ps1" <files>`
4. **Rewrite the real hits and re-run.** If text comes from a generator (a script or template), fix it there and regenerate.
5. **Report:** what changed (before → after), the hits you left as false positives and why, and anything the user should decide.
