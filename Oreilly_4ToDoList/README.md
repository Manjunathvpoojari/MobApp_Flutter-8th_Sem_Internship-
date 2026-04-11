# ✅ Flutter Internals — Todo App

A Flutter project built while learning **Flutter Internals** from the O'Reilly Flutter course. Focuses on understanding how Flutter's widget tree, element tree, and Keys work under the hood — demonstrated through a functional Todo app.

---

## 📱 Features

- ➕ **Add Todos** — Bottom sheet with text input and priority selector
- ☑️ **Check off Todos** — Strike-through effect when marked done
- 🗑️ **Swipe to Delete** — Dismissible cards with red delete background
- 🔃 **Sort A→Z / Z→A** — Toggle alphabetical order with sort button
- 🎨 **Priority Badges** — Urgent (red), Normal (blue), Low (green) with icons
- 😴 **Empty State** — Friendly message when no todos remain

---

## 🏗️ Project Structure

```
lib/
├── main.dart                       # App entry point, MaterialApp setup
├── models/
│   └── todo.dart                   # Todo class + Priority enum (single source of truth)
├── screens/
│   └── todos_screen.dart           # Main screen: list, sort, add, delete logic
└── widgets/
    ├── checkable_todo_item.dart    # Dismissible card with checkbox + priority chip
    └── add_todo_sheet.dart         # Modal bottom sheet for adding new todos
```

> **Note:** `demo_buttons.dart` and `ui_updates_demo.dart` are kept as learning references for Flutter's UI update mechanism (`setState`, widget rebuild behavior).

---

## 🧰 Tech Stack

| Technology | Purpose |
|---|---|
| **Flutter** | UI framework |
| **Dart** | Programming language |
| **Material 3** | Design system |
| **StatefulWidget** | Local state management |
| **Keys** (`ObjectKey`) | Correct widget identity during reordering |

---

## 🚀 Getting Started

```bash
# 1. Clone the repo
git clone https://github.com/manjunathvpoojari/<repo-name>.git
cd <repo-name>

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

---

## 🧠 Flutter Internals Concepts Practiced

### 🔑 Keys
Without keys, Flutter matches widgets by **position** in the tree. When items are reordered, checkbox state follows the wrong item.

```dart
// ❌ Without key — state gets mixed up on sort
CheckableTodoItem(todo.text, todo.priority)

// ✅ With ObjectKey — state correctly follows each todo object
CheckableTodoItem(key: ObjectKey(todo), todo: todo, onDelete: ...)
```

### 🌳 Widget vs Element Tree
- The **Widget tree** is immutable and rebuilt on every `setState`
- The **Element tree** persists and tracks state
- Flutter diffs the widget tree against the element tree to decide what to repaint
- `Keys` tell Flutter which element belongs to which widget across rebuilds

### 🔄 setState & Rebuilds
- `setState()` marks a widget dirty, triggering a rebuild of that subtree only
- Parent widgets don't rebuild unless their own state changes
- Demonstrated in `DemoButtons` — only `DemoButtons` rebuilds when Yes/No is pressed, not `UIUpdatesDemo`

---

## 🐛 Issues Refactored

| Issue | Original | Fixed |
|---|---|---|
| Duplicate `Priority` enum | Defined in both `todo_item.dart` and `checkable_todo_item.dart` | Moved to single `models/todo.dart` |
| Dead code in `main.dart` | `var numbers = [1,2,3]; numbers.add(4)` | Removed |
| No way to add todos | Hardcoded list only | Added `AddTodoSheet` with `showModalBottomSheet` |
| No way to delete todos | Not implemented | Added `Dismissible` swipe-to-delete |
| No empty state | Blank screen when list is empty | Added empty state widget |
| Bare UI | Plain rows, no visual hierarchy | Cards, priority chips, color coding |

---

## 📚 Course Reference

Built as part of the **O'Reilly Flutter & Dart - The Complete Guide** course — Flutter Internals section.

---

## 👤 Author

**Manjunath V Poojari**
- GitHub: [@manjunathvpoojari](https://github.com/manjunathvpoojari)
- Portfolio: [manjunathvpoojari.github.io/Portfolio](https://manjunathvpoojari.github.io/Portfolio/)