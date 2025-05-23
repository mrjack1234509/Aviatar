import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aviator Clone',
      home: AviatorGame(),
    );
  }
}

class AviatorGame extends StatefulWidget {
  @override
  _AviatorGameState createState() => _AviatorGameState();
}

class _AviatorGameState extends State<AviatorGame> {
  double multiplier = 1.0;
  Timer? timer;
  bool isFlying = false;

  void startGame() {
    setState(() {
      multiplier = 1.0;
      isFlying = true;
    });
    timer = Timer.periodic(Duration(milliseconds: 100), (_) {
      setState(() {
        multiplier += 0.1;
      });
    });
  }

  void cashOut() {
    if (isFlying) {
      timer?.cancel();
      setState(() {
        isFlying = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You cashed out at x${multiplier.toStringAsFixed(2)}')),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Aviator Clone')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('x${multiplier.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isFlying ? cashOut : startGame,
              child: Text(isFlying ? 'Cash Out' : 'Start'),
            ),
          ],
        ),
      ),
    );
  }
}
