import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100.0,
                color: Colors.red,
                height: double.infinity,
              ),
              Container(
                width: 100.0,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100.0,
                      width: 100.0,
                      color: Colors.yellow,
                    ),
                    Container(
                      height: 100.0,
                      width: 100.0,
                      color: Colors.green,
                    )
                  ],
                ),
              ),
              Container(
                width: 100.0,
                color: Colors.blue,
                height: double.infinity,
              ),
            ],
          ),
          // child: Column(
          //   // mainAxisSize: MainAxisSize.min,
          //   // verticalDirection: VerticalDirection.down,
          //   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     Container(
          //       color: Colors.blue,
          //       height: 100,
          //       width: 100,
          //       margin: const EdgeInsets.all(10),
          //       padding: const EdgeInsets.all(5),
          //       child: const Text("Container 1"),
          //     ),
          //     const SizedBox(
          //       height: 20,
          //     ), /////This is just to do spacing between two Container,
          //     Container(
          //       color: Colors.green,
          //       height: 100,
          //       width: 100,
          //       margin: const EdgeInsets.all(10),
          //       padding: const EdgeInsets.all(5),
          //       child: const Text("Container 2"),
          //     ),
          //     Container(
          //       color: Colors.red,
          //       height: 100,
          //       width: 100,
          //       margin: const EdgeInsets.all(10),
          //       padding: const EdgeInsets.all(5),
          //       child: const Text("Container 3"),
          //     ),
          //     Container(
          //       ////This is invisible Container Just to see crossAxisAlignment
          //       width:
          //           double.infinity, /////This makes the width of Container 100%
          //     )
          //   ],
          // ),
        ),
      ),
    );
  }
}
