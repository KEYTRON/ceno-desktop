# 🎯 Ceno Desktop.app - Полный набор инструментов для сборки

## 📋 Что у нас есть для Ceno Desktop.app

### 🏗️ Конфигурации для сборки
- **`mozconfig-macos-ceno-desktop`** - Основная конфигурация для Ceno Desktop.app
- **`mozconfig-macos-ceno-desktop-dev`** - Конфигурация для разработки с отладкой

### 🚀 Скрипты автоматизации
- **`build-ceno-desktop.sh`** - Автоматическая сборка Ceno Desktop.app
- **`build-ceno-desktop-dev.sh`** - Сборка для разработки
- **`ceno-desktop-env.sh`** - Настройка переменных окружения

### 🛠️ Инструменты сборки
- **`Makefile.ceno-desktop`** - Makefile с командами для Ceno Desktop.app
- **`.github/workflows/macos-build.yml`** - GitHub Actions CI/CD для macOS
- **`.vscode/settings.json`** - Настройки VS Code для macOS разработки

### 📚 Документация
- **`README-CENO-DESKTOP.md`** - Специальная документация для Ceno Desktop.app
- **`BUILD-EXECUTABLE.md`** - Детальное руководство по созданию исполняемого файла
- **`README-macOS.md`** - Подробная документация по macOS
- **`INSTALL-macOS.md`** - Пошаговое руководство по установке

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

## 🚀 Быстрый старт (3 способа)

### Способ 1: Автоматическая сборка (рекомендуется)
```bash
chmod +x build-ceno-desktop.sh
./build-ceno-desktop.sh
```

### Способ 2: Сборка для разработки
```bash
chmod +x build-ceno-desktop-dev.sh
./build-ceno-desktop-dev.sh
```

### Способ 3: Использование Makefile
```bash
make help                    # Показать доступные команды
make build                   # Сборка Ceno Desktop.app
make build-dev              # Сборка для разработки
make run                    # Запуск Ceno Desktop.app
make package                # Создание пакета
make install                # Установка в Applications
```

## 🔍 Проверка зависимостей

Перед сборкой проверьте систему:
```bash
chmod +x check-deps.sh
./check-deps.sh
```

## 📁 Структура после сборки

```
obj-<arch>-apple-darwin/
├── dist/
│   └── Ceno Desktop.app/           # ← ЦЕЛЕВОЕ ПРИЛОЖЕНИЕ
│       ├── Contents/
│       │   ├── MacOS/
│       │   │   └── Ceno Desktop    # ← ИСПОЛНЯЕМЫЙ ФАЙЛ
│       │   ├── Resources/
│       │   └── Info.plist
│       └── ...
├── objdir-<arch>-apple-darwin/
└── ...
```

## 🎯 Исполняемые файлы

### Основные
- **`Ceno Desktop`** - основное приложение Ceno Desktop

### Расположение
```bash
# Найти Ceno Desktop.app
find obj-* -name "*Ceno*" -type d

# Типичные пути:
# Intel: obj-x86_64-apple-darwin/dist/Ceno Desktop.app/Contents/MacOS/Ceno Desktop
# ARM64: obj-arm64-apple-darwin/dist/Ceno Desktop.app/Contents/MacOS/Ceno Desktop
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
```

### Архив
```bash
./mach package --format=tar
```

### Установщик
```bash
./mach package --format=installer
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

- [README-CENO-DESKTOP.md](README-CENO-DESKTOP.md) - Специальная документация
- [BUILD-EXECUTABLE.md](BUILD-EXECUTABLE.md) - Детальное руководство
- [README-macOS.md](README-macOS.md) - Подробная документация
- [INSTALL-macOS.md](INSTALL-macOS.md) - Пошаговое руководство

## 🆘 Поддержка

При возникновении проблем:
1. Проверить логи сборки
2. Убедиться в корректности зависимостей
3. Проверить переменные окружения
4. Обратиться к документации Mozilla
5. Создать issue в репозитории

---

## 🎯 ИТОГОВОЕ СОСТОЯНИЕ

**✅ Цель достигнута!** У вас есть полный набор инструментов для создания **Ceno Desktop.app** на macOS:

- 🏗️ **Конфигурации** для обеих архитектур
- 🚀 **Скрипты автоматизации** для сборки
- 🛠️ **Makefile** с командами
- 📚 **Полная документация**
- 🎯 **Специализация на Ceno Desktop.app**

**Готово к использованию!** Просто перенесите репозиторий на macOS и запустите сборку Ceno Desktop.app!