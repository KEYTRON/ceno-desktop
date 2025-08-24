# История изменений

## [1.0.0] - 2024-08-24

### ✨ Добавлено
- **Конфигурации для macOS Intel (x86_64)**:
  - `mozconfig-macos-x86_64` - релизная сборка
  - `mozconfig-macos-x86_64-dev` - разработка
  - Поддержка macOS 10.15+ (Catalina)

- **Конфигурации для macOS Apple Silicon (ARM64)**:
  - `mozconfig-macos-arm64` - релизная сборка
  - `mozconfig-macos-arm64-dev` - разработка
  - Поддержка macOS 11.0+ (Big Sur)

- **Универсальная конфигурация**:
  - `mozconfig-macos-universal` - автоопределение архитектуры

- **Скрипты автоматизации**:
  - `build-macos.sh` - автоматическая сборка
  - `build-macos-dev.sh` - сборка для разработки
  - `macos-env.sh` - настройка переменных окружения

- **Инструменты сборки**:
  - `Makefile.macos` - Makefile с командами для macOS
  - `.github/workflows/macos-build.yml` - GitHub Actions CI/CD

- **Интеграция с IDE**:
  - `.vscode/settings.json` - настройки VS Code
  - Задачи сборки и отладки

- **Документация**:
  - `README.md` - основной README
  - `README-macOS.md` - подробная документация
  - `INSTALL-macOS.md` - пошаговое руководство

### 🗑️ Удалено
- **Android конфигурации**:
  - `mozconfig-android-aarch64`
  - `mozconfig-android-armv7`
  - `mozconfig-android-x86`
  - `mozconfig-android-x86_64`
  - `mozconfig-android-all`

- **Linux конфигурации**:
  - `mozconfig-linux-aarch64`
  - `mozconfig-linux-arm`
  - `mozconfig-linux-i686`
  - `mozconfig-linux-x86_64`
  - `mozconfig-linux-x86_64-asan`
  - `mozconfig-linux-x86_64-dev`

- **Windows конфигурации**:
  - `mozconfig-windows-i686`
  - `mozconfig-windows-x86_64`

- **Устаревшие macOS конфигурации**:
  - `mozconfig-macos`
  - `mozconfig-macos-dev`

- **Другие файлы**:
  - `Dockerfile.macos` - не нужен для нативной сборки

### 🔧 Изменено
- **GitHub Actions**: обновлен для поддержки только macOS
- **Makefile**: оптимизирован для macOS сборки
- **VS Code настройки**: настроены для macOS разработки
- **Документация**: обновлена, убраны упоминания других платформ

### 📋 Технические детали
- **Целевые архитектуры**: `x86_64-apple-darwin`, `arm64-apple-darwin`
- **Минимальные версии macOS**: 10.15 (Intel), 11.0 (Apple Silicon)
- **Toolkit**: `cairo-cocoa` для нативного macOS интерфейса
- **Оптимизация**: включены Rust SIMD и оптимизации компилятора
- **Отладка**: отдельные конфигурации для разработки с отключенным strip

### 🎯 Результат
Репозиторий теперь содержит **только** конфигурации и инструменты для сборки Mozilla/Gecko на macOS с полной поддержкой обеих архитектур Intel и Apple Silicon.

---

## Планы на будущее

- [ ] Добавить поддержку macOS 15+ (Sequoia)
- [ ] Оптимизация для новых Apple Silicon чипов
- [ ] Интеграция с Xcode Cloud
- [ ] Автоматическое тестирование на разных версиях macOS
- [ ] Поддержка Universal Binary (Intel + ARM64 в одном файле)