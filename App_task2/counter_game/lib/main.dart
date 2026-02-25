import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ClickCounterGame(),
    );
  }
}

class ClickCounterGame extends StatefulWidget {
  const ClickCounterGame({super.key});

  @override
  State<ClickCounterGame> createState() => _ClickCounterGameState();
}

class _ClickCounterGameState extends State<ClickCounterGame> {
  int score = 0;

  void increase() {
    setState(() {
      score++;
    });
  }

  void resetScore() {
    setState(() {
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Click Counter Game 🎮"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Score",
              style: TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 10),
            Text(
              "$score",
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: increase,
              child: const Text("Click Me!"),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: resetScore,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text("Reset"),
            ),
          ],
        ),
      ),
    );
  }
}
