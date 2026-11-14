# Changelog

All notable changes to BastiaOS are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Não lançado]

### Changed
- Architecture redefined around Ubuntu 26.04 LTS + Xfce 4.20 ([proposal](docs/architecture/proposta-arquitetura-ubuntu.md)).
- README rewritten without Buildroot, aligned to the new architecture (STEP 00).

### Added
- Implementation STEPs 00–19 in `docs/steps/` (STEP 00).

### Removed
- Buildroot experiment (`build/`, `scripts/setup-buildroot.sh`, `docs/development/buildroot-setup.md`), archived under the tag `archive/buildroot` (STEP 00).
- Previous implementation order S00–S49 (Debian + mkosi), superseded by the STEPs (STEP 00).
