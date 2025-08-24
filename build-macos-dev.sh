#!/bin/bash

# macOS Development Build Script for Mozilla/Gecko
# Automatically detects architecture and uses appropriate development configuration

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== macOS Development Build Script for Mozilla/Gecko ===${NC}"

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo -e "${RED}Error: This script is designed for macOS only${NC}"
    exit 1
fi

# Detect architecture
ARCH=$(uname -m)
echo -e "${GREEN}Detected architecture: ${ARCH}${NC}"

# Set appropriate development configuration file
if [[ "$ARCH" == "arm64" ]]; then
    MOZCONFIG="mozconfig-macos-arm64-dev"
    echo -e "${GREEN}Using Apple Silicon (ARM64) development configuration${NC}"
elif [[ "$ARCH" == "x86_64" ]]; then
    MOZCONFIG="mozconfig-macos-x86_64-dev"
    echo -e "${GREEN}Using Intel (x86_64) development configuration${NC}"
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

# Set environment variables
export MOZCONFIG="$MOZCONFIG"
export MACOSX_DEPLOYMENT_TARGET=$(if [[ "$ARCH" == "arm64" ]]; then echo "11.0"; else echo "10.15"; fi)

echo -e "${GREEN}Using MOZCONFIG: ${MOZCONFIG}${NC}"
echo -e "${GREEN}Target macOS version: ${MACOSX_DEPLOYMENT_TARGET}${NC}"
echo -e "${YELLOW}Development mode: Debug symbols enabled, optimization disabled${NC}"

# Check if mach script exists
if [[ ! -f "mach" ]]; then
    echo -e "${RED}Error: mach script not found. Please run this script from the Mozilla/Gecko source directory.${NC}"
    exit 1
fi

# Make mach script executable
chmod +x mach

echo -e "${BLUE}Starting development build process...${NC}"
echo -e "${YELLOW}This may take a long time depending on your system specifications.${NC}"

# Start the development build
./mach build

echo -e "${GREEN}Development build completed successfully!${NC}"
echo -e "${BLUE}You can now run the browser with: ./mach run${NC}"
echo -e "${BLUE}For debugging, use: ./mach run --debug${NC}"