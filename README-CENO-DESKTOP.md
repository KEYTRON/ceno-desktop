# 🎯 Ceno Desktop.app - macOS Build Guide

Этот репозиторий содержит конфигурации и инструменты для сборки **Ceno Desktop.app** на macOS с поддержкой обеих архитектур: Intel (x86_64) и Apple Silicon (ARM64).

## 🚀 Быстрый старт

### 1. Автоматическая сборка (рекомендуется)
```bash
chmod +x build-ceno-desktop.sh
./build-ceno-desktop.sh
```

### 2. Сборка для разработки
```bash
chmod +x build-ceno-desktop-dev.sh
./build-ceno-desktop-dev.sh
```

### 3. Использование Makefile
```bash
make help                    # Показать доступные команды
make build                   # Сборка Ceno Desktop.app
make build-dev              # Сборка для разработки
make run                    # Запуск Ceno Desktop.app
make package                # Создание пакета
```

## 📋 Требования

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

## 🏗️ Конфигурации для Ceno Desktop

### Релизные сборки
- **`mozconfig-macos-ceno-desktop`** - Основная конфигурация для Ceno Desktop.app

### Разработка
- **`mozconfig-macos-ceno-desktop-dev`** - Конфигурация для разработки с отладкой

## 🎯 Особенности Ceno Desktop.app

### Брендинг и именование
- **Название приложения**: Ceno Desktop
- **Bundle Identifier**: `com.ceno.desktop`
- **Брендинг**: `browser/branding/ceno`

### Функциональность
- ✅ **Ceno Features** - Специальные функции Ceno
- ✅ **Ceno Networking** - Сетевая функциональность Ceno
- ✅ **Ceno Privacy** - Приватность и безопасность
- ✅ **Ceno Browser** - Браузер на базе Gecko
- ✅ **Ceno Extensions** - Расширения Ceno

### Отключенные сервисы Mozilla
- ❌ Mozilla Services
- ❌ Telemetry
- ❌ Crash Reporter
- ❌ Updater

## 🛠️ Инструменты сборки

### Скрипты автоматизации
- **`build-ceno-desktop.sh`** - Автоматическая сборка Ceno Desktop.app
- **`build-ceno-desktop-dev.sh`** - Сборка для разработки
- **`ceno-desktop-env.sh`** - Настройка переменных окружения

### Makefile
- **`Makefile.ceno-desktop`** - Makefile с командами для Ceno Desktop.app

## 📁 Структура после сборки

```
obj-<arch>-apple-darwin/
├── dist/
│   └── Ceno Desktop.app/           # ← Целевое приложение
│       ├── Contents/
│       │   ├── MacOS/
│       │   │   └── Ceno Desktop    # ← Исполняемый файл
│       │   ├── Resources/
│       │   └── Info.plist
│       └── ...
├── objdir-<arch>-apple-darwin/
└── ...
```

## 🚀 Запуск Ceno Desktop.app

### Через mach (рекомендуется)
```bash
./mach run
```

### Прямой запуск
```bash
# Найти исполняемый файл
EXEC_PATH=$(find obj-* -name "Ceno Desktop" | head -1)

# Запустить
"$EXEC_PATH" --new-window
```

## 📦 Создание пакетов

### DMG файл
```bash
./mach package
# Создает: obj-*/dist/Ceno Desktop.app
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

```bash
# Все тесты
./mach test

# Конкретные тесты
./mach test path/to/test

# Тесты с отладкой
./mach test --debug
```

## 🔍 Диагностика

### Логи сборки
```bash
# Основной лог
tail -f obj-*/mozconfig.log

# Поиск ошибок
grep -i error obj-*/mozconfig.log
```

### Мониторинг ресурсов
```bash
# CPU и память
top -pid $(pgrep -f "mach build")

# Диск
df -h
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

## ❌ Устранение неполадок

### Частые проблемы
1. **Xcode не установлен** → Установить из App Store
2. **Command Line Tools не установлены** → `xcode-select --install`
3. **Недостаточно места** → Освободить минимум 20GB
4. **Недостаточно RAM** → Минимум 8GB, рекомендуется 16GB+
5. **Ошибки компиляции** → `./mach clobber && ./mach configure && ./mach build`

## 📊 Время сборки

- **Intel Mac**: 1-3 часа
- **Apple Silicon**: 1-2 часа
- **С SSD**: на 30-50% быстрее
- **С 16GB+ RAM**: на 20-30% быстрее

## 🎉 Результат

После успешной сборки у вас будет:

✅ **Ceno Desktop.app** в `obj-*/dist/Ceno Desktop.app/`
✅ **Готовый к запуску браузер** с командой `./mach run`
✅ **Пакет для распространения** (DMG, архив)
✅ **Среда для разработки** и отладки

## 🔄 Обновление

```bash
# Обновить исходный код
git pull origin main

# Пересобрать
./mach clobber
./mach build
```

## 📚 Дополнительные ресурсы

- [BUILD-EXECUTABLE.md](BUILD-EXECUTABLE.md) - Общее руководство по сборке
- [README-macOS.md](README-macOS.md) - Документация по macOS
- [INSTALL-macOS.md](INSTALL-macOS.md) - Пошаговое руководство

## 🆘 Поддержка

При возникновении проблем:
1. Проверить логи сборки
2. Убедиться в корректности зависимостей
3. Проверить переменные окружения
4. Обратиться к документации Mozilla
5. Создать issue в репозитории

---

**🎯 Цель: Ceno Desktop.app** - У вас есть все необходимое для создания приложения Ceno Desktop на macOS!