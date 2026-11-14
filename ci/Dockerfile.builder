# BastiaOS builder image — pinned base digest (ADR-0003)
# Rebuild note: update the digest deliberately, never by tag.
FROM ubuntu:26.04@sha256:065aa8626841f16057b78b027b464cd59c4fac36c204c72dcbf48d66f5fa8a96

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        make \
        mtools \
        mmdebstrap \
        squashfs-tools \
        xorriso \
        dosfstools \
        grub-efi-amd64-bin \
        grub-efi-amd64-signed \
        grub-pc-bin \
        shim-signed \
        shellcheck \
        bats \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

CMD ["bash"]
