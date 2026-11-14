# Contributing to BastiaOS

Thanks for your interest in BastiaOS! This document explains how to contribute.

## Before you start

1. Read the [implementation STEPs](docs/steps/README.md) and the [architecture proposal](docs/architecture/proposta-arquitetura-ubuntu.md).
2. Check the [ADRs](docs/adr/README.md) — structural decisions require an accepted ADR before implementation.
3. Open an [issue](https://github.com/LeooMatheuss/bastiaos/issues) for bugs and feature requests so work is not duplicated.

## Branches and flow

The repository uses three long-lived branches:

- `testing` — all work lands here first.
- `develop` — receives promotions from `testing`.
- `main` — releases; accepts changes only through reviewed pull requests.

Do **not** create feature branches. Commit your changes directly on `testing` and push there.

## Developer Certificate of Origin (DCO)

BastiaOS uses the [DCO](https://developercertificate.org/) instead of a CLA. Every commit must be signed off:

```bash
git commit -s -m "your message"
```

This adds a `Signed-off-by:` line certifying you wrote the change or have the right to submit it under the project's licenses ([ADR-0006](docs/adr/0006-licenca.md)).

## Commit messages

Use [Conventional Commits](https://www.conventionalcommits.org/) without step numbers:

```
type(scope): short description

Optional body explaining why, not what.
```

Types: `feat`, `fix`, `docs`, `chore`, `build`, `test`, `refactor`, `perf`, `ci`, `style`.

Examples: `docs: add contributor guide`, `build: pin builder image by digest`, `fix: correct ufw rule ordering`.

## Code and docs

- Write compact, idiomatic code; follow the surrounding style.
- Shell scripts must pass `shellcheck`.
- Every change updates the relevant documentation **in the same commit** — a docs chapter, the CHANGELOG "Unreleased" section, or both.
- No new system service without justification; AppArmor and ufw are never disabled.
- New structural decisions need an ADR (see `docs/adr/README.md` for the template).

## Pull requests

1. Commit on `testing` and push.
2. Open a pull request from `testing` to `develop` (or `main` for releases).
3. Fill in the PR template — it is the checklist for the continuous tracks (docs, tests, security, benchmarks, ADRs).

## License

By contributing you agree that your contributions are licensed under the same terms as the component they touch — GPL-2.0-or-later for code, CC BY-SA 4.0 for documentation — per [ADR-0006](docs/adr/0006-licenca.md) and [TRADEMARK.md](TRADEMARK.md).
