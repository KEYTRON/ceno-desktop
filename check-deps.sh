#!/bin/bash

# Скрипт для проверки зависимостей на macOS
# Этот скрипт должен запускаться на реальном macOS

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Проверка зависимостей для сборки Mozilla/Gecko на macOS ===${NC}"

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo -e "${RED}ОШИБКА: Этот скрипт должен запускаться на macOS${NC}"
    echo -e "${YELLOW}Текущая ОС: $OSTYPE${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Операционная система: macOS${NC}"

# Check macOS version
MACOS_VERSION=$(sw_vers -productVersion)
echo -e "${GREEN}✓ Версия macOS: $MACOS_VERSION${NC}"

# Check architecture
ARCH=$(uname -m)
echo -e "${GREEN}✓ Архитектура: $ARCH${NC}"

# Check Xcode
if command -v xcodebuild &> /dev/null; then
    XCODE_VERSION=$(xcodebuild -version | head -n 1 | awk '{print $2}')
    echo -e "${GREEN}✓ Xcode версия: $XCODE_VERSION${NC}"
else
    echo -e "${RED}✗ Xcode не установлен${NC}"
    echo -e "${YELLOW}Установите Xcode из App Store${NC}"
    exit 1
fi

# Check Command Line Tools
if xcrun --show-sdk-path &> /dev/null; then
    SDK_PATH=$(xcrun --show-sdk-path)
    echo -e "${GREEN}✓ macOS SDK: $SDK_PATH${NC}"
else
    echo -e "${RED}✗ Command Line Tools не установлены${NC}"
    echo -e "${YELLOW}Запустите: xcode-select --install${NC}"
    exit 1
fi

# Check Python
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
    echo -e "${GREEN}✓ Python версия: $PYTHON_VERSION${NC}"
    
    # Check if Python version is compatible
    if [[ "$PYTHON_VERSION" < "3.8" ]]; then
        echo -e "${YELLOW}⚠ Python версия $PYTHON_VERSION может быть слишком старой${NC}"
        echo -e "${YELLOW}Рекомендуется Python 3.8+${NC}"
    elif [[ "$PYTHON_VERSION" > "3.11" ]]; then
        echo -e "${YELLOW}⚠ Python версия $PYTHON_VERSION может быть слишком новой${NC}"
        echo -e "${YELLOW}Рекомендуется Python 3.8-3.11${NC}"
    else
        echo -e "${GREEN}✓ Python версия совместима${NC}"
    fi
else
    echo -e "${RED}✗ Python3 не установлен${NC}"
    exit 1
fi

# Check Git
if command -v git &> /dev/null; then
    GIT_VERSION=$(git --version | awk '{print $3}')
    echo -e "${GREEN}✓ Git версия: $GIT_VERSION${NC}"
else
    echo -e "${RED}✗ Git не установлен${NC}"
    echo -e "${YELLOW}Установите Git: brew install git${NC}"
    exit 1
fi

# Check Homebrew (optional)
if command -v brew &> /dev/null; then
    echo -e "${GREEN}✓ Homebrew установлен${NC}"
    
    # Check ccache
    if brew list ccache &> /dev/null; then
        echo -e "${GREEN}✓ ccache установлен${NC}"
    else
        echo -e "${YELLOW}⚠ ccache не установлен (опционально)${NC}"
        echo -e "${YELLOW}Установите: brew install ccache${NC}"
    fi
else
    echo -e "${YELLOW}⚠ Homebrew не установлен${NC}"
    echo -e "${YELLOW}Установите: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"${NC}"
fi

# Check disk space
DISK_SPACE=$(df -h . | awk 'NR==2 {print $4}' | sed 's/G//')
if [[ "$DISK_SPACE" -gt 20 ]]; then
    echo -e "${GREEN}✓ Свободное место на диске: ${DISK_SPACE}GB${NC}"
else
    echo -e "${RED}✗ Недостаточно места на диске: ${DISK_SPACE}GB${NC}"
    echo -e "${YELLOW}Требуется минимум 20GB${NC}"
    exit 1
fi

# Check RAM
TOTAL_RAM=$(sysctl -n hw.memsize | awk '{print $1/1024/1024/1024}')
if [[ $(echo "$TOTAL_RAM >= 8" | bc -l) -eq 1 ]]; then
    echo -e "${GREEN}✓ Общий объем RAM: ${TOTAL_RAM}GB${NC}"
else
    echo -e "${RED}✗ Недостаточно RAM: ${TOTAL_RAM}GB${NC}"
    echo -e "${YELLOW}Требуется минимум 8GB${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}=== Результат проверки ===${NC}"

if [[ "$ARCH" == "arm64" ]]; then
    echo -e "${GREEN}✓ Система готова к сборке для Apple Silicon (ARM64)${NC}"
    echo -e "${GREEN}✓ Используйте: mozconfig-macos-arm64 или mozconfig-macos-arm64-dev${NC}"
elif [[ "$ARCH" == "x86_64" ]]; then
    echo -e "${GREEN}✓ Система готова к сборке для Intel (x86_64)${NC}"
    echo -e "${GREEN}✓ Используйте: mozconfig-macos-x86_64 или mozconfig-macos-x86_64-dev${NC}"
else
    echo -e "${RED}✗ Неподдерживаемая архитектура: $ARCH${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}=== Следующие шаги ===${NC}"
echo -e "${GREEN}1. Настройте переменные окружения:${NC}"
echo -e "   source macos-env.sh"
echo ""
echo -e "${GREEN}2. Запустите сборку:${NC}"
echo -e "   ./build-macos.sh"
echo ""
echo -e "${GREEN}3. Или для разработки:${NC}"
echo -e "   ./build-macos-dev.sh"
echo ""
echo -e "${GREEN}4. Или используйте Makefile:${NC}"
echo -e "   make help"
echo -e "   make build"