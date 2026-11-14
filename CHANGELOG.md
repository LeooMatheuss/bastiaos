# Changelog

All notable changes to BastiaOS are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Não lançado]

### Changed
- `main` and `develop` now require pull requests; private vulnerability reporting enabled.
- ADRs moved from `docs/decisions/` to `docs/adr/`; ADR-0001 (Buildroot) marked as superseded by ADR-0002 and ADR-0003.
- README, architecture overview and section docs aligned to the accepted ADRs.
- Architecture redefined around Ubuntu 26.04 LTS + Xfce 4.20 ([proposal](docs/architecture/proposta-arquitetura-ubuntu.md)).
- README rewritten without Buildroot, aligned to the new architecture (STEP 00).

### Added
- Build infrastructure: pinned builder image (`ci/Dockerfile.builder`, ubuntu:26.04 by digest), `Makefile` entry point, `tools/validate-env.sh`, bats unit tests, CI workflow.
- Governance: GPL-2.0 `LICENSE`, CC BY-SA 4.0 text, trademark policy, CONTRIBUTING, SECURITY, Code of Conduct, issue/PR templates.
- Documentation site: MkDocs + Material config, `requirements-docs.txt`, docs workflow publishing to GitHub Pages.
- ADRs 0002–0008: Ubuntu 26.04 LTS + Xfce base, build pipeline, snap/Flatpak policy, Calamares installer, license (GPL-2.0-or-later + CC BY-SA 4.0), versioning and support window, Launchpad PPA.
- Implementation STEPs 00–19 in `docs/steps/` (STEP 00).

### Removed
- Buildroot experiment (`build/`, `scripts/setup-buildroot.sh`, `docs/development/buildroot-setup.md`), archived under the tag `archive/buildroot` (STEP 00).
- Previous implementation order S00–S49 (Debian + mkosi), superseded by the STEPs (STEP 00).
