# CalcPro - Clean Architecture Structure

This project follows a professional 6-layer clean architecture pattern.

## 📊 Layer Overview

### 1. 🎨 **Presentation Layer** (`presentation/`)
**Purpose**: User Interface  
**Contains**: Pages, widgets, routing, UI logic  
**Imports**: application, utils only

```
presentation/
├── pages/
│   └── calculator_page.dart      # Full calculator screen
└── widgets/
    ├── calculator_display.dart   # Display widget
    ├── button_grid.dart          # Button layout
    └── calc_button.dart          # Reusable button
```

### 2. 📱 **Application Layer** (`application/`)
**Purpose**: App State & Business Logic  
**Contains**: Riverpod providers, StateNotifiers, use cases  
**Imports**: domain, utils only

```
application/
├── providers/
│   └── calculator_provider.dart  # Riverpod provider
└── controllers/
    ├── calculator_notifier.dart  # State management logic
    └── calculator_state.dart     # App state model
```

### 3. 🎯 **Domain Layer** (`domain/`)
**Purpose**: Business Models & Rules  
**Contains**: Entities, value objects, abstract repositories  
**Imports**: NOTHING (pure Dart, no external dependencies)

```
domain/
├── models/
│   └── calculation_model.dart    # Business entity
├── value_objects/
│   └── math_operator.dart        # Immutable value types
└── repositories/
    └── calculation_repository.dart  # Abstract interface
```

### 4. 🔧 **Infrastructure Layer** (`infrastructure/`)
**Purpose**: Data & External Services  
**Contains**: Concrete repositories, data sources, mappers  
**Imports**: domain only

```
infrastructure/
├── repositories/
│   └── calculation_repository_impl.dart  # Concrete implementation
├── data_sources/
│   ├── local/
│   │   └── local_calculation_data_source.dart      # SharedPreferences
│   └── remote/
│       └── remote_calculation_data_source.dart     # API client
└── mappers/
    └── calculation_mapper.dart   # DTO ↔ Domain conversions
```

### 5. 🛠️ **Utils Layer** (`utils/`)
**Purpose**: Shared Utilities & Helpers  
**Contains**: Pure functions, extensions, constants, theme  
**Imports**: NOTHING from other layers

```
utils/
├── calculator/
│   ├── expression_evaluator.dart # Math logic
│   └── number_formatter.dart     # Formatting utilities
└── theme/
    └── app_theme.dart            # Colors, typography
```

### 6. 🌍 **Localization Layer** (`l10n/`)
**Purpose**: Multi-language Support  
**Contains**: ARB files, translation strings

```
l10n/
├── app_en.arb       # English translations
└── app_es.arb       # (Future: Spanish translations)
```

---

## 🔄 Data Flow

```
User Input (UI)
    ↓
Presentation (Pages/Widgets)
    ↓
Application (Providers/Controllers)
    ↓
Domain (Business Logic)
    ↓
Infrastructure (Data Sources)
    ↓
Storage/API
```

---

## 📋 Dependency Rules

**ALLOWED** (Downward dependencies only):
- Presentation → Application, Utils
- Application → Domain, Utils
- Infrastructure → Domain, Utils
- Utils → Nothing (pure utilities)

**FORBIDDEN** (Upward dependencies):
- Domain → anything (pure, independent)
- Infrastructure → Presentation/Application
- Utils → any layer

---

## ✨ Best Practices

1. **Domain First**: Define business logic in domain layer
2. **Immutability**: Use `final` and `const` extensively
3. **Pure Functions**: Domain logic has no side effects
4. **Testability**: Each layer is independently testable
5. **SOLID Principles**: Follow single responsibility
6. **Error Handling**: Use Exceptions in domain, Result types in application

---

## 🚀 Future Extensions

This architecture supports:
- ✅ Adding remote API integration
- ✅ Local database storage
- ✅ Multi-language support (l10n)
- ✅ Advanced state management
- ✅ Unit & integration testing
- ✅ Feature modules separation

---

## 📚 References

- Clean Architecture: https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html
- Riverpod: https://riverpod.dev
- Flutter Best Practices: https://flutter.dev/docs
