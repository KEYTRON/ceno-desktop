# Mozilla/Gecko macOS Build Configuration

Этот репозиторий содержит конфигурации и инструменты для сборки Mozilla/Gecko на macOS с поддержкой обеих архитектур: Intel (x86_64) и Apple Silicon (ARM64).

## 🚀 Быстрый старт

```bash
# Клонировать репозиторий
git clone <repository-url>
cd <repository-name>

# Сделать скрипты исполняемыми
chmod +x build-macos.sh build-macos-dev.sh

# Автоматическая сборка (определяет архитектуру)
./build-macos.sh

# Или для разработки
./build-macos-dev.sh
```

## 📋 Требования

- **macOS**: 10.15+ (Catalina) для Intel, 11.0+ (Big Sur) для Apple Silicon
- **Xcode**: последняя версия из App Store
- **Command Line Tools**: `xcode-select --install`
- **RAM**: минимум 8GB (рекомендуется 16GB+)
- **Диск**: минимум 20GB свободного места

## 🏗️ Конфигурации

### Релизные сборки
- `mozconfig-macos-x86_64` - Intel (x86_64)
- `mozconfig-macos-arm64` - Apple Silicon (ARM64)
- `mozconfig-macos-universal` - Универсальная (автоопределение)

### Разработка
- `mozconfig-macos-x86_64-dev` - Intel (x86_64) с отладкой
- `mozconfig-macos-arm64-dev` - Apple Silicon (ARM64) с отладкой

## 🛠️ Инструменты

- **`build-macos.sh`** - Автоматическая сборка
- **`build-macos-dev.sh`** - Сборка для разработки
- **`Makefile.macos`** - Makefile с командами сборки
- **`macos-env.sh`** - Настройка переменных окружения

## 📚 Документация

- [README-macOS.md](README-macOS.md) - Подробная документация
- [INSTALL-macOS.md](INSTALL-macOS.md) - Пошаговое руководство
- [CLEANUP-LOG.md](CLEANUP-LOG.md) - Лог очистки репозитория

## 🔧 Использование Makefile

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

## 🚀 GitHub Actions

Автоматическая сборка на GitHub Actions с поддержкой:
- macOS Latest, 13, 14
- Intel (x86_64) и Apple Silicon (ARM64)
- Тестирование и создание пакетов

## 🎯 Особенности

- ✅ **Автоопределение архитектуры**
- ✅ **Оптимизация для каждой платформы**
- ✅ **Поддержка разработки и релизов**
- ✅ **Интеграция с VS Code**
- ✅ **CI/CD через GitHub Actions**
- ✅ **Подробная документация**

## 📖 Подробности

См. [README-macOS.md](README-macOS.md) для полной документации и [INSTALL-macOS.md](INSTALL-macOS.md) для пошагового руководства по установке.

## 🤝 Поддержка

При возникновении проблем:
1. Проверить версию Xcode и macOS
2. Убедиться в корректности путей к SDK
3. Проверить переменные окружения
4. Обратиться к документации Mozilla

## 📄 Лицензия

См. файл [LICENSE](LICENSE) в корне проекта.