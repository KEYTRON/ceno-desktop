# Создание исполняемого приложения Mozilla/Gecko на macOS

## 🎯 Цель
Создать исполняемое приложение Mozilla/Gecko для macOS с поддержкой обеих архитектур: Intel (x86_64) и Apple Silicon (ARM64).

## 📋 Предварительные требования

### Системные требования
- **macOS**: 10.15+ (Catalina) для Intel, 11.0+ (Big Sur) для Apple Silicon
- **RAM**: минимум 8GB (рекомендуется 16GB+)
- **Диск**: минимум 20GB свободного места
- **Процессор**: Intel или Apple Silicon

### Программное обеспечение
- **Xcode**: последняя версия из App Store
- **Command Line Tools**: `xcode-select --install`
- **Git**: для клонирования репозитория
- **Homebrew**: для установки дополнительных инструментов

## 🚀 Быстрый старт

### 1. Проверка зависимостей
```bash
# Сделать скрипт исполняемым
chmod +x check-deps.sh

# Проверить зависимости
./check-deps.sh
```

### 2. Автоматическая сборка
```bash
# Сделать скрипт исполняемым
chmod +x build-macos.sh

# Запустить сборку
./build-macos.sh
```

### 3. Быстрая сборка
```bash
# Сделать скрипт исполняемым
chmod +x quick-build.sh

# Быстрая сборка
./quick-build.sh
```

## 🔧 Пошаговая сборка

### Шаг 1: Подготовка
```bash
# Клонировать репозиторий (если еще не сделано)
git clone <repository-url>
cd <repository-name>

# Настроить переменные окружения
source macos-env.sh
```

### Шаг 2: Конфигурация
```bash
# Настроить сборку
./mach configure
```

### Шаг 3: Сборка
```bash
# Запустить сборку
./mach build
```

### Шаг 4: Создание пакета
```bash
# Создать DMG или архив
./mach package
```

### Шаг 5: Запуск
```bash
# Запустить приложение
./mach run
```

## 📁 Структура сборки

После успешной сборки структура будет следующей:

```
obj-<arch>-apple-darwin/
├── dist/
│   └── <app-name>.app/
│       ├── Contents/
│       │   ├── MacOS/
│       │   │   └── <executable>          # ← Исполняемый файл
│       │   ├── Resources/
│       │   └── Info.plist
│       └── ...
├── objdir-<arch>-apple-darwin/
└── ...
```

## 🎯 Исполняемые файлы

### Основные исполняемые файлы
- **`firefox`** - основной браузер Firefox
- **`gecko`** - движок Gecko
- **`xpcshell`** - командная строка JavaScript
- **`js`** - JavaScript shell

### Расположение
```bash
# Найти исполняемые файлы
find obj-* -name "firefox" -o -name "gecko" -o -name "xpcshell" -o -name "js"

# Типичные пути:
# Intel: obj-x86_64-apple-darwin/dist/firefox.app/Contents/MacOS/firefox
# ARM64: obj-arm64-apple-darwin/dist/firefox.app/Contents/MacOS/firefox
```

## 🚀 Запуск приложения

### Базовый запуск
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

### Прямой запуск исполняемого файла
```bash
# Найти исполняемый файл
EXEC_PATH=$(find obj-* -name "firefox" | head -1)

# Запустить
"$EXEC_PATH" --new-window
```

## 📦 Создание пакетов

### DMG файл
```bash
./mach package
# Создает: obj-*/dist/*.dmg
```

### Архив
```bash
./mach package --format=tar
# Создает: obj-*/dist/*.tar.bz2
```

### Установщик
```bash
./mach package --format=installer
# Создает: obj-*/dist/*.pkg
```

## 🧪 Тестирование

### Запуск тестов
```bash
# Все тесты
./mach test

# Конкретные тесты
./mach test path/to/test

# Тесты с отладкой
./mach test --debug
```

### Проверка сборки
```bash
# Проверить конфигурацию
./mach configure --help

# Показать переменные окружения
./mach environment

# Проверить зависимости
./mach doctor
```

## 🔍 Диагностика

### Логи сборки
```bash
# Основной лог
tail -f obj-*/mozconfig.log

# Поиск ошибок
grep -i error obj-*/mozconfig.log

# Поиск предупреждений
grep -i warning obj-*/mozconfig.log
```

### Мониторинг ресурсов
```bash
# Мониторинг CPU и памяти
top -pid $(pgrep -f "mach build")

# Мониторинг диска
df -h

# Мониторинг процессов
ps aux | grep mach
```

## 🛠️ Оптимизация

### Параллельная сборка
```bash
export MOZ_PARALLEL_BUILD=$(sysctl -n hw.ncpu)
./mach build
```

### Кэширование
```bash
export CCACHE_DIR=$HOME/.ccache
export CCACHE_SIZE=10G
./mach build
```

### Отладочная информация
```bash
# Включить отладку
export MOZCONFIG=mozconfig-macos-<arch>-dev
./mach build
```

## ❌ Устранение неполадок

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
export CCACHE_DIR=$HOME/.ccache
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

## 📊 Время сборки

### Примерные временные рамки
- **Intel Mac**: 1-3 часа
- **Apple Silicon**: 1-2 часа
- **С SSD**: на 30-50% быстрее
- **С 16GB+ RAM**: на 20-30% быстрее

### Факторы, влияющие на скорость
- Мощность процессора
- Объем RAM
- Тип диска (SSD vs HDD)
- Количество ядер
- Использование ccache

## 🎉 Результат

После успешной сборки у вас будет:

✅ **Исполняемое приложение** в `obj-*/dist/*.app/Contents/MacOS/`
✅ **Готовый к запуску браузер** с командой `./mach run`
✅ **Пакет для распространения** (DMG, архив)
✅ **Среда для разработки** и отладки

## 🔄 Обновление

### Обновление исходного кода
```bash
git pull origin main
./mach clobber
./mach build
```

### Обновление конфигурации
```bash
# Изменить mozconfig файл
# Затем пересобрать
./mach clobber
./mach configure
./mach build
```

## 📚 Дополнительные ресурсы

- [README-macOS.md](README-macOS.md) - Подробная документация
- [INSTALL-macOS.md](INSTALL-macOS.md) - Пошаговое руководство
- [Mozilla Build Documentation](https://firefox-source-docs.mozilla.org/setup/)
- [Firefox Source](https://firefox-source-docs.mozilla.org/)

## 🆘 Поддержка

При возникновении проблем:
1. Проверить логи сборки
2. Убедиться в корректности зависимостей
3. Проверить переменные окружения
4. Обратиться к документации Mozilla
5. Создать issue в репозитории