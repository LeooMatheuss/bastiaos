#!/bin/bash
# Setup script for Buildroot environment for BastiaOS
set -e

echo "=== BastiaOS Buildroot Setup Script ==="
echo ""

# Configuration
BUILDROOT_VERSION="2024.02.2"
BUILDROOT_URL="https://buildroot.org/downloads/buildroot-${BUILDROOT_VERSION}.tar.gz"
BUILD_DIR="build"
DL_DIR="dl"

# Check if we're in the bastiaos directory
if [ ! -f "README.md" ] || [ ! -d "docs" ]; then
    echo "Error: Please run this script from the bastiaos root directory"
    exit 1
fi

# Check for required tools
echo "Checking required tools..."
required_tools=("git" "wget" "tar" "make" "gcc" "python3")
missing_tools=()

for tool in "${required_tools[@]}"; do
    if ! command -v "$tool" &> /dev/null; then
        missing_tools+=("$tool")
    fi
done

if [ ${#missing_tools[@]} -ne 0 ]; then
    echo "Missing required tools: ${missing_tools[*]}"
    echo "Please install them using: sudo apt install ${missing_tools[*]}"
    exit 1
fi

echo "All required tools found."
echo ""

# Create build directory structure
echo "Creating build directory structure..."
mkdir -p "$BUILD_DIR"
mkdir -p "$DL_DIR"
echo "Build directories created."
echo ""

# Download Buildroot if not present
if [ ! -d "$BUILD_DIR/buildroot" ]; then
    echo "Downloading Buildroot ${BUILDROOT_VERSION}..."
    wget "$BUILDROOT_URL"
    tar xvf "buildroot-${BUILDROOT_VERSION}.tar.gz"
    mv "buildroot-${BUILDROOT_VERSION}" "$BUILD_DIR/buildroot"
    rm "buildroot-${BUILDROOT_VERSION}.tar.gz"
    echo "Buildroot downloaded and extracted."
else
    echo "Buildroot directory already exists, skipping download."
fi

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Next steps:"
echo "1. cd $BUILD_DIR/buildroot"
echo "2. cp ../configs/bastiaos_defconfig .config"
echo "3. make menuconfig     # Configure Buildroot (optional)"
echo "4. make -j\$(nproc)     # Build the system"
echo ""
echo "For detailed instructions, see docs/development/buildroot-setup.md"