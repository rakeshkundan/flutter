// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onPress;
  const RoundIconButton({super.key, @required this.icon, this.onPress});
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 6.0,
      disabledElevation: 6.0,
      constraints: BoxConstraints.tightFor(width: 56.0, height: 56.0),
      shape: CircleBorder(),
      onPressed: onPress,
      fillColor: Color(0xFF4C4F5E),
      child: Icon(icon),
    );
  }
}
