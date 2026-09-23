# ADR-0001: Build System Selection

## Status

**Status**: Accepted
**Date**: 2026-09-22
**Decision Type**: Technical
**Context**: Initial Build System Evaluation

## Context

BastiaOS requires a build system that can create a complete, reproducible Linux distribution from source. The build system will be the foundation for all subsequent development, affecting build times, reproducibility, maintainability, and the overall development experience.

### Requirements

The build system must support:

1. **Reproducible Builds**: Ability to produce identical binaries from the same source
2. **Cross-compilation**: Building for multiple target architectures
3. **Modularity**: Ability to build individual components and the full system
4. **Documentation**: Well-documented build process
5. **Community Support**: Active community and long-term viability
6. **Package Management**: Efficient dependency resolution
7. **Customization**: Ability to deeply customize the system
8. **Bootstrapping**: Ability to build from scratch (if desired)

## Decision Drivers

- Development speed and iteration time
- Build reproducibility
- Learning curve for contributors
- Integration with modern development tools
- Long-term maintainability
- Community momentum and support

## Considered Options

### Option 1: Linux From Scratch (LFS)

**Description**: Build system based on the Linux From Scratch book, manually building each component from source.

**Pros**:
- Complete understanding of each component
- Maximum control over the build process
- Educational value
- No external dependencies beyond source code
- True bootstrapping from scratch

**Cons**:
- Extremely time-consuming
- High learning curve
- No automation out of the box
- Difficult to maintain and reproduce
- No built-in package management
- Slow iteration cycles
- Not designed for distribution development

**Verdict**: Not suitable for distribution development, better for learning purposes.

### Option 2: Buildroot

**Description**: A simple, efficient, and highly configurable build system for embedded Linux systems.

**Pros**:
- Fast build times
- Simple and straightforward
- Excellent for small/embedded systems
- Good reproducibility support
- Active community
- Well-documented
- Supports cross-compilation natively
- Small footprint

**Cons**:
- Primarily designed for embedded systems
- Limited package selection compared to full distributions
- Less flexible for desktop environments
- Package management is basic
- Not designed for rolling releases
- Limited graphics stack support out of the box

**Verdict**: Strong contender for base system, but may require significant work for desktop environment.

### Option 3: Yocto Project / OpenEmbedded

**Description**: A powerful build system and metadata for creating custom Linux distributions.

**Pros**:
- Industry-standard for custom distributions
- Extremely flexible and powerful
- Excellent reproducibility support
- Large ecosystem of layers
- Strong community and corporate backing
- Supports multiple architectures
- Comprehensive package management
- Professional-grade tooling

**Cons**:
- Steep learning curve
- Heavy and complex
- Long build times
- Large disk space requirements
- Can be overkill for simpler projects
- Metadata complexity
- Resource-intensive

**Verdict**: Powerful but complex. Good for professional projects but may be overkill for our initial needs.

### Option 4: Debian-based

**Description**: Use Debian as a base and customize using Debian tools (debootstrap, apt, etc.).

**Pros**:
- Massive package ecosystem
- Stable and well-tested
- Familiar to many developers
- Strong community support
- Good documentation
- Security team and updates
- Large user base

**Cons**:
- Limited customization depth
- Dependent on Debian's decisions
- Not truly built from scratch
- Reproducibility challenges
- Legacy dependencies
- Less control over system components
- "Distribution of a distribution" rather than custom distribution

**Verdict**: Good for getting started quickly, but doesn't align with our goal of building from source.

### Option 5: Alpine-based

**Description**: Use Alpine Linux as a base, focusing on musl libc and busybox.

**Pros**:
- Extremely small footprint
- Security-focused
- Simple and minimal
- Fast and efficient
- Good for containers and embedded
- Active community
- Package manager (apk) is simple

**Cons**:
- musl libc compatibility issues
- Limited package ecosystem
- Not ideal for desktop environments
- Less familiar to many developers
- May require patching for desktop use
- Limited commercial software support

**Verdict**: Excellent for servers/containers, but challenging for desktop distribution.

### Option 6: Arch-based

**Description**: Use Arch Linux tools and philosophy as a base.

**Pros**:
- Rolling release model
- Large package ecosystem (AUR)
- Simple and minimal
- Strong community
- Good documentation (Arch Wiki)
- Modern packages
- Pacman package manager

**Cons**:
- Not designed for custom distributions
- Rolling release can be unstable
- Requires constant maintenance
- Not reproducible by default
- Limited build system tools
- Dependent on Arch repositories

**Verdict**: Great user experience, but not suitable as a build system for custom distributions.

### Option 7: Custom Build System

**Description**: Build a custom build system from scratch using modern tools (make, ninja, etc.).

**Pros**:
- Complete control
- Designed exactly for our needs
- No external dependencies
- Maximum flexibility
- Educational value
- Can start simple and grow

**Cons**:
- High development effort
- Reinventing the wheel
- Limited initial functionality
- No community support
- Maintenance burden
- High risk of bugs and issues
- Slow initial development

**Verdict**: Too risky and time-consuming for initial development.

## Decision

**Selected Option**: Buildroot with Yocto compatibility layer

### Rationale

After evaluating all options, Buildroot emerges as the best choice for BastiaOS for the following reasons:

1. **Simplicity**: Buildroot is straightforward to understand and use, which aligns with our simplicity principle
2. **Speed**: Fast build times enable rapid iteration
3. **Reproducibility**: Good support for reproducible builds
4. **Educational Value**: Easier to understand the build process
5. **Growth Path**: Can integrate Yocto layers later if needed for more complex components
6. **Community**: Active community and good documentation
7. **Footprint**: Produces small, efficient systems

### Implementation Strategy

1. **Phase 1**: Use Buildroot for the base system (kernel, toolchain, core utilities)
2. **Phase 2**: Develop custom Buildroot packages for BastiaOS-specific components
3. **Phase 3**: Evaluate need for Yocto integration for complex components (desktop environment)
4. **Phase 4**: Implement reproducible build pipeline
5. **Phase 5**: Add CI/CD integration

### Success Criteria

- Reproducible builds across different machines
- Build time < 30 minutes for base system
- Support for x86_64 and ARM64 architectures
- Clear documentation for adding new packages
- Successful boot in QEMU

## Consequences

### Positive

- Faster development cycles
- Easier onboarding for contributors
- Better understanding of build process
- Smaller learning curve compared to Yocto
- Efficient resource usage

### Negative

- May need to invest more effort in desktop environment integration
- Package ecosystem smaller than full distributions
- May need to create custom packages for some components
- Less industry-standard than Yocto for complex projects

### Mitigation Strategies

- Use Buildroot's external tree mechanism for custom packages
- Implement Yocto compatibility layer if needed for complex components
- Contribute useful packages back to Buildroot community
- Develop clear documentation for package creation

## Alternatives Considered

We explored the possibility of using a hybrid approach (Buildroot for base, Yocto for desktop), but decided to start with Buildroot alone and add complexity only if needed. This follows our principle of simplicity and avoiding premature optimization.

## References

- [Buildroot Website](https://buildroot.org/)
- [Yocto Project](https://www.yoctoproject.org/)
- [Linux From Scratch](https://www.linuxfromscratch.org/)
- [Reproducible Builds](https://reproducible-builds.org/)

## Revision History

- v1.0 - Initial decision (2026-09-22)