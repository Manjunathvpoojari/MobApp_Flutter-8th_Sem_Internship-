# Expense Tracker App

## Overview
The Expense Tracker is a Flutter-based mobile application developed to help users manage and track their daily expenses efficiently. The application allows users to record expenses, categorize them, and visualize spending patterns through a simple and intuitive interface.

## Features
- Add expenses with title, amount, date, and category
- View a list of all recorded expenses
- Delete expenses using swipe gesture
- Undo deleted expenses using SnackBar
- Category-wise expense visualization using charts
- Light and Dark theme support
- Input validation for accurate data entry
- Responsive and user-friendly UI

## Tech Stack
- Framework: Flutter
- Language: Dart
- State Management: Stateful Widgets
- Packages:
  - uuid (for unique IDs)
  - intl (for date formatting)

## Project Structure
```

lib/
│── main.dart
│
├── models/
│   └── expense.dart
│
├── widgets/
│   ├── expenses.dart
│   ├── new_expense.dart
│   │
│   ├── chart/
│   │   ├── chart.dart
│   │   └── chart_bar.dart
│   │
│   └── expenses_list/
│       ├── expenses_list.dart
│       └── expenses_item.dart

```
## Functionality
The application uses a structured data model to store expense details such as title, amount, date, and category. Users can add new expenses through a modal bottom sheet with proper validation. All expenses are displayed in a list format, and users can remove items using swipe gestures with an undo option provided via SnackBar.

A chart component is implemented to visually represent category-wise spending. The UI adapts dynamically based on the data and supports both light and dark themes for better user experience.

## Challenges
- Handling layout constraints and RenderBox errors
- Managing widget sizing inside Column and Expanded
- Ensuring responsive UI across different screen sizes
- Debugging using Flutter DevTools

## Solutions
- Applied proper layout constraints using SizedBox and Expanded
- Used MediaQuery for responsive design
- Implemented efficient state updates using setState
- Structured code for readability and maintainability

## Future Enhancements
- Integration with local database (SQLite) or Firebase
- Add expense editing functionality
- Implement filters for monthly and yearly reports
- Improve UI with animations and advanced charts

## Learning Outcomes
- Understanding Flutter UI design and layout management
- Working with state management in Flutter
- Debugging and resolving rendering issues
- Building a complete real-world application

## How to Run
1. Clone the repository
2. Run `flutter pub get`
3. Connect an emulator or physical device
4. Run `flutter run`

## Conclusion
This project demonstrates the practical implementation of Flutter concepts including UI development, state management, and data handling. It serves as a foundation for building scalable and production-ready mobile applications.