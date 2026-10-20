# CLAUDE.md

Instructions for an agent asked to "de-AI" prose with this repo.

## Run it
- **Command:** `bash <this repo>/deslop <files or folders>` (Linux, macOS, Git Bash) or `<this repo>/deslop.ps1 <files or folders>` (PowerShell).
- **No installs.** Don't install packages or change shell profiles or environment variables. The script uses only this repo's config.
- **Output:** one hit per line, as `file:line:col:Style.Rule:message`. Exit code 1 means something was flagged.
- **Where:** run it on prose only (Markdown, text, HTML). In HTML, only fix visible text, not markup or scripts.

## Fix the hits
1. **Rewrite, don't delete.** Rewrite the sentence plainly and keep its meaning, numbers and facts. Don't just delete the flagged words if that leaves a broken sentence.
2. **Prefer the concrete:** state the fact, the number or the action instead of a rating or a metaphor.
3. **Leave these alone:**
   - names, quotes, product and merchant names, code, data labels, and generated files (fix the generator instead)
   - en-dash ranges ("Jan–Feb", "1–30 Nov")
   - a rule that misreads the sentence, such as a proper noun after a colon
4. **Re-run** until only the hits you deliberately left remain.
5. **Report:** tell the user what you changed (before → after) and which hits you left as false positives, and why.

## Change the rules
- **Where:** edit `styles/Claudisms/*.yml`, not the fetched `styles/ai-tells` or `styles/proselint`. Those are gitignored and get overwritten by `vale sync`.
- **Messages:** write rule messages in your own words, and use short patterns as tokens.
- **Test** a new rule on a sample file before committing.
