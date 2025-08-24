#!/bin/bash

# Ceno Desktop.app Environment Variables for macOS Build
# Source this file to set up environment for building Ceno Desktop

# Detect architecture
ARCH=$(uname -m)

if [[ "$ARCH" == "arm64" ]]; then
    # Apple Silicon (ARM64)
    export MOZCONFIG="mozconfig-macos-ceno-desktop"
    export MACOSX_DEPLOYMENT_TARGET="11.0"
    echo "Set up environment for Ceno Desktop.app on Apple Silicon (ARM64)"
elif [[ "$ARCH" == "x86_64" ]]; then
    # Intel (x86_64)
    export MOZCONFIG="mozconfig-macos-ceno-desktop"
    export MACOSX_DEPLOYMENT_TARGET="10.15"
    echo "Set up environment for Ceno Desktop.app on Intel (x86_64)"
else
    echo "Warning: Unsupported architecture: $ARCH"
    return 1
fi

# Common environment variables for Ceno Desktop
export MOZ_PARALLEL_BUILD=$(sysctl -n hw.ncpu 2>/dev/null || echo "4")

# Ceno Desktop specific variables
export CENO_APP_NAME="Ceno Desktop"
export CENO_BUNDLE_ID="com.ceno.desktop"
export CENO_BRANDING="browser/branding/ceno"

# Optional: Set SDK path if different from default
# export MACOS_SDK_DIR="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"

echo "Environment variables set for Ceno Desktop.app:"
echo "  MOZCONFIG: $MOZCONFIG"
echo "  MACOSX_DEPLOYMENT_TARGET: $MACOSX_DEPLOYMENT_TARGET"
echo "  MOZ_PARALLEL_BUILD: $MOZ_PARALLEL_BUILD"
echo "  CENO_APP_NAME: $CENO_APP_NAME"
echo "  CENO_BUNDLE_ID: $CENO_BUNDLE_ID"
echo "  CENO_BRANDING: $CENO_BRANDING"
echo ""
echo "You can now run: ./mach build"
echo "Target application: Ceno Desktop.app"