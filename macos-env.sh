#!/bin/bash

# macOS Environment Variables for Mozilla/Gecko Build
# Source this file to set up environment for building

# Detect architecture
ARCH=$(uname -m)

if [[ "$ARCH" == "arm64" ]]; then
    # Apple Silicon (ARM64)
    export MOZCONFIG="mozconfig-macos-arm64"
    export MACOSX_DEPLOYMENT_TARGET="11.0"
    echo "Set up environment for Apple Silicon (ARM64)"
elif [[ "$ARCH" == "x86_64" ]]; then
    # Intel (x86_64)
    export MOZCONFIG="mozconfig-macos-x86_64"
    export MACOSX_DEPLOYMENT_TARGET="10.15"
    echo "Set up environment for Intel (x86_64)"
else
    echo "Warning: Unsupported architecture: $ARCH"
    return 1
fi

# Common environment variables
export MOZ_PARALLEL_BUILD=$(sysctl -n hw.ncpu 2>/dev/null || echo "4")

# Optional: Set SDK path if different from default
# export MACOS_SDK_DIR="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"

echo "Environment variables set:"
echo "  MOZCONFIG: $MOZCONFIG"
echo "  MACOSX_DEPLOYMENT_TARGET: $MACOSX_DEPLOYMENT_TARGET"
echo "  MOZ_PARALLEL_BUILD: $MOZ_PARALLEL_BUILD"
echo ""
echo "You can now run: ./mach build"