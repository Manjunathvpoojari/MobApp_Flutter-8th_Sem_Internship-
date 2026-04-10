# 🍽️ Meal App

A Flutter-based meal browsing app built while following the **O'Reilly Flutter course**. Browse meals by category, filter by dietary preferences, and save your favorites — all with smooth animations and clean state management using Riverpod.

---

## 📱 Screenshots

> Run the app on an emulator or device to see it in action.

---

## ✨ Features

- 🗂️ **Category Browsing** — 10 meal categories displayed in an animated grid (Italian, Asian, German, French, and more)
- 🍜 **Meal Details** — View ingredients, step-by-step instructions, duration, complexity, and affordability
- ⭐ **Favorites** — Toggle any meal as a favorite with a smooth rotation animation; persists during the session
- 🔍 **Dietary Filters** — Filter meals by Gluten-Free, Lactose-Free, Vegetarian, and Vegan
- 🎞️ **Animations** — Slide-in transition on category screen, Hero image transitions, AnimatedSwitcher on the favorite star icon
- 🧭 **Navigation** — Bottom navigation bar + side drawer for quick access to Meals and Filters

---

## 🏗️ Project Structure

```
lib/
├── data/
│   └── dummy_data.dart        # All category and meal seed data
├── models/
│   ├── category.dart          # Category model
│   └── meal.dart              # Meal model with enums (Complexity, Affordability)
├── providers/
│   ├── meals_provider.dart    # Exposes the full meals list
│   ├── filters_provider.dart  # Filter state + filtered meals derived provider
│   └── favorites_provider.dart# Favorites toggle logic via StateNotifier
├── screens/
│   ├── tabs.dart              # Root screen with BottomNavigationBar
│   ├── categories.dart        # Animated category grid
│   ├── meals.dart             # Meal list for a selected category
│   ├── meal_details.dart      # Full detail view with Hero image
│   └── filters.dart           # SwitchListTile filter controls
└── widgets/
    ├── category_grid_item.dart # Gradient category card with InkWell
    ├── meal_item.dart          # Meal card with FadeInImage + Hero
    ├── meal_item_trait.dart    # Duration / Complexity / Affordability badge
    └── main_drawer.dart        # Side navigation drawer
```

---

## 🧰 Tech Stack

| Technology | Purpose |
|---|---|
| **Flutter** | UI framework |
| **Dart** | Programming language |
| **Riverpod** (`flutter_riverpod`) | State management (StateNotifier, Provider) |
| **Google Fonts** (`google_fonts`) | Lato font family |
| **Transparent Image** (`transparent_image`) | Fade-in placeholder for network images |
| **Material 3** | Design system with dark theme |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK installed ([flutter.dev](https://flutter.dev))
- Android Studio or VS Code with Flutter plugin
- An Android emulator or physical device

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/manjunathvpoojari/<repo-name>.git
cd <repo-name>

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

> ⚠️ Make sure your `AndroidManifest.xml` has internet permission:
> ```xml
> <uses-permission android:name="android.permission.INTERNET"/>
> ```

---

## 📦 Dependencies

```yaml
dependencies:
  flutter_riverpod: ^2.x.x
  google_fonts: ^6.x.x
  transparent_image: ^2.x.x
```

---

## 🗂️ Meal Data Overview

| ID | Title | Categories |
|----|-------|------------|
| m1 | Spaghetti with Tomato Sauce | Italian, Quick & Easy |
| m2 | Toast Hawaii | Quick & Easy |
| m3 | Classic Hamburger | Quick & Easy, Hamburgers |
| m4 | Wiener Schnitzel | German |
| m5 | Salad with Smoked Salmon | Quick & Easy, Light & Lovely, Summer |
| m6 | Delicious Orange Mousse | Exotic, Summer |
| m7 | Pancakes | Breakfast |
| m8 | Creamy Indian Chicken Curry | Asian |
| m9 | Chocolate Souffle | French |
| m10 | Asparagus Salad with Cherry Tomatoes | Quick & Easy, Light & Lovely, Summer |

---

## 🧠 Key Concepts Practiced

- **Riverpod state management** — `StateNotifier`, `StateNotifierProvider`, derived `Provider`
- **Flutter navigation** — `Navigator.push`, `MaterialPageRoute`, drawer navigation
- **Animations** — `AnimationController`, `SlideTransition`, `Hero`, `AnimatedSwitcher`, `RotationTransition`
- **Responsive layouts** — `GridView`, `ListView.builder`, `Stack`, `Positioned`
- **Dart language features** — `const` constructors, enums, string interpolation, collection `where()`

---

## 🐛 Known Issues Fixed

- Added `INTERNET` permission to `AndroidManifest.xml` (images were not loading on emulator)
- Replaced Wikipedia image URL for Spaghetti (was returning HTTP 429 rate-limit error)
- Fixed silent Dart string concatenation bug in meal `m5` categories (`'c2''c5'` → `'c2', 'c5'`)

---

## 📚 Course Reference

Built as part of the **O'Reilly Flutter & Dart - The Complete Guide** course.

---

## 👤 Author

**Manjunath V Poojari**
- GitHub: [@manjunathvpoojari](https://github.com/manjunathvpoojari)
- Portfolio: [manjunathvpoojari.github.io/Portfolio](https://manjunathvpoojari.github.io/Portfolio/)