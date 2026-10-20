# prose-lint

Catch AI-writing tells in docs, reports and READMEs, in any repo, on Linux or Windows.

`delint <files>` runs [Vale](https://vale.sh) with three rule sets, then the
[proselint](https://github.com/amperser/proselint) CLI:

| Style | Source | What it catches |
|---|---|---|
| `ai-tells` | [tbhb/vale-ai-tells](https://github.com/tbhb/vale-ai-tells) (fetched by `vale sync`) | AI vocabulary, staccato sentences, contrast-by-negation, stock headings |
| `proselint` | Vale's proselint package (fetched by `vale sync`) | clichés, corporate speak, redundancy |
| `Claudisms` | ours, `styles/Claudisms/`, based on [claudisms.ai](https://claudisms.ai) | phrases, words and metaphors from that list that ai-tells misses, plus em-dashes |

## Use
Requirements: [Vale](https://vale.sh/docs/install), plus optionally `pip install proselint`. The scripts don't install or configure anything outside this folder.

```bash
bash path/to/prose-lint/delint README.md docs/        # Linux / macOS / Git Bash
```
```powershell
path\to\prose-lint\delint.ps1 README.md docs\         # Windows PowerShell
```
- **Arguments:** files or folders.
- **Exit code:** 1 if anything was flagged.
- **First run:** downloads the published styles into `styles/` here, which git ignores.
- **Updating those styles:** `vale --config path/to/prose-lint/.vale.ini sync`

`skills/de-ai/SKILL.md` is an optional Claude Code skill. To use it in a project, copy it into that
project's `.claude/skills/de-ai/`.

## Adding rules
Add tokens to the files in `styles/Claudisms/`:

| File | Rule | Level |
|---|---|---|
| `Phrases.yml` | stock phrases | warning |
| `Vocabulary.yml` | words | suggestion |
| `Metaphors.yml` | figurative verbs | suggestion |
| `Worth.yml` | "worth X" | warning |
| `EmDash.yml` | em-dashes | error |

Tokens are case-insensitive regular expressions.

## Known false positives
- **Ranges:** en-dashes in ranges like "Jan–Feb" are allowed. ai-tells' own dash rule is turned off for that reason, and Claudisms flags only "—".
- **Names and labels:** names, quotes and data labels (merchant names, product names, code) can trigger rules. Leave them as they are.
