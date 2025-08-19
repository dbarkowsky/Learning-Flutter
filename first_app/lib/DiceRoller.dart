import 'dart:math';

import 'package:flutter/material.dart';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  final randomizer = Random();
  int diceNumber = 1; // So variable is here.

  void roll() {
    // But it's not set unless in setState when called
    setState(() {
      diceNumber = (randomizer.nextInt(6) + 1);
    });
    print(diceNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/dice-$diceNumber.png', width: 200),
        TextButton(
          onPressed: roll,
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.blueAccent,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            textStyle: TextStyle(fontSize: 28),
          ),
          child: Text("Roll"),
        ),
      ],
    );
  }
}
