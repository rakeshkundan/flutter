import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  // const ReusableCard({
  //   super.key,
  // });
  final Color? colour;
  final Widget cardChild;
  final VoidCallback? onPress; //final void Function() onPressed;
  const ReusableCard(
      {super.key,
      this.colour,
      this.cardChild = const SizedBox.expand(),
      this.onPress});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        // color: Color(0xFF1D1E33), ///Since we have used decoration property so we cannot define color saperately
        // ignore: prefer_const_constructors
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: colour,
        ),
        child: cardChild,
      ),
    );
  }
}
