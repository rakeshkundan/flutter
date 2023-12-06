import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('Dicee'),
          backgroundColor: Colors.red[900],
        ),
        body: SafeArea(
          child: DicePage(),
        ),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNumber = 1, rightDiceNumber = 1;
  String winner = "Start Game";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // margin: EdgeInsets.all(30),
        // height: 250,
        // color: Colors.blueGrey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  // margin: EdgeInsets.all(20),
                  child: Text(
                "$winner",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              )),
              Expanded(
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          // print('I am Left Button');
                          // setState(() {
                          //   leftDiceNumber = Random().nextInt(6) + 1;
                          //   winner = leftDiceNumber > rightDiceNumber
                          //       ? 'Player 1'
                          //       : leftDiceNumber == rightDiceNumber
                          //       ? 'draw'
                          //       : 'Player 2';
                          // });

                          // print(leftDiceNumber);
                        },
                        child: Image.asset('images/dice$leftDiceNumber.png'),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        child: Image.asset('images/dice$rightDiceNumber.png'),
                        onPressed: () {
                          // print('I am Right Button');
                          // setState(() {
                          //   rightDiceNumber = Random().nextInt(6) + 1;
                          //   winner = leftDiceNumber > rightDiceNumber
                          //       ? 'Player 1'
                          //       : leftDiceNumber == rightDiceNumber
                          //           ? 'draw'
                          //           : 'Player 2';
                          // });
                        },
                        style: ButtonStyle(),
                      ),
                    ),
                  ],
                ),
              ),
              FloatingActionButton.large(
                onPressed: () {
                  setState(() {
                    leftDiceNumber = Random().nextInt(6) + 1;
                    rightDiceNumber = Random().nextInt(6) + 1;
                    winner = leftDiceNumber > rightDiceNumber
                        ? 'Player 1'
                        : leftDiceNumber == rightDiceNumber
                            ? 'draw'
                            : 'Player 2';
                  });
                },
                child: Icon(Icons.play_arrow),
              )
            ],
          ),
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return const Placeholder();
  // }
}

// class DicePage extends StatelessWidget {}
