import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() {
  runApp(DiceApp());
}

class DiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: DicePage());
  }
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage>
    with SingleTickerProviderStateMixin {
  int diceNumber = 1;
  bool isRolling = false;

  AnimationController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  void rollDice() {
    if (isRolling) return;

    setState(() {
      isRolling = true;
    });

    int counter = 0;

    Timer.periodic(Duration(milliseconds: 80), (timer) {
      setState(() {
        diceNumber = Random().nextInt(6) + 1;
      });

      _controller?.forward(from: 0);

      counter++;

      if (counter >= 10) {
        timer.cancel();

        setState(() {
          isRolling = false; // 🔥 FIX: button re-enabled properly
        });
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text('Dice Game'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedBuilder(
              animation: _controller!,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller!.value * 2 * pi,
                  child: Transform.scale(
                    scale: 1 + (_controller!.value * 0.3),
                    child: child,
                  ),
                );
              },
              child: Image.asset(
                'assets/images/dice_$diceNumber.png',
                width: 150,
                key: ValueKey(diceNumber), // 🔥 fixes image caching issue
              ),
            ),
          ),

          SizedBox(height: 40),

          ElevatedButton(
            onPressed: isRolling ? null : rollDice,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              backgroundColor: Colors.white,
            ),
            child: Text(
              'Roll Dice',
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
