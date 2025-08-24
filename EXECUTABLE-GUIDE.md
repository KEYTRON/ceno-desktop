# 🎯 Руководство по созданию исполняемого приложения Mozilla/Gecko на macOS

## 📋 Что у нас есть

### 🏗️ Конфигурации для сборки
- **`mozconfig-macos-x86_64`** - Intel (x86_64) релизная сборка
- **`mozconfig-macos-arm64`** - Apple Silicon (ARM64) релизная сборка  
- **`mozconfig-macos-universal`** - Универсальная с автоопределением
- **`mozconfig-macos-x86_64-dev`** - Intel (x86_64) разработка
- **`mozconfig-macos-arm64-dev`** - Apple Silicon (ARM64) разработка

### 🚀 Скрипты автоматизации
- **`build-macos.sh`** - Автоматическая сборка с определением архитектуры
- **`build-macos-dev.sh`** - Сборка для разработки
- **`build-step-by-step.sh`** - Пошаговая сборка с интерактивными опциями
- **`quick-build.sh`** - Быстрая сборка с минимальным выводом
- **`check-deps.sh`** - Проверка зависимостей и системных требований
- **`macos-env.sh`** - Настройка переменных окружения

### 🛠️ Инструменты сборки
- **`Makefile.macos`** - Makefile с командами для разных типов сборки
- **`.github/workflows/macos-build.yml`** - GitHub Actions CI/CD для macOS
- **`.vscode/settings.json`** - Настройки VS Code для macOS разработки

### 📚 Документация
- **`README.md`** - Основной README
- **`README-macOS.md`** - Подробная документация по macOS
- **`INSTALL-macOS.md`** - Пошаговое руководство по установке
- **`BUILD-EXECUTABLE.md`** - Детальное руководство по созданию исполняемого файла
- **`CHANGELOG.md`** - История изменений
- **`CLEANUP-LOG.md`** - Лог очистки репозитория

## 🚀 Быстрый старт (3 способа)

### Способ 1: Автоматическая сборка (рекомендуется)
```bash
chmod +x build-macos.sh
./build-macos.sh
```

### Способ 2: Пошаговая сборка
```bash
chmod +x build-step-by-step.sh
./build-step-by-step.sh
```

### Способ 3: Быстрая сборка
```bash
chmod +x quick-build.sh
./quick-build.sh
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
│   └── <app-name>.app/
│       ├── Contents/
│       │   ├── MacOS/
│       │   │   └── <executable>          # ← ИСПОЛНЯЕМЫЙ ФАЙЛ
│       │   ├── Resources/
│       │   └── Info.plist
│       └── ...
├── objdir-<arch>-apple-darwin/
└── ...
```

## 🎯 Исполняемые файлы

### Основные
- **`firefox`** - браузер Firefox
- **`gecko`** - движок Gecko
- **`xpcshell`** - JavaScript shell
- **`js`** - JavaScript интерпретатор

### Расположение
```bash
# Найти все исполняемые файлы
find obj-* -name "firefox" -o -name "gecko" -o -name "xpcshell" -o -name "js"

# Типичные пути:
# Intel: obj-x86_64-apple-darwin/dist/firefox.app/Contents/MacOS/firefox
# ARM64: obj-arm64-apple-darwin/dist/firefox.app/Contents/MacOS/firefox
```

## 🚀 Запуск приложения

### Через mach (рекомендуется)
```bash
./mach run
```

### Прямой запуск
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

✅ **Исполняемое приложение** в `obj-*/dist/*.app/Contents/MacOS/`
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

- [BUILD-EXECUTABLE.md](BUILD-EXECUTABLE.md) - Детальное руководство
- [README-macOS.md](README-macOS.md) - Подробная документация
- [INSTALL-macOS.md](INSTALL-macOS.md) - Пошаговое руководство
- [Mozilla Build Documentation](https://firefox-source-docs.mozilla.org/setup/)

## 🆘 Поддержка

При возникновении проблем:
1. Проверить логи сборки
2. Убедиться в корректности зависимостей
3. Проверить переменные окружения
4. Обратиться к документации Mozilla
5. Создать issue в репозитории

---

**🎯 Цель достигнута!** У вас есть все необходимое для создания исполняемого приложения Mozilla/Gecko на macOS.