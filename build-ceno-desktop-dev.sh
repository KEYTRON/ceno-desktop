#!/bin/bash

# Ceno Desktop.app Development Build Script for macOS
# This script builds the Ceno Desktop application in development mode

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Ceno Desktop.app Development Build Script for macOS ===${NC}"

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo -e "${RED}Error: This script is designed for macOS only${NC}"
    exit 1
fi

# Detect architecture
ARCH=$(uname -m)
echo -e "${GREEN}Detected architecture: ${ARCH}${NC}"

# Set appropriate configuration file for Ceno Desktop development
if [[ "$ARCH" == "arm64" ]]; then
    MOZCONFIG="mozconfig-macos-ceno-desktop-dev"
    echo -e "${GREEN}Using Ceno Desktop development configuration for Apple Silicon (ARM64)${NC}"
elif [[ "$ARCH" == "x86_64" ]]; then
    MOZCONFIG="mozconfig-macos-ceno-desktop-dev"
    echo -e "${GREEN}Using Ceno Desktop development configuration for Intel (x86_64)${NC}"
else
    echo -e "${RED}Error: Unsupported architecture: ${ARCH}${NC}"
    exit 1
fi

# Check if mozconfig file exists
if [[ ! -f "$MOZCONFIG" ]]; then
    echo -e "${RED}Error: Configuration file ${MOZCONFIG} not found${NC}"
    exit 1
fi

# Check if Xcode is installed
if ! command -v xcodebuild &> /dev/null; then
    echo -e "${RED}Error: Xcode is not installed. Please install Xcode from the App Store.${NC}"
    exit 1
fi

# Check Xcode version
XCODE_VERSION=$(xcodebuild -version | head -n 1 | awk '{print $2}')
echo -e "${GREEN}Xcode version: ${XCODE_VERSION}${NC}"

# Check if macOS SDK is available
SDK_PATH=$(xcrun --show-sdk-path 2>/dev/null || echo "")
if [[ -z "$SDK_PATH" ]]; then
    echo -e "${RED}Error: macOS SDK not found. Please install Xcode command line tools.${NC}"
    echo -e "${YELLOW}Run: xcode-select --install${NC}"
    exit 1
fi

echo -e "${GREEN}macOS SDK path: ${SDK_PATH}${NC}"

# Set environment variables for Ceno Desktop development
export MOZCONFIG="$MOZCONFIG"
export MACOSX_DEPLOYMENT_TARGET=$(if [[ "$ARCH" == "arm64" ]]; then echo "11.0"; else echo "10.15"; fi)
export MOZ_PARALLEL_BUILD=$(sysctl -n hw.ncpu)

echo -e "${GREEN}Using MOZCONFIG: ${MOZCONFIG}${NC}"
echo -e "${GREEN}Target macOS version: ${MACOSX_DEPLOYMENT_TARGET}${NC}"
echo -e "${GREEN}Parallel build: ${MOZ_PARALLEL_BUILD} cores${NC}"
echo -e "${BLUE}Building: Ceno Desktop.app (Development Mode)${NC}"
echo -e "${YELLOW}Development mode: Debug symbols enabled, optimization disabled${NC}"

# Check if mach script exists
if [[ ! -f "mach" ]]; then
    echo -e "${RED}Error: mach script not found. Please run this script from the Mozilla/Gecko source directory.${NC}"
    exit 1
fi

# Make mach script executable
chmod +x mach

echo -e "${BLUE}Starting Ceno Desktop development build process...${NC}"
echo -e "${YELLOW}This may take 1-4 hours depending on your system specifications.${NC}"
echo -e "${BLUE}Target application: Ceno Desktop.app (Development)${NC}"

# Start the development build
./mach build

echo -e "${GREEN}Ceno Desktop development build completed successfully!${NC}"
echo -e "${BLUE}You can now run Ceno Desktop with: ./mach run${NC}"
echo -e "${BLUE}For debugging, use: ./mach run --debug${NC}"

# Show where the Ceno Desktop.app is located
echo -e "${BLUE}=== Ceno Desktop.app Location ===${NC}"
if [[ "$ARCH" == "arm64" ]]; then
    APP_PATH="obj-arm64-apple-darwin/dist/Ceno Desktop.app"
else
    APP_PATH="obj-x86_64-apple-darwin/dist/Ceno Desktop.app"
fi

if [[ -d "$APP_PATH" ]]; then
    echo -e "${GREEN}Ceno Desktop.app found at: ${APP_PATH}${NC}"
    ls -la "$APP_PATH"
    
    # Show executable path
    EXEC_PATH="$APP_PATH/Contents/MacOS/Ceno Desktop"
    if [[ -f "$EXEC_PATH" ]]; then
        echo -e "${GREEN}Executable found at: ${EXEC_PATH}${NC}"
        ls -lh "$EXEC_PATH"
    fi
else
    echo -e "${YELLOW}Note: Ceno Desktop.app may be in a different location${NC}"
    echo -e "${BLUE}Searching for Ceno Desktop.app...${NC}"
    find obj-* -name "*Ceno*" -type d 2>/dev/null || echo "No Ceno Desktop.app found"
fi

echo ""
echo -e "${BLUE}=== Development Features ===${NC}"
echo -e "${GREEN}✓ Debug symbols enabled${NC}"
echo -e "${GREEN}✓ Optimization disabled for debugging${NC}"
echo -e "${GREEN}✓ Logging enabled${NC}"
echo -e "${GREEN}✓ Development bundle identifier: com.ceno.desktop.dev${NC}"

echo ""
echo -e "${BLUE}=== Next Steps ===${NC}"
echo -e "${GREEN}1. Run Ceno Desktop:${NC}"
echo -e "   ./mach run"
echo ""
echo -e "${GREEN}2. Run with debugging:${NC}"
echo -e "   ./mach run --debug"
echo ""
echo -e "${GREEN}3. Create development package:${NC}"
echo -e "   ./mach package"
echo ""
echo -e "${GREEN}4. Test Ceno Desktop:${NC}"
echo -e "   ./mach test"
echo ""
echo -e "${BLUE}=== Ceno Desktop.app Development Build Complete! ===${NC}"