import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "I Am Poor",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueGrey[600],
        ),
        body: const Center(
          child: Image(
            image: AssetImage("Assets/Images/coal.jpg"),
          ),
        ),
      ),
    ),
  );
}
