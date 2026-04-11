# 🛒 Flutter Shopping List App

A full-stack Flutter grocery management app that integrates with **Firebase Realtime Database** via REST API. Built as part of the O'Reilly Flutter course (Section 6).

---

## 📁 Project Structure

```
lib/
├── main.dart                   # App entry point & theme config
├── data/
│   └── categories.dart         # Static category color map
├── models/
│   ├── category.dart           # Category model + Categories enum
│   └── grocery_item.dart       # GroceryItem model
└── widgets/
    ├── grocery_list.dart        # Main list screen (StatefulWidget)
    └── new_item.dart            # Add item form screen
```

---

## ✨ Features

| Feature | Description |
|---|---|
| 📋 View grocery list | Loads items from Firebase on app start |
| ➕ Add item | Form with name, quantity, and category |
| 🗑️ Swipe to delete | Dismissible tiles with Firebase delete + optimistic rollback |
| 🎨 Category colors | 10 color-coded categories with visual indicators |
| ⏳ Loading states | CircularProgressIndicator while fetching |
| ❌ Error handling | Shows error message if HTTP request fails |

---

## 🔥 Firebase Integration

The app uses **Firebase Realtime Database** with plain HTTP (no Firebase SDK).

**Base URL:**
```
https://shopping-list-f31c8-default-rtdb.firebaseio.com/
```

### Endpoints Used

| Operation | Method | Endpoint |
|---|---|---|
| Load all items | `GET` | `/shopping-list.json` |
| Add new item | `POST` | `/shopping-list.json` |
| Delete item | `DELETE` | `/shopping-list/{id}.json` |

### Data Shape (per item in Firebase)

```json
{
  "-NxAbc123": {
    "name": "Tomatoes",
    "quantity": 3,
    "category": "Vegetables"
  }
}
```

> Firebase auto-generates the key (used as `id` in `GroceryItem`).

---

## 🧩 Data Models

### `Category` (`models/category.dart`)

```dart
class Category {
  final String title;
  final Color color;
}
```

### `GroceryItem` (`models/grocery_item.dart`)

```dart
class GroceryItem {
  final String id;       // Firebase auto-generated key
  final String name;
  final int quantity;
  final Category category;
}
```

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.x.x    # Used for all Firebase REST calls
```

Install with:
```bash
flutter pub get
```

---

## 🎨 Categories

| Category | Color |
|---|---|
| Vegetables | Green `#00FF80` |
| Fruit | Yellow-green `#91FF00` |
| Meat | Orange-red `#FF6600` |
| Dairy | Cyan `#00D0FF` |
| Carbs | Blue `#003CFF` |
| Sweets | Amber `#FF9500` |
| Spices | Yellow `#FFBB00` |
| Convenience | Purple `#BF00FF` |
| Hygiene | Violet `#9500FF` |
| Other | Teal `#00E1FF` |

---

## 🔄 App Flow

```
App Launch
    │
    ▼
GroceryList (initState)
    │── _loadedItems = _loadItems()   ← Future assigned once
    │
    ▼
FutureBuilder
    ├── waiting  → CircularProgressIndicator
    ├── error    → Error message text
    └── data     → ListView of Dismissible ListTiles

Add Item (+)
    │
    ▼
Navigator.push → NewItem screen
    │── Form: name, quantity, category dropdown
    │── POST to Firebase on submit
    └── Navigator.pop(newGroceryItem) → appended to list

Swipe to Delete
    │── Optimistically removes from UI
    │── DELETE request to Firebase
    └── On failure: re-inserts item at original index
```

---

## 🛠️ Key Implementation Details

### 1. FutureBuilder with `_loadedItems`
The future is stored in a field (not created inside `build()`) so it doesn't re-trigger on every rebuild:
```dart
late Future<List<GroceryItem>> _loadedItems;

@override
void initState() {
  super.initState();
  _loadedItems = _loadItems();   // assigned once
}
```

### 2. Category Matching on Load
When loading items from Firebase, the category string is matched back to a `Category` object:
```dart
final category = categories.entries
    .firstWhere((catItem) => catItem.value.title == item.value['category'])
    .value;
```

### 3. Optimistic Delete with Rollback
The item is removed from the UI immediately, but re-inserted if the HTTP delete fails:
```dart
final index = _groceryItems.indexOf(item);
setState(() { _groceryItems.remove(item); });

final response = await http.delete(url);
if (response.statusCode >= 400) {
  setState(() { _groceryItems.insert(index, item); });
}
```

### 4. `context.mounted` Guard
After `await` in `_saveItem()`, a mounted check prevents using a disposed context:
```dart
if (!context.mounted) return;
Navigator.of(context).pop(...);
```

---

## 🚀 Running the App

```bash
# Clone and navigate
cd Oreilly_6ShoppingList

# Install dependencies
flutter pub get

# Run on emulator or device
flutter run
```

> ⚠️ Requires active internet connection — all data is stored in Firebase Realtime Database.

---

## 📝 What Was Built Today

- [x] Firebase REST API integration (GET, POST, DELETE)
- [x] `FutureBuilder` for async list loading
- [x] `Dismissible` swipe-to-delete with optimistic UI
- [x] Form validation with `GlobalKey<FormState>`
- [x] Category color system with enum + map
- [x] Error + empty state handling
- [x] `context.mounted` safety after async gaps
- [x] Navigator push/pop with typed return value (`GroceryItem`)