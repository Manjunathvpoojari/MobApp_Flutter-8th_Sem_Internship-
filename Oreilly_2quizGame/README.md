# 📱 Flutter Quiz App

## 📌 Project Overview
This project is a Quiz Application built using Flutter as part of learning mobile app development. The app allows users to answer multiple-choice questions, calculates the score, and displays a summary of correct and incorrect answers at the end.

---

## 🚀 Features
- Interactive quiz interface  
- Multiple-choice questions with shuffled answers  
- Real-time answer selection  
- Result screen with score calculation  
- Detailed summary of each question  
- Restart quiz functionality  
- Clean and responsive UI  

---

## 🛠️ Technologies Used
- Flutter  
- Dart  
- Material UI  
- Google Fonts  

---

## 📂 Project Structure

```
lib/
│── data/
│ └── questions.dart
│── models/
│ └── quiz_question.dart
│── questions_summary/
│ ├── questions_summary.dart
│ ├── summary_items.dart
│ └── question_identifier.dart
│── answer_button.dart
│── question_screen.dart
│── result_screen.dart
│── start_screen.dart
│── quiz.dart
│── main.dart

```


---

## ⚙️ How It Works
1. The app starts with a **Start Screen**.  
2. On clicking *Start Quiz*, it navigates to the **Question Screen**.  
3. Questions are displayed one by one with shuffled answers.  
4. Selected answers are stored in a list.  
5. After answering all questions, the app navigates to the **Result Screen**.  
6. The result screen:
   - Calculates total correct answers  
   - Displays score  
   - Shows summary of each question  
7. User can restart the quiz anytime.

---

## 🧠 Key Concepts Learned
- Stateful vs Stateless Widgets  
- State Management using `setState()`  
- Passing data between widgets  
- Dynamic UI rendering using lists and maps  
- Layout handling with `Column`, `Expanded`, and `ScrollView`  
- Debugging Flutter layout and rendering errors  

---

## 🐞 Issues Faced & Fixes

### 1. Layout Overflow & Blank Screen
- Cause: Using `Expanded` inside `SingleChildScrollView`  
- Fix: Removed `Expanded` and handled scrolling properly  

### 2. Rendering Error
- Error: A circle cannot have a border radius  
- Cause: Used `borderRadius` with `BoxShape.circle`  
- Fix: Removed `borderRadius`  

### 3. Summary Not Displaying
- Cause: Layout constraints and widget hierarchy issues  
- Fix: Correct placement of scrollable widgets  

---

## 💡 Outcome
- Successfully built a fully functional quiz app  
- Improved understanding of Flutter layouts and debugging  
- Learned real-world problem-solving in UI rendering  

---

## 🔮 Future Improvements
- Add animations and transitions  
- Store quiz results using local database  
- Add timer for each question  
- Improve UI/UX with advanced design  

---

## 🙌 Conclusion
This project helped in gaining practical experience in Flutter development, especially in handling UI layouts, managing state, and debugging complex issues effectively.