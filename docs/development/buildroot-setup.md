# Buildroot Environment Setup

This document describes how to set up the Buildroot environment for BastiaOS development.

## System Requirements

- **OS**: Ubuntu 24.04 LTS (or similar Debian-based system)
- **Disk Space**: At least 10GB free space
- **RAM**: Minimum 4GB (8GB recommended)
- **CPU**: Multi-core processor recommended

## Required Dependencies

Buildroot requires several packages to be installed on the host system.

### Install Dependencies (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install -y \
    build-essential \
    git \
    wget \
    bc \
    unzip \
    rsync \
    cpio \
    sed \
    awk \
    bison \
    flex \
    texinfo \
    help2man \
    g++ \
    gawk \
    python3 \
    perl \
    libtool-bin \
    automake \
    cmake \
    ninja-build \
    pkg-config \
    libncurses5-dev \
    libssl-dev \
    libexpat1-dev \
    zlib1g-dev \
    locales
```

### Install Dependencies (Fedora/RHEL)

```bash
sudo dnf install -y \
    gcc gcc-c++ make git wget bc unzip rsync cpio \
    sed awk bison flex texinfo help2man gawk python3 perl \
    libtool automake cmake ninja-build pkg-config \
    ncurses-devel openssl-devel expat-devel zlib-devel \
    glibc-langpack-en
```

### Install Dependencies (Arch Linux)

```bash
sudo pacman -S --needed \
    base-devel git wget bc unzip rsync cpio \
    sed awk bison flex texinfo help2man gawk python perl \
    libtool automake cmake ninja-build pkg-config \
    ncurses openssl expat zlib
```

## Download Buildroot

### Clone Buildroot Repository

```bash
cd /path/to/bastiaos
mkdir -p build
git clone https://git.buildroot.net/buildroot build/buildroot
cd build/buildroot
```

### Alternative: Download Stable Release

```bash
cd /path/to/bastiaos
wget https://buildroot.org/downloads/buildroot-2024.02.2.tar.gz
tar xvf buildroot-2024.02.2.tar.gz
mkdir -p build
mv buildroot-2024.02.2 build/buildroot
cd build/buildroot
```

## Configure Buildroot

### Initial Configuration

```bash
# Copy BastiaOS configuration
cp ../configs/bastiaos_defconfig .config
```

If you want to start from a default configuration:

```bash
# For x86_64
make qemu_x86_64_defconfig

# For ARM64
make qemu_aarch64_defconfig
```

### Custom Configuration

```bash
# Open the configuration menu
make menuconfig
```

## Buildroot Configuration for BastiaOS

Key configuration options to set:

### Toolchain Options
- **Toolchain type**: External toolchain or Buildroot toolchain
- **C library**: glibc or musl (musl for smaller footprint)
- **Kernel headers**: Same as Linux kernel version

### System Configuration
- **System hostname**: bastiaos
- **System banner**: Welcome to BastiaOS
- **Init system**: systemd (as per ADR-0001)
- **Dev management**: Dynamic using devtmpfs

### Kernel Configuration
- **Linux Kernel**: Enable
- **Kernel version**: Latest stable (6.x)
- **Kernel configuration**: Custom defconfig

### Target Packages
- **BusyBox**: Enable
- **Core utilities**: Enable essential tools
- **Networking**: Enable basic networking tools
- **Graphics**: Enable Wayland components

## First Build

```bash
# Start the build process
make -j$(nproc)
```

This will:
1. Download and build the cross-compilation toolchain
2. Build the Linux kernel
3. Build and install packages
4. Create the root filesystem
5. Generate the final system image

## Build Output

After successful build, the output will be in `output/images/`:

- `bzImage` - Linux kernel image
- `rootfs.ext2` - Root filesystem image
- `rootfs.tar` - Root filesystem tarball
- `sdcard.img` - Complete SD card image (if configured)

## Testing in QEMU

### x86_64 System

```bash
qemu-system-x86_64 \
    -kernel output/images/bzImage \
    -drive file=output/images/rootfs.ext2,format=raw \
    -append "root=/dev/sda console=ttyS0" \
    -nographic \
    -m 512M
```

### ARM64 System

```bash
qemu-system-aarch64 \
    -M virt \
    -cpu cortex-a57 \
    -kernel output/images/Image \
    -drive file=output/images/rootfs.ext2,format=raw \
    -append "root=/dev/vda console=ttyAMA0" \
    -nographic \
    -m 512M
```

## Buildroot Directory Structure

```
build/
├── buildroot/      # Buildroot source code
│   ├── arch/           # Architecture-specific configurations
│   ├── boot/           # Bootloader configurations
│   ├── configs/        # Default configurations
│   ├── docs/           # Buildroot documentation
│   ├── fs/             # Filesystem generation scripts
│   ├── linux/          # Linux kernel patches and configs
│   ├── package/        # Package definitions
│   ├── support/        # Build system support files
│   ├── toolchain/      # Toolchain build scripts
│   ├── Config.in       # Main configuration file
│   ├── Makefile        # Main Makefile
│   └── output/         # Build output directory
│       ├── build/      # Package build directories
│       ├── host/       # Host tools
│       ├── images/     # Final images
│       ├── staging/    # Staging directory
│       └── target/     # Target root filesystem
├── configs/        # BastiaOS custom configurations
│   └── bastiaos_defconfig
├── linux/          # BastiaOS kernel configurations
│   └── bastiaos.config
└── package/        # BastiaOS custom packages
    └── busybox/
        ├── bastiaos.config
        └── bastiaos.mk
```

## BastiaOS Custom Integration

### Create Custom Package Directory

```bash
mkdir -p /path/to/bastiaos/build/package
```

### Add External Tree to Buildroot

In Buildroot configuration:
```
-> Location to save buildroot config
-> Overlay directories
    -> ../../overlay
```

### Create Custom Defconfig

Create `build/configs/bastiaos_defconfig`:

```
BR2_x86_64=y
BR2_TOOLCHAIN_BUILDROOT=y
BR2_TOOLCHAIN_BUILDROOT_GLIBC=y
BR2_LINUX_KERNEL=y
BR2_LINUX_KERNEL_LATEST_VERSION=y
BR2_PACKAGE_BUSYBOX=y
BR2_PACKAGE_SYSTEMD=y
BR2_TARGET_GENERIC_HOSTNAME="bastiaos"
BR2_TARGET_GENERIC_ISSUE="Welcome to BastiaOS"
BR2_TARGET_ROOTFS_EXT2=y
```

## Troubleshooting

### Build Failures

If build fails:
1. Check `output/build/<package>/.config.log`
2. Ensure all dependencies are installed
3. Try `make <package>-dirclean` and rebuild
4. Check Buildroot mailing list for known issues

### Download Issues

If downloads fail:
1. Check internet connection
2. Try manually downloading to `dl/` directory
3. Use different mirror sites in configuration

### Permission Issues

If you encounter permission issues:
```bash
sudo chown -R $USER:$USER buildroot/
```

## Next Steps

After successful build:

1. Test in QEMU
2. Customize kernel configuration
3. Add additional packages
4. Create custom initramfs
5. Integrate with BastiaOS build system

## References

- [Buildroot Official Documentation](https://buildroot.org/docs.html)
- [Buildroot User Manual](https://buildroot.org/downloads/manual/manual.html)
- [Buildroot FAQ](https://buildroot.org/FAQ.html)