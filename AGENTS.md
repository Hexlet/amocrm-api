# Repository Guidelines

- Api reference: `https://www.amocrm.ru/developers/content/crm_platform/api-reference`

## Project Structure & Module Organization

- `main.tsp` is the TypeSpec entrypoint that defines the AmoCRM API surface.
- `tspconfig.yaml` contains the TypeSpec compiler configuration.
- `tsp-output/schema/openapi.yaml` is the generated OpenAPI output (do not hand-edit; regenerate from TypeSpec).
- `package.json` pins TypeSpec tooling dependencies used for generation.
- `.github/workflows/` contains CI automation for schema generation or publication (if applicable).

## Build, Test, and Development Commands

- `make setup` installs dependencies via `pnpm install`.
- `make compile-openapi` runs `pnpm exec tsp compile .` to generate `tsp-output/schema/openapi.yaml`.
- `make update` updates dependencies (`ncu -u` + `pnpm update`) — use sparingly and verify generated output.
- `make publish` triggers the `stl` publish flow for the generated spec (requires the `stl` CLI and credentials).

## Coding Style & Naming Conventions

- Use consistent TypeSpec conventions in `main.tsp`: stable resource naming, clear operation names, and consistent model/enum casing.
- Keep changes minimal and explicit; avoid reformatting unrelated sections.
- Prefer adding short, focused comments only when a TypeSpec construct is non-obvious.

## Testing Guidelines

- There is no automated test suite in this repo; validation happens through successful TypeSpec compilation and schema review.
- Before opening a PR, run `make compile-openapi` and verify the generated OpenAPI output changes are expected.

## Commit & Pull Request Guidelines

- Commit messages in this repo are short and imperative (e.g., `update schema`, `fix make publish`).
- PRs should include:
  - A brief summary of TypeSpec changes.
  - The reason for the change (API addition, fix, or refactor).
  - A note confirming `make compile-openapi` was run and that `tsp-output/schema/openapi.yaml` is updated.

## Agent-Specific Instructions

- This repository’s purpose is to generate the AmoCRM OpenAPI spec via TypeSpec; keep edits focused on `main.tsp` and generation outputs.
- Do not manually edit `tsp-output/schema/openapi.yaml`; always regenerate with TypeSpec.
