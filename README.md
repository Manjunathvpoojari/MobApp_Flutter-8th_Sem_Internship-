# MobApp Flutter – 8th Semester Internship

This repository contains Flutter mobile application assignments assigned by my mentor as part of my 8th semester internship.

The repository will be updated weekly with new tasks and learning progress.

---

## Week  (Phase 1: Learning Flutter)

**14-Feb-2026**

### App Task 1 – My Digital Card
- Built a simple profile card UI using `StatelessWidget`
- Displayed personal information such as name, student ID, and course
- Used `Container`, `Column`, and `Row` widgets for layout
- Added icons and styling for better UI presentation 

### App Task 2 – Click Counter Game
- Implemented a simple interactive game using `StatefulWidget`
- Displayed a score starting from 0
- Added a **"Click Me"** button to increase the score
- Added a **Reset** button to reset the score
- Used `setState()` to update the UI dynamically 

---

**15-Feb-2026**

### App Task 3 – Quote of the Day
- Created a list of multiple quotes
- Displayed one quote on the screen at a time
- Added a **Next Quote** button to show a new quote
- Implemented looping logic to restart quotes after the last one
- Used `StatefulWidget` with list management

---

## Week  (Phase 2: Front-End Flutter)

**21-Feb-2026**

### App Task 4 – Contact Manager App
- Built a **two-screen contact management app**
- Displayed contacts using `ListView` and `ListTile`
- Added a **FloatingActionButton** to add new contacts
- Implemented navigation between screens using `Navigator.push`
- Used `AlertDialog` to show contact details
- Displayed success messages using `SnackBar` 

---

**22-Feb-2026**

### App Task 5 – Photo Gallery App
- Created a photo gallery layout using `GridView`
- Displayed colored containers representing images
- Used `Stack` widget to overlay text on images
- Implemented `BottomSheet` options (View, Share, Delete)
- Added navigation to a full-screen photo view page 

---
---


**28-Feb-2026**

### App Task (your choice app) – Decision Maker App (Creative Choice)

- Developed an interactive **Decision Maker Wheel** application.
- Implemented a spinning wheel using the `flutter_fortune_wheel` package.
- Allowed users to dynamically add custom decision options.
- Used `TextEditingController` for handling real-time user input.
- Implemented randomized selection logic for unbiased decision-making.
- Displayed the selected result dynamically after wheel rotation.
- Managed application state using `StatefulWidget`.
- Practiced animation integration and user interaction handling.

---

## Week (Phase 3: Firebase Integration and CRUD Operation)
  
  **14-03-2026**

## App Task 6 - Employee Management Page (on existing login page)

- This is primarily an assignment task on existing login page app which is in different repo 
- I am just showing my work in this assignments as weekend work task assigned by our mentors

## Tasks Implemented

### Task 1 – Employee Model
Created an `Employee` class with fields:
- id
- name
- age
- department
- salary
- email  

Includes:
- `toMap()` to store data in Firestore  
- `fromFirestore()` to convert Firestore data to an Employee object

### Task 2 – EmployeeService
Service class for Firestore operations:
- `getEmployees()` – Fetch employees ordered by name  
- `addEmployee()` – Add new employee  
- `updateEmployee()` – Update existing employee  
- `deleteEmployee()` – Delete employee by ID  

### Task 3 – CRUD UI
Main page displays employees in cards showing:
- Name
- Email
- Department
- Salary
- Age  

Includes:
- Floating button to add employee
- Edit option with pre-filled form
- Delete option with confirmation dialog
- Form validation for required fields

### Task 4 – Search Feature
Search bar in the AppBar that:
- Toggles between title and search field
- Searches by name or email
- Shows result count or "No results found"

### Task 5 – Department Filter
Filter chips:
`All | HR | IT | Finance | Marketing`

- Filters employees by department
- Uses Firestore `.where()` query

### Bonus
Salary summary bar showing: 



*This repository will continue to be updated with weekly tasks throughout the internship.*