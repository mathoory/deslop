# prose-lint

Catch AI-writing tells in docs, reports and READMEs, in any repo, on Linux or Windows.

`delint <files>` runs [Vale](https://vale.sh) with three rule sets, then the
[proselint](https://github.com/amperser/proselint) CLI:

| Style | Source | What it catches |
|---|---|---|
| `ai-tells` | [tbhb/vale-ai-tells](https://github.com/tbhb/vale-ai-tells) (fetched by `vale sync`) | AI vocabulary, staccato sentences, contrast-by-negation, stock headings |
| `proselint` | Vale's proselint package (fetched by `vale sync`) | clichés, corporate speak, redundancy |
| `Claudisms` | ours, `styles/Claudisms/`, based on [claudisms.ai](https://claudisms.ai) | phrases, words and metaphors from that list that ai-tells misses, plus em-dashes |

## Setup (once per machine)
Requirements: [Vale](https://vale.sh/docs/install), plus optionally `pip install proselint`.

```bash
git clone https://github.com/mathoory/prose-lint.git
./prose-lint/install.sh            # Linux / macOS / Git Bash
```
```powershell
.\prose-lint\install.ps1           # Windows PowerShell
```
The installer:
1. Downloads the published styles.
2. Sets `VALE_CONFIG_PATH` to this repo's `.vale.ini`, so a plain `vale <file>` uses it anywhere.
3. Adds a `delint` command to your shell.

## Use
```bash
delint README.md docs/            # files or folders; exit code 1 if anything was flagged
vale sync                         # update the published styles
```
In a repo that has its own `.vale.ini`, plain `vale` uses that file. `delint` always uses this repo's config.

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
