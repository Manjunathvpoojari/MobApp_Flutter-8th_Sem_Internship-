import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

void main() {
  runApp(DecisionApp());
}

class DecisionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Decision Maker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: DecisionHome(),
    );
  }
}

class DecisionHome extends StatefulWidget {
  @override
  _DecisionHomeState createState() => _DecisionHomeState();
}

class _DecisionHomeState extends State<DecisionHome> {

  final TextEditingController _controller = TextEditingController();

  List<String> options = [
    "Pizza",
    "Burger",
    "Dosa"
  ];

  final StreamController<int> controller = StreamController<int>();

  String result = "";

  void spinWheel() {
    final selected = Fortune.randomInt(0, options.length);
    controller.add(selected);

    setState(() {
      result = options[selected];
    });
  }

  void addOption() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        options.add(_controller.text);
        _controller.clear();
      });
    }
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Decision Maker Wheel"),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [

            SizedBox(height: 20),

            Expanded(
              child: FortuneWheel(
                selected: controller.stream,
                items: [
                  for (var option in options)
                    FortuneItem(child: Text(option))
                ],
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Add Choice",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: addOption,
              child: Text("Add Option"),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: spinWheel,
              child: Text("SPIN"),
            ),

            SizedBox(height: 20),

            Text(
              result.isEmpty
                  ? "Spin to decide!"
                  : "Result: $result",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}