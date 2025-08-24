# macOS Build Configuration for Mozilla/Gecko

Этот набор конфигурационных файлов позволяет собирать Mozilla/Gecko на macOS для обеих архитектур: Intel (x86_64) и Apple Silicon (ARM64).

## Поддерживаемые архитектуры

- **Intel (x86_64)**: macOS 10.15+ (Catalina)
- **Apple Silicon (ARM64)**: macOS 11.0+ (Big Sur)

## Требования

### Системные требования
- macOS 10.15+ для Intel
- macOS 11.0+ для Apple Silicon
- Минимум 8GB RAM (рекомендуется 16GB+)
- Минимум 20GB свободного места на диске

### Программное обеспечение
- **Xcode**: последняя версия из App Store
- **Command Line Tools**: `xcode-select --install`
- **Git**: для клонирования репозитория

## Конфигурационные файлы

### Для релизных сборок
- `mozconfig-macos-x86_64` - Intel (x86_64) релизная сборка
- `mozconfig-macos-arm64` - Apple Silicon (ARM64) релизная сборка
- `mozconfig-macos-universal` - Универсальная конфигурация с автоопределением

### Для разработки
- `mozconfig-macos-x86_64-dev` - Intel (x86_64) разработка
- `mozconfig-macos-arm64-dev` - Apple Silicon (ARM64) разработка

## Быстрый старт

### 1. Автоматическая сборка (рекомендуется)

```bash
# Сделать скрипт исполняемым
chmod +x build-macos.sh

# Запустить сборку
./build-macos.sh
```

### 2. Сборка для разработки

```bash
# Сделать скрипт исполняемым
chmod +x build-macos-dev.sh

# Запустить сборку для разработки
./build-macos-dev.sh
```

### 3. Ручная настройка

```bash
# Для Intel
export MOZCONFIG=mozconfig-macos-x86_64
export MACOSX_DEPLOYMENT_TARGET=10.15

# Для Apple Silicon
export MOZCONFIG=mozconfig-macos-arm64
export MACOSX_DEPLOYMENT_TARGET=11.0

# Запустить сборку
./mach build
```

## Особенности конфигураций

### Intel (x86_64)
- Минимальная версия macOS: 10.15 (Catalina)
- Целевая архитектура: `x86_64-apple-darwin`
- Оптимизация для Intel процессоров

### Apple Silicon (ARM64)
- Минимальная версия macOS: 11.0 (Big Sur)
- Целевая архитектура: `arm64-apple-darwin`
- Оптимизация для ARM процессоров
- Поддержка Rosetta 2 для совместимости

### Универсальная конфигурация
- Автоматически определяет архитектуру системы
- Выбирает оптимальные настройки
- Подходит для CI/CD и автоматизации

## Переменные окружения

### Обязательные
- `MOZCONFIG` - путь к файлу конфигурации
- `MACOSX_DEPLOYMENT_TARGET` - минимальная версия macOS

### Опциональные
- `MACOS_SDK_DIR` - путь к macOS SDK
- `MOZILLA_OFFICIAL` - флаг официальной сборки

## Устранение неполадок

### Ошибка: "macOS SDK not found"
```bash
# Установить Command Line Tools
xcode-select --install

# Проверить путь к SDK
xcrun --show-sdk-path
```

### Ошибка: "Xcode is not installed"
- Установить Xcode из App Store
- Установить Command Line Tools: `xcode-select --install`

### Ошибка: "Unsupported architecture"
- Убедиться, что используется поддерживаемая архитектура
- Проверить версию macOS

### Медленная сборка
- Увеличить количество ядер: `export MOZ_PARALLEL_BUILD=8`
- Использовать SSD для исходного кода
- Увеличить объем RAM

## Оптимизация сборки

### Параллельная сборка
```bash
export MOZ_PARALLEL_BUILD=$(sysctl -n hw.ncpu)
```

### Кэширование
```bash
export CCACHE_DIR=/path/to/ccache
export CCACHE_SIZE=10G
```

### Отладочная информация
```bash
# Включить отладочную информацию
ac_add_options --enable-debug
ac_add_options --disable-optimize

# Отключить strip
ac_add_options --disable-strip
```

## Запуск собранного приложения

```bash
# Запуск браузера
./mach run

# Запуск с отладкой
./mach run --debug

# Запуск с профилем
./mach run --profile /path/to/profile
```

## Полезные команды

```bash
# Очистка сборки
./mach clobber

# Проверка конфигурации
./mach configure

# Только компиляция
./mach build binaries

# Создание пакета
./mach package
```

## Поддержка

При возникновении проблем:
1. Проверить версию Xcode и macOS
2. Убедиться в корректности путей к SDK
3. Проверить переменные окружения
4. Обратиться к документации Mozilla

## Лицензия

См. файл LICENSE в корне проекта Mozilla/Gecko.