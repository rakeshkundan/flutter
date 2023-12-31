// ignore: unused_import
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  void playSound(int number) {
    final player = AudioPlayer();
    player.play(
      AssetSource('note$number.wav'),
    );
  }

  Expanded buildKey({required Color color, required int boxNumber}) {
    // String col = 'Colors.' + color;
    return Expanded(
      // height: 100,
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: color, shape: const RoundedRectangleBorder()),
        onPressed: () {
          playSound(boxNumber);
        },
        child: const Text(''),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildKey(color: Colors.red, boxNumber: 1),
          buildKey(color: Colors.orange, boxNumber: 2),
          buildKey(color: Colors.yellow, boxNumber: 3),
          buildKey(color: Colors.green, boxNumber: 4),
          buildKey(color: Colors.blue, boxNumber: 5),
          buildKey(color: Colors.indigo, boxNumber: 6),
          buildKey(color: Colors.purple, boxNumber: 7),
        ],
      ),
    );
  }
}

// onPressed: () async {
// final player = AudioPlayer();
// player.play(AssetSource('note1.wav'));
// },
