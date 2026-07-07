@RTK.md

## Important

- Always use Context7 when I need library/API documentation, code generation, setup or configuration steps without me having to explicitly ask.
- Never commit changes or push code before the user explicitly asks for it.
- Never use `find` with `-exec`, `-execdir`, or `-delete`. They are hard to review by humans and easy to make serious mistakes with.
  - Do not use similar options of other commands.
  - If a command needs to be ran for each result, prefer piping it to `xargs`.
- Prefer using `jq` over single-use `python` scripts to parse JSON documents.
- Always prefer using relative paths when making changes under the current working directory.
- Never use the `-C` flag of `git` to change the directory.
- Prefer not to change the current working directory. If it's required always change back to the root of the project afterwards

## Writing Style

- All log messages must use full sentences with capital letters and periods.
  - Example: "Fetching OSM tiles." not "fetching OSM tiles".
- All comments must be written as full sentences with capital letters and periods.
  - Don't explain what the code is doing, instead explain why.
- If a context has another well-defined style, use that instead. For example, panic, expect, and error messages should be written in idiomatic Rust style (lowercase, no trailing punctuation).
  - Example: `.expect("failed to open file")`
  - Example: `panic!("index out of bounds")`
  - Example: `return Err(anyhow!("connection refused"))`
- Follow idiomatic style for git commits.
  - Check the commit message style of the repository and try to match it.
  - Summary line should never be >72 characters long and shouldn't end with period.
  - Body lines should not be >80 characters long.
