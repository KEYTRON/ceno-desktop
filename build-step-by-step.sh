#!/bin/bash

# Скрипт для пошаговой сборки Mozilla/Gecko на macOS
# Этот скрипт должен запускаться на реальном macOS

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Пошаговая сборка Mozilla/Gecko на macOS ===${NC}"

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo -e "${RED}ОШИБКА: Этот скрипт должен запускаться на macOS${NC}"
    echo -e "${YELLOW}Текущая ОС: $OSTYPE${NC}"
    exit 1
fi

# Detect architecture
ARCH=$(uname -m)
echo -e "${GREEN}Обнаружена архитектура: $ARCH${NC}"

# Set appropriate configuration
if [[ "$ARCH" == "arm64" ]]; then
    MOZCONFIG="mozconfig-macos-arm64"
    MACOS_TARGET="11.0"
    echo -e "${GREEN}Используется конфигурация для Apple Silicon (ARM64)${NC}"
elif [[ "$ARCH" == "x86_64" ]]; then
    MOZCONFIG="mozconfig-macos-x86_64"
    MACOS_TARGET="10.15"
    echo -e "${GREEN}Используется конфигурация для Intel (x86_64)${NC}"
else
    echo -e "${RED}ОШИБКА: Неподдерживаемая архитектура: $ARCH${NC}"
    exit 1
fi

# Check if mozconfig file exists
if [[ ! -f "$MOZCONFIG" ]]; then
    echo -e "${RED}ОШИБКА: Файл конфигурации $MOZCONFIG не найден${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Файл конфигурации: $MOZCONFIG${NC}"

# Step 1: Set environment variables
echo -e "${BLUE}Шаг 1: Настройка переменных окружения${NC}"
export MOZCONFIG="$MOZCONFIG"
export MACOSX_DEPLOYMENT_TARGET="$MACOS_TARGET"
export MOZ_PARALLEL_BUILD=$(sysctl -n hw.ncpu)

echo -e "${GREEN}✓ MOZCONFIG: $MOZCONFIG${NC}"
echo -e "${GREEN}✓ MACOSX_DEPLOYMENT_TARGET: $MACOSX_DEPLOYMENT_TARGET${NC}"
echo -e "${GREEN}✓ MOZ_PARALLEL_BUILD: $MOZ_PARALLEL_BUILD${NC}"

# Step 2: Check prerequisites
echo -e "${BLUE}Шаг 2: Проверка зависимостей${NC}"
if ! command -v xcodebuild &> /dev/null; then
    echo -e "${RED}✗ Xcode не установлен${NC}"
    exit 1
fi

if ! xcrun --show-sdk-path &> /dev/null; then
    echo -e "${RED}✗ macOS SDK не найден${NC}"
    exit 1
fi

if [[ ! -f "mach" ]]; then
    echo -e "${RED}✗ Скрипт mach не найден${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Все зависимости проверены${NC}"

# Step 3: Make mach executable
echo -e "${BLUE}Шаг 3: Настройка прав доступа${NC}"
chmod +x mach
echo -e "${GREEN}✓ Скрипт mach сделан исполняемым${NC}"

# Step 4: Configure build
echo -e "${BLUE}Шаг 4: Конфигурация сборки${NC}"
echo -e "${YELLOW}Это может занять несколько минут...${NC}"

if ./mach configure; then
    echo -e "${GREEN}✓ Конфигурация завершена успешно${NC}"
else
    echo -e "${RED}✗ Ошибка конфигурации${NC}"
    echo -e "${YELLOW}Проверьте логи выше для диагностики${NC}"
    exit 1
fi

# Step 5: Build
echo -e "${BLUE}Шаг 5: Сборка Mozilla/Gecko${NC}"
echo -e "${YELLOW}ВНИМАНИЕ: Это может занять 1-4 часа в зависимости от системы${NC}"
echo -e "${YELLOW}Нажмите Ctrl+C для остановки, если необходимо${NC}"
echo ""

# Show build information
echo -e "${BLUE}Информация о сборке:${NC}"
echo -e "  Архитектура: $ARCH"
echo -e "  Конфигурация: $MOZCONFIG"
echo -e "  Целевая версия macOS: $MACOS_TARGET"
echo -e "  Параллельная сборка: $MOZ_PARALLEL_BUILD ядер"
echo -e "  Директория сборки: obj-$(uname -m)-apple-darwin"
echo ""

# Start the build
if ./mach build; then
    echo -e "${GREEN}✓ Сборка завершена успешно!${NC}"
else
    echo -e "${RED}✗ Ошибка сборки${NC}"
    echo -e "${YELLOW}Проверьте логи выше для диагностики${NC}"
    exit 1
fi

# Step 6: Package (optional)
echo -e "${BLUE}Шаг 6: Создание пакета (опционально)${NC}"
read -p "Создать пакет? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Создание пакета...${NC}"
    if ./mach package; then
        echo -e "${GREEN}✓ Пакет создан успешно${NC}"
        
        # Find the package
        PACKAGE_PATH=$(find obj-* -name "*.dmg" -o -name "*.tar.bz2" | head -1)
        if [[ -n "$PACKAGE_PATH" ]]; then
            echo -e "${GREEN}✓ Пакет найден: $PACKAGE_PATH${NC}"
            ls -lh "$PACKAGE_PATH"
        fi
    else
        echo -e "${RED}✗ Ошибка создания пакета${NC}"
    fi
fi

# Step 7: Run (optional)
echo -e "${BLUE}Шаг 7: Запуск приложения (опционально)${NC}"
read -p "Запустить приложение? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Запуск Mozilla/Gecko...${NC}"
    if ./mach run; then
        echo -e "${GREEN}✓ Приложение запущено успешно${NC}"
    else
        echo -e "${RED}✗ Ошибка запуска приложения${NC}"
    fi
fi

echo ""
echo -e "${BLUE}=== Сборка завершена! ===${NC}"
echo -e "${GREEN}Исполняемое приложение находится в:${NC}"
echo -e "  obj-$(uname -m)-apple-darwin/dist/"

if [[ "$ARCH" == "arm64" ]]; then
    echo -e "  obj-$(uname -m)-apple-darwin/dist/*/Contents/MacOS/*"
else
    echo -e "  obj-$(uname -m)-apple-darwin/dist/*/Contents/MacOS/*"
fi

echo ""
echo -e "${BLUE}=== Полезные команды ===${NC}"
echo -e "${GREEN}Запуск:${NC}"
echo -e "  ./mach run"
echo ""
echo -e "${GREEN}Запуск с отладкой:${NC}"
echo -e "  ./mach run --debug"
echo ""
echo -e "${GREEN}Запуск с профилем:${NC}"
echo -e "  ./mach run --profile /path/to/profile"
echo ""
echo -e "${GREEN}Тестирование:${NC}"
echo -e "  ./mach test"
echo ""
echo -e "${GREEN}Очистка:${NC}"
echo -e "  ./mach clobber"