# Лог очистки репозитория

## Удаленные файлы конфигурации для других платформ

### Android конфигурации:
- `mozconfig-android-aarch64` - Android ARM64
- `mozconfig-android-armv7` - Android ARMv7
- `mozconfig-android-x86` - Android x86
- `mozconfig-android-x86_64` - Android x86_64
- `mozconfig-android-all` - Общая Android конфигурация

### Linux конфигурации:
- `mozconfig-linux-aarch64` - Linux ARM64
- `mozconfig-linux-arm` - Linux ARM
- `mozconfig-linux-i686` - Linux i686
- `mozconfig-linux-x86_64` - Linux x86_64
- `mozconfig-linux-x86_64-asan` - Linux x86_64 с ASAN
- `mozconfig-linux-x86_64-dev` - Linux x86_64 для разработки

### Windows конфигурации:
- `mozconfig-windows-i686` - Windows i686
- `mozconfig-windows-x86_64` - Windows x86_64

### Старые macOS конфигурации:
- `mozconfig-macos` - Устаревшая macOS конфигурация
- `mozconfig-macos-dev` - Устаревшая macOS конфигурация для разработки

### Другие файлы:
- `Dockerfile.macos` - Docker конфигурация (не нужна для нативной сборки)

## Оставшиеся файлы для macOS

### Конфигурации для релизных сборок:
- `mozconfig-macos-x86_64` - Intel (x86_64) релизная сборка
- `mozconfig-macos-arm64` - Apple Silicon (ARM64) релизная сборка
- `mozconfig-macos-universal` - Универсальная конфигурация с автоопределением

### Конфигурации для разработки:
- `mozconfig-macos-x86_64-dev` - Intel (x86_64) разработка
- `mozconfig-macos-arm64-dev` - Apple Silicon (ARM64) разработка

### Скрипты автоматизации:
- `build-macos.sh` - Автоматическая сборка
- `build-macos-dev.sh` - Сборка для разработки
- `macos-env.sh` - Настройка переменных окружения

### Инструменты сборки:
- `Makefile.macos` - Makefile для macOS
- `.github/workflows/macos-build.yml` - GitHub Actions для macOS

### Документация:
- `README-macOS.md` - Основная документация
- `INSTALL-macOS.md` - Пошаговое руководство по установке
- `.vscode/settings.json` - Настройки VS Code для macOS

## Результат очистки

Репозиторий теперь содержит **только** конфигурации и инструменты для сборки Mozilla/Gecko на macOS:

✅ **Поддерживаемые платформы:**
- macOS Intel (x86_64) - macOS 10.15+
- macOS Apple Silicon (ARM64) - macOS 11.0+

❌ **Удаленные платформы:**
- Android (все архитектуры)
- Linux (все архитектуры)
- Windows (все архитектуры)

## Преимущества очистки

1. **Фокус на macOS** - все конфигурации оптимизированы для macOS
2. **Упрощение** - меньше файлов для поддержки
3. **Чистота** - нет конфликтующих конфигураций
4. **Производительность** - быстрее поиск нужных файлов
5. **Поддержка** - легче поддерживать и обновлять

## Восстановление других платформ

Если в будущем понадобится поддержка других платформ, можно:

1. Восстановить из git истории: `git checkout HEAD~1 -- mozconfig-*`
2. Создать новые конфигурации на основе существующих
3. Использовать официальные конфигурации Mozilla

## Заключение

Репозиторий успешно очищен от конфигураций для других платформ. Теперь он содержит только необходимые файлы для сборки Mozilla/Gecko на macOS с поддержкой обеих архитектур.