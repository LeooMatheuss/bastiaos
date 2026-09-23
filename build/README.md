# Buildroot for BastiaOS

This directory contains the Buildroot build system configured for BastiaOS.

## Quick Start

```bash
# Download and setup Buildroot
cd /path/to/bastiaos
./scripts/setup-buildroot.sh

# Configure Buildroot
cd build/buildroot
cp ../configs/bastiaos_defconfig .config

# Customize configuration (optional)
make menuconfig

# Build the system
make -j$(nproc)

# Test in QEMU
qemu-system-x86_64 \
    -kernel output/images/bzImage \
    -drive file=output/images/rootfs.ext2,format=raw \
    -append "root=/dev/sda console=ttyS0" \
    -nographic \
    -m 512M
```

## BastiaOS-Specific Files

### Configuration Files
- `configs/bastiaos_defconfig` - Main Buildroot configuration for BastiaOS
- `linux/bastiaos.config` - Linux kernel configuration
- `package/busybox/bastiaos.config` - BusyBox configuration
- `package/busybox/bastiaos.mk` - BusyBox build customization

### Key Features
- Target: x86_64
- Toolchain: Buildroot with glibc
- Init system: systemd
- Kernel: Latest stable Linux kernel
- Bootloader: GRUB2
- Filesystem: ext4

## Output Files

After successful build, the main output files are in `build/buildroot/output/images/`:
- `bzImage` - Compressed kernel image
- `rootfs.ext2` - Root filesystem
- `rootfs.tar` - Root filesystem tarball
- `sdcard.img` - Complete SD card image (if configured)

## Customization

### Adding Packages
Edit `configs/bastiaos_defconfig` and add package selections:
```
BR2_PACKAGE_<PACKAGE_NAME>=y
```

### Kernel Configuration
Edit `linux/bastiaos.config` to customize kernel options.

### System Configuration
Modify system settings in `configs/bastiaos_defconfig`:
- `BR2_TARGET_GENERIC_HOSTNAME` - System hostname
- `BR2_TARGET_GENERIC_ISSUE` - Login banner
- `BR2_TARGET_GENERIC_ROOT_PASSWD` - Root password

## Development Workflow

1. Make configuration changes
2. `make menuconfig` to verify
3. `make -j$(nproc)` to build
4. Test in QEMU
5. Commit configuration changes
6. Document decisions in ADRs

## References

- [Buildroot Documentation](https://buildroot.org/docs.html)
- [BastiaOS Buildroot Setup](../docs/development/buildroot-setup.md)
- [ADR-0001: Build System Selection](../docs/decisions/ADR-0001-build-system.md)