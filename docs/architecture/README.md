# BastiaOS Architecture

This document describes the high-level architecture of BastiaOS. The architecture is still under investigation and subject to change based on Architecture Decision Records (ADRs).

## System Overview

BastiaOS follows a layered architecture approach, with each layer building upon the foundation provided by the layers below it. This modular design allows for independent development and testing of components.

## Architecture Layers

```
┌─────────────────────────────────────────────────────────────┐
│                     Applications                            │
│                  (Flatpak + Native)                         │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│                    Desktop Environment                       │
│                  (Wayland Compositor)                        │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│                      Graphics Stack                           │
│            (Display Server + Drivers + Libraries)            │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│                    System Services                            │
│              (Systemd + Daemons + Services)                  │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│                      Userspace                               │
│           (GNU Tools + Core Utils + Libraries)               │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│                   Root Filesystem                            │
│            (Directory Structure + System Files)             │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│                      Initramfs                               │
│              (Early Boot + Hardware Detection)               │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│                      Bootloader                              │
│           (GRUB/systemd-boot + EFI/MBR Support)             │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│                   Linux Kernel                               │
│           (Custom Configuration + Drivers)                   │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│                      Toolchain                               │
│           (Cross-compilation + Build Tools)                  │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│                    Build System                              │
│       (Buildroot/Yocto/LFS/Custom - TBD in ADR-0001)        │
└─────────────────────────────────────────────────────────────┘
```

## Layer Descriptions

### Build System
The foundation layer that defines how the entire system is built. This includes the build system choice (to be determined in ADR-0001), which will manage the compilation and assembly of all components.

**Status**: TBD - See ADR-0001

**Considerations**:
- Reproducible builds
- Cross-compilation support
- Dependency management
- Build time optimization

### Toolchain
The cross-compilation toolchain used to build all components of the system. This ensures consistent builds across different development environments.

**Status**: TBD

**Considerations**:
- GCC vs Clang
- Cross-compilation targets
- Standard library support
- Binary compatibility

### Linux Kernel
The heart of the operating system. A customized Linux kernel with essential drivers and optimizations for BastiaOS.

**Status**: TBD

**Considerations**:
- Kernel version selection
- Driver inclusion strategy
- Custom patches
- Security hardening
- Performance tuning

### Bootloader
The first program that runs when the system boots, responsible for loading the kernel and initramfs.

**Status**: TBD

**Considerations**:
- GRUB vs systemd-boot
- EFI vs MBR support
- Secure Boot compatibility
- Boot configuration management

### Initramfs
A temporary root filesystem that is loaded into memory during the boot process. It handles early boot tasks and hardware detection before the real root filesystem is mounted.

**Status**: TBD

**Considerations**:
- Size optimization
- Essential tools and modules
- Hardware detection
- Encryption support

### Root Filesystem
The permanent filesystem structure that contains all system files, user data, and applications.

**Status**: TBD

**Considerations**:
- Filesystem type (ext4, btrfs, xfs)
- Directory hierarchy (FHS compliance)
- Read-only vs writable areas
- Snapshot support

### Userspace
The collection of programs and libraries that run in user mode, providing the core functionality of the system.

**Status**: TBD

**Considerations**:
- GNU core utilities
- System libraries (glibc/musl)
- Essential tools
- Shell selection

### System Services
Background services and daemons that manage system functions, networking, and other essential tasks.

**Status**: TBD

**Considerations**:
- Init system (systemd vs alternatives)
- Service management
- Logging infrastructure
- Network management

### Graphics Stack
The software and drivers responsible for rendering graphics and managing display output.

**Status**: TBD

**Considerations**:
- Wayland vs X11 (Wayland preferred)
- Display server choice
- Graphics drivers (Mesa, proprietary)
- Hardware acceleration

### Desktop Environment
The graphical user interface that users interact with, built on top of the graphics stack.

**Status**: TBD

**Considerations**:
- DE choice (GNOME, KDE, custom)
- Integration with Wayland
- Resource usage
- Customization options

### Applications
The software that users run on the system, including both native packages and Flatpak applications.

**Status**: TBD

**Considerations**:
- Flatpak integration
- Native package management
- Application sandboxing
- Update management

## Key Architectural Principles

1. **Modularity**: Each layer should be independent and replaceable
2. **Reproducibility**: All builds must be reproducible from source
3. **Transparency**: All decisions are documented in ADRs
4. **Simplicity**: Avoid unnecessary complexity
5. **Performance**: Optimize for fast boot and low resource usage
6. **Security**: Implement security best practices at each layer

## Open Questions

The following architectural decisions are still under investigation:

- **Build System**: Which build system to use? (See ADR-0001)
- **Init System**: systemd or alternative?
- **Filesystem**: Which filesystem type for root?
- **Desktop Environment**: Which DE to include?
- **Package Management**: Native packages vs Flatpak-only?
- **Graphics Stack**: Specific compositor and driver choices

## Related Documentation

- [Architecture Decision Records](../decisions/)
- [Development Workflow](../development/)
- [Testing Strategy](../testing/)

## Version History

- v0.1 - Initial architecture document (pre-investigation phase)