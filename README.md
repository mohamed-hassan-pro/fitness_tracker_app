# 🏋️ Fitness Tracker App

A premium, Clean Architecture Flutter application for tracking fitness activities. Features dynamic charts, local database storage, and a beautiful modern dark UI.

## 🌟 Features
- **Clean Architecture:** Strict separation of Domain, Data, and Presentation layers.
- **Dynamic Charts:** Built with `fl_chart` to visualize recent activities and calories burned.
- **Local Persistence:** High-performance SQLite database via `sqflite`.
- **State Management:** Fully reactive UI using `flutter_bloc` (Cubits).
- **Modern UI/UX:** Dark theme, glassmorphic elements, and single-responsibility modular widgets.

## 🏗️ Architecture & Best Practices
- **Domain Layer:** Contains core business logic, entities (`Activity`), and repository interfaces.
- **Data Layer:** Handles data retrieval, models mapping, and SQLite storage (`ActivityRepositoryImpl`).
- **Presentation Layer:** Contains UI widgets and State Management (`ActivityCubit`).
- **Modular Code:** Strict adherence to SOLID principles, with UI components isolated to prevent exceeding 100 lines per file.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable)
- Dart SDK

### Run the App
```bash
git clone https://github.com/mohamed-hassan-pro/fitness_tracker_app.git
cd fitness_tracker_app
flutter pub get
flutter run
```

## 👨‍💻 Developer
Developed by **Mohamed Hassan** (CodeAlpha Intern: **CA/DF1/55715**) as part of the App Development track.
