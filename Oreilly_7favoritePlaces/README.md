# 📍 Favorite Places App

A Flutter app to save your favorite places with **photos**, **GPS location**, and **Google Maps integration**. All data is persisted locally using **SQLite** via `sqflite`. State is managed with **Riverpod**.

Built as part of the O'Reilly Flutter course (Section 7).

---

## 📁 Project Structure

```
lib/
├── main.dart                        # App entry point, theme & ProviderScope
├── models/
│   └── place.dart                   # Place & PlaceLocation models
├── providers/
│   └── user_places.dart             # Riverpod StateNotifier + SQLite logic
├── screens/
│   ├── places.dart                  # Home screen — list of saved places
│   ├── add_place.dart               # Form screen — add new place
│   ├── place_detail.dart            # Detail screen — image + map thumbnail
│   └── map.dart                     # Interactive Google Map (pick or view)
└── widgets/
    ├── places_list.dart             # ListView of place tiles
    ├── image_input.dart             # Camera capture widget
    └── location_input.dart          # GPS / map location picker widget
```

---

## ✨ Features

| Feature | Description |
|---|---|
| 📷 Camera capture | Take a photo directly from the device camera |
| 📍 GPS location | Auto-fetch current location via device GPS |
| 🗺️ Map picker | Tap on Google Map to select a custom location |
| 🏠 Reverse geocoding | Converts lat/lng to a human-readable address |
| 💾 SQLite persistence | Places saved locally — survive app restarts |
| 🗂️ Riverpod state | `StateNotifier` manages the places list globally |
| 🔍 Place detail | Full-screen image with static map thumbnail overlay |
| 🗺️ View on map | Tap the map thumbnail to open full interactive map |

---

## 🧩 Data Models

### `PlaceLocation` (`models/place.dart`)

```dart
class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;    // reverse-geocoded by Google Geocoding API
}
```

### `Place` (`models/place.dart`)

```dart
class Place {
  final String id;          // UUID auto-generated
  final String title;
  final File image;         // copied to app documents directory
  final PlaceLocation location;
}
```

---

## 🗄️ SQLite Schema

**Database file:** `places.db`
**Table:** `user_places`

```sql
CREATE TABLE user_places (
  id       TEXT PRIMARY KEY,
  title    TEXT,
  image    TEXT,      -- absolute file path in app documents dir
  lat      REAL,
  lng      REAL,
  address  TEXT
)
```

### Operations

| Operation | Method | Where |
|---|---|---|
| Open / create DB | `sql.openDatabase()` | `_getDatabase()` |
| Load all places | `db.query('user_places')` | `loadPlaces()` |
| Insert new place | `db.insert(...)` | `addPlace()` |

---

## 🌐 External APIs Used

### 1. Google Maps Flutter SDK
- **Used in:** `map.dart`
- Interactive map for picking or viewing a location
- `GoogleMap` widget with `onTap` for location selection
- `Marker` placed at selected/existing coordinates

### 2. Google Static Maps API
- **Used in:** `location_input.dart`, `place_detail.dart`
- Renders a map preview image via URL — no SDK needed

```
https://maps.googleapis.com/maps/api/staticmap
  ?center={lat},{lng}
  &zoom=16
  &size=600x300
  &maptype=roadmap
  &markers=color:red|label:A|{lat},{lng}
  &key=YOUR_API_KEY
```

### 3. Google Geocoding API
- **Used in:** `location_input.dart` → `_savePlace()`
- Converts raw `lat/lng` → human-readable address string

```
https://maps.googleapis.com/maps/api/geocode/json
  ?latlng={lat},{lng}
  &key=YOUR_API_KEY
```

---

## 🔄 App Flow

```
App Launch
    │
    ▼
PlacesScreen (initState)
    │── _placesFuture = loadPlaces()    ← reads SQLite
    │
    ▼
FutureBuilder
    ├── waiting → CircularProgressIndicator
    └── done    → PlacesList (from Riverpod userPlacesProvider)

Add Place (+)
    │
    ▼
AddPlaceScreen
    ├── ImageInput   → camera → File saved to app documents dir
    ├── LocationInput
    │     ├── Get Current Location → GPS → Geocoding API → address
    │     └── Select on Map → MapScreen (isSelecting: true) → lat/lng → Geocoding API
    │
    └── Save → addPlace() → SQLite INSERT + Riverpod state update → pop()

Tap Place Tile
    │
    ▼
PlaceDetailScreen
    ├── Full-screen photo (Image.file)
    ├── Static map thumbnail (CircleAvatar + NetworkImage)
    └── Tap thumbnail → MapScreen (isSelecting: false) — view only
```

---

## 🧠 State Management — Riverpod

### Provider

```dart
final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
      (ref) => UserPlacesNotifier(),
    );
```

### `UserPlacesNotifier` methods

| Method | What it does |
|---|---|
| `loadPlaces()` | Reads all rows from SQLite → sets `state` |
| `addPlace(title, image, location)` | Copies image file → inserts into SQLite → prepends to `state` |

### How screens use it

```dart
// Read + trigger action (no rebuild)
ref.read(userPlacesProvider.notifier).addPlace(...);

// Watch for UI rebuilds
final userPlaces = ref.watch(userPlacesProvider);
```

---

## 📷 Image Handling

1. User taps **Take Picture** → `ImagePicker` opens camera
2. `XFile` path → wrapped in `File`
3. On save, image is **copied** to `getApplicationDocumentsDirectory()`
4. The **copied path** is stored in SQLite (original temp path would be cleared by OS)

```dart
final appDir = await syspaths.getApplicationDocumentsDirectory();
final filename = path.basename(image.path);
final copiedImage = await image.copy('${appDir.path}/$filename');
```

---

## 📦 Dependencies

```yaml
dependencies:
  flutter_riverpod: ^2.x.x      # State management
  google_fonts: ^6.x.x          # Ubuntu Condensed font
  google_maps_flutter: ^2.x.x   # Interactive map widget
  location: ^5.x.x              # Device GPS access
  image_picker: ^1.x.x          # Camera / gallery
  http: ^1.x.x                  # Geocoding API calls
  sqflite: ^2.x.x               # Local SQLite database
  path_provider: ^2.x.x         # App documents directory path
  path: ^1.x.x                  # File path utilities
  uuid: ^4.x.x                  # UUID generation for Place IDs
```

---

## 🚀 Running the App

```bash
cd Oreilly_7favoritePlaces
flutter pub get
flutter run
```

> ⚠️ Requires a **physical device** or emulator with:
> - Camera support (for image capture)
> - Google Play Services (for Maps & Location)
> - Internet access (for Geocoding & Static Maps API)

---

## 🔑 API Key Note

The Google Maps, Static Maps, and Geocoding API key is currently hardcoded in:
- `location_input.dart` — Geocoding + Static Maps
- `place_detail.dart` — Static Maps

For production, move the key to a `.env` file or use `--dart-define` with a secrets manager.

---

## 📝 What Was Built Today

- [x] `Place` and `PlaceLocation` models with UUID ID generation
- [x] SQLite database setup with `sqflite` (`places.db`)
- [x] `UserPlacesNotifier` with `loadPlaces()` and `addPlace()`
- [x] Riverpod `StateNotifierProvider` wiring
- [x] `PlacesScreen` with `FutureBuilder` + Riverpod watch pattern
- [x] `AddPlaceScreen` with title, image, and location inputs
- [x] `ImageInput` widget — camera capture + preview
- [x] `LocationInput` widget — GPS + map picker + static map preview
- [x] Google Geocoding API — lat/lng → address string
- [x] `MapScreen` — dual-mode (selecting vs viewing)
- [x] `PlaceDetailScreen` — full-screen image + tappable map thumbnail
- [x] Image copied to permanent app directory before saving