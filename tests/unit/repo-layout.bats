#!/usr/bin/env bats
# Smoke tests for the repository layout and build contract.

@test "Makefile exists and defines core targets" {
  run grep -E '^(builder|lint|docs|test|validate-env):' Makefile
  [ "$status" -eq 0 ]
}

@test "builder image is pinned by digest" {
  run grep -E '^FROM ubuntu:26\.04@sha256:[0-9a-f]{64}' ci/Dockerfile.builder
  [ "$status" -eq 0 ]
}

@test "builder Dockerfile installs the required toolchain" {
  for pkg in mmdebstrap squashfs-tools xorriso shim-signed mtools; do
    run grep -qw "$pkg" ci/Dockerfile.builder
    [ "$status" -eq 0 ]
  done
}

@test "CI workflow exists and is pinned to commit SHAs" {
  run grep -q 'uses: actions/checkout@' .github/workflows/ci.yml
  [ "$status" -eq 0 ]
  run grep -E 'uses: actions/[a-z-]+@[0-9a-f]{40}' .github/workflows/ci.yml
  [ "$status" -eq 0 ]
}

@test "docs configuration is valid" {
  run test -f mkdocs.yml
  [ "$status" -eq 0 ]
  run test -f requirements-docs.txt
  [ "$status" -eq 0 ]
  run test -f docs/index.md
  [ "$status" -eq 0 ]
}

@test "license files are present" {
  run test -s LICENSE
  [ "$status" -eq 0 ]
  run test -s LICENSES/CC-BY-SA-4.0.txt
  [ "$status" -eq 0 ]
}

@test "governance documents are present" {
  for f in CONTRIBUTING.md SECURITY.md CODE_OF_CONDUCT.md TRADEMARK.md; do
    run test -s "$f"
    [ "$status" -eq 0 ]
  done
}
