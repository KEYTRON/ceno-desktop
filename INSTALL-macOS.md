# Пошаговая установка и сборка Mozilla/Gecko на macOS

## Шаг 1: Подготовка системы

### Проверка версии macOS
```bash
sw_vers
```

**Требования:**
- Intel Mac: macOS 10.15+ (Catalina)
- Apple Silicon: macOS 11.0+ (Big Sur)

### Проверка архитектуры
```bash
uname -m
```

**Ожидаемый результат:**
- Intel: `x86_64`
- Apple Silicon: `arm64`

## Шаг 2: Установка Xcode

### Установка Xcode из App Store
1. Откройте App Store
2. Найдите "Xcode"
3. Установите последнюю версию

### Установка Command Line Tools
```bash
xcode-select --install
```

### Проверка установки
```bash
xcodebuild -version
xcrun --show-sdk-path
```

## Шаг 3: Установка дополнительных инструментов

### Установка Homebrew (если не установлен)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Установка ccache для ускорения сборки
```bash
brew install ccache
```

## Шаг 4: Клонирование репозитория

```bash
git clone https://github.com/mozilla/gecko-dev.git
cd gecko-dev
```

## Шаг 5: Настройка конфигурации

### Автоматическая настройка (рекомендуется)
```bash
# Сделать скрипты исполняемыми
chmod +x build-macos.sh build-macos-dev.sh

# Настроить переменные окружения
source macos-env.sh
```

### Ручная настройка

**Для Intel (x86_64):**
```bash
export MOZCONFIG=mozconfig-macos-x86_64
export MACOSX_DEPLOYMENT_TARGET=10.15
```

**Для Apple Silicon (ARM64):**
```bash
export MOZCONFIG=mozconfig-macos-arm64
export MACOSX_DEPLOYMENT_TARGET=11.0
```

## Шаг 6: Сборка

### Быстрая сборка
```bash
./build-macos.sh
```

### Сборка для разработки
```bash
./build-macos-dev.sh
```

### Использование Makefile
```bash
# Показать доступные команды
make help

# Сборка для текущей архитектуры
make build

# Сборка для конкретной архитектуры
make build-x86_64    # Intel
make build-arm64     # Apple Silicon

# Сборка для разработки
make build-dev

# Очистка
make clean
```

## Шаг 7: Запуск

### Запуск браузера
```bash
./mach run
```

### Запуск с отладкой
```bash
./mach run --debug
```

### Запуск с профилем
```bash
./mach run --profile /path/to/profile
```

## Шаг 8: Тестирование

### Запуск тестов
```bash
./mach test
```

### Запуск конкретных тестов
```bash
./mach test path/to/test
```

## Шаг 9: Создание пакета

### Создание DMG
```bash
./mach package
```

### Создание архива
```bash
./mach package --format=tar
```

## Устранение неполадок

### Ошибка: "Xcode is not installed"
```bash
# Установить Xcode из App Store
# Затем установить Command Line Tools
xcode-select --install
```

### Ошибка: "macOS SDK not found"
```bash
# Проверить путь к SDK
xcrun --show-sdk-path

# Если SDK не найден, переустановить Xcode
```

### Ошибка: "Permission denied"
```bash
# Сделать скрипты исполняемыми
chmod +x *.sh
chmod +x mach
```

### Медленная сборка
```bash
# Увеличить количество ядер
export MOZ_PARALLEL_BUILD=$(sysctl -n hw.ncpu)

# Использовать ccache
export CCACHE_DIR=/path/to/ccache
export CCACHE_SIZE=10G
```

### Ошибка компиляции
```bash
# Очистить предыдущую сборку
./mach clobber

# Переконфигурировать
./mach configure

# Попробовать снова
./mach build
```

## Оптимизация

### Параллельная сборка
```bash
export MOZ_PARALLEL_BUILD=$(sysctl -n hw.ncpu)
```

### Кэширование
```bash
export CCACHE_DIR=$HOME/.ccache
export CCACHE_SIZE=10G
ccache -s
```

### Отладочная информация
```bash
# Включить отладку
ac_add_options --enable-debug
ac_add_options --disable-optimize

# Отключить strip
ac_add_options --disable-strip
```

## Мониторинг

### Использование ресурсов
```bash
# Мониторинг CPU и памяти
top -pid $(pgrep -f "mach build")

# Мониторинг диска
df -h
```

### Логи сборки
```bash
# Просмотр логов
tail -f obj-*/mozconfig.log

# Поиск ошибок
grep -i error obj-*/mozconfig.log
```

## Поддержка

### Полезные команды
```bash
# Проверка конфигурации
./mach configure

# Показать переменные окружения
./mach environment

# Проверка зависимостей
./mach doctor
```

### Документация
- [Mozilla Build Documentation](https://firefox-source-docs.mozilla.org/setup/)
- [macOS Development](https://developer.apple.com/macos/)
- [Xcode Documentation](https://developer.apple.com/xcode/)

### Сообщество
- [Mozilla Developer Network](https://developer.mozilla.org/)
- [Firefox Source](https://firefox-source-docs.mozilla.org/)
- [GitHub Issues](https://github.com/mozilla/gecko-dev/issues)

## Заключение

После успешной сборки у вас будет:
- Собранный Mozilla/Gecko для вашей архитектуры
- Готовое к запуску приложение
- Среда для разработки и отладки

**Время сборки:** 1-4 часа в зависимости от системы
**Требуемое место:** 20-50GB
**Рекомендуемая RAM:** 16GB+