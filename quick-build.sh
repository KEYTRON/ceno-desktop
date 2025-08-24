#!/bin/bash

# Скрипт для быстрой сборки Mozilla/Gecko на macOS
# Этот скрипт должен запускаться на реальном macOS

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Быстрая сборка Mozilla/Gecko на macOS ===${NC}"

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo -e "${RED}ОШИБКА: Этот скрипт должен запускаться на macOS${NC}"
    exit 1
fi

# Detect architecture and set configuration
ARCH=$(uname -m)
if [[ "$ARCH" == "arm64" ]]; then
    MOZCONFIG="mozconfig-macos-arm64"
    MACOS_TARGET="11.0"
elif [[ "$ARCH" == "x86_64" ]]; then
    MOZCONFIG="mozconfig-macos-x86_64"
    MACOS_TARGET="10.15"
else
    echo -e "${RED}ОШИБКА: Неподдерживаемая архитектура: $ARCH${NC}"
    exit 1
fi

echo -e "${GREEN}Архитектура: $ARCH${NC}"
echo -e "${GREEN}Конфигурация: $MOZCONFIG${NC}"

# Set environment variables
export MOZCONFIG="$MOZCONFIG"
export MACOSX_DEPLOYMENT_TARGET="$MACOS_TARGET"
export MOZ_PARALLEL_BUILD=$(sysctl -n hw.ncpu)

# Make mach executable
chmod +x mach

# Quick build with minimal output
echo -e "${BLUE}Запуск быстрой сборки...${NC}"
echo -e "${YELLOW}Это может занять 1-4 часа${NC}"

if ./mach build --quiet; then
    echo -e "${GREEN}✓ Сборка завершена успешно!${NC}"
    
    # Show executable location
    EXEC_PATH=$(find obj-* -name "firefox" -o -name "gecko" 2>/dev/null | head -1)
    if [[ -n "$EXEC_PATH" ]]; then
        echo -e "${GREEN}✓ Исполняемый файл: $EXEC_PATH${NC}"
        ls -lh "$EXEC_PATH"
    fi
    
    echo -e "${BLUE}Запуск: ./mach run${NC}"
else
    echo -e "${RED}✗ Ошибка сборки${NC}"
    exit 1
fi