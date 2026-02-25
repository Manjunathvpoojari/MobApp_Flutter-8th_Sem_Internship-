import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: MyCard());
  }
}

class MyCard extends StatelessWidget {
  const MyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      body: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              // TEMP image (no asset error)
              const CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage("assets/profile.jpg"),
              ),

              SizedBox(height: 15),

              Text(
                "Manjunath V Poojari",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 8),

              Text(
                "Student ID: 4JN22CS077",
                style: TextStyle(color: Colors.white),
              ),

              Text(
                "Course: Computer Science & Engineering",
                style: TextStyle(color: Colors.white),
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.email, color: Colors.white),
                  Icon(Icons.phone, color: Colors.white),
                  Icon(Icons.school, color: Colors.white),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
