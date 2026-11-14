# Security Policy

## Reporting a vulnerability

**Please do not open a public issue for security vulnerabilities.**

Use GitHub's private vulnerability reporting:

1. Go to the repository's **Security** tab → **Report a vulnerability** ("Private vulnerability reporting").
2. Describe the issue, affected versions and steps to reproduce.

If private reporting is unavailable, contact the maintainers through the channels in the README and ask for a secure channel before sending details.

## What to expect

- You will receive an acknowledgement as soon as the report is reviewed.
- We aim to provide a fix or mitigation before public disclosure.
- Credit is given to reporters unless you prefer to remain anonymous.

## Scope

- BastiaOS images, packages (`bastia-*`) and build pipeline.
- Configuration shipped by default (services, firewall, permissions).

Out of scope: vulnerabilities in upstream Ubuntu packages — report those to [Ubuntu security](https://ubuntu.com/security/) or the package's upstream project.

## Supported versions

| Series | Support until |
|---|---|
| 1.x "Muralha" (Ubuntu 26.04 base) | April 2029 (see [ADR-0007](docs/adr/0007-versionamento-e-suporte.md)) |

Pre-release builds are supported on a best-effort basis.

## Security update policy

- Ubuntu security updates are delivered through `unattended-upgrades` for `main`/`restricted` components.
- BastiaOS packages are rebuilt against security updates on the release schedule.
- Hardening baseline: AppArmor enforced, ufw deny-incoming, no telemetry services ([proposal](docs/architecture/proposta-arquitetura-ubuntu.md), section 3.3).
