#!/usr/bin/env bash
# BastiaOS environment validation — checks the host tooling required to build.
set -euo pipefail

fail=0
ok()   { printf '  ok    %s\n' "$1"; }
bad()  { printf '  FAIL  %s\n' "$1"; fail=1; }
warn() { printf '  warn  %s\n' "$1"; }

echo "== BastiaOS environment check =="

check_cmd() {
    local name="$1" required="${2:-yes}"
    if command -v "$name" >/dev/null 2>&1; then
        ok "$name ($(command -v "$name"))"
    elif [[ "$required" == "yes" ]]; then
        bad "$name not found"
    else
        warn "$name not found (optional)"
    fi
}

# lint tools and bats run inside the builder image, not on the host
for c in git docker make python3 curl; do
    check_cmd "$c" yes
done
for c in shellcheck bats; do
    check_cmd "$c" no
done

echo "-- docker daemon --"
if docker info >/dev/null 2>&1; then
    ok "docker daemon reachable ($(docker version --format '{{.Server.Version}}' 2>/dev/null || echo '?'))"
else
    bad "docker daemon not reachable"
fi

echo "-- virtualization (lab, STEP 04) --"
if [[ -w /dev/kvm ]]; then
    ok "/dev/kvm writable"
else
    warn "/dev/kvm not writable — needed for KVM acceleration in STEP 04"
fi
if command -v qemu-system-x86_64 >/dev/null 2>&1; then
    ok "qemu-system-x86_64 ($(qemu-system-x86_64 --version | head -1 | awk '{print $NF}'))"
else
    warn "qemu-system-x86_64 not found"
fi
if compgen -G /usr/share/OVMF/OVMF_CODE_4M*.fd >/dev/null; then
    ok "OVMF firmware present"
else
    warn "OVMF firmware not found"
fi

echo "-- python/pip --"
if python3 -m pip --version >/dev/null 2>&1; then
    ok "pip available"
else
    warn "system pip missing — docs target uses python3 -m venv"
fi

if [[ "$fail" -ne 0 ]]; then
    echo "== environment check FAILED =="
    exit 1
fi
echo "== environment check passed =="
