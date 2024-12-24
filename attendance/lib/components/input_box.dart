// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

class InputBox extends StatelessWidget {
  final String label;
  final TextEditingController textController;
  final bool obscText;
  final bool textCapital;
  final bool read;

  const InputBox({
    super.key,
    this.label = "label",
    required this.textController,
    this.obscText = false,
    this.textCapital = false,
    this.read = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextFormField(
        obscureText: obscText,
        controller: textController,
        readOnly: read,
        textCapitalization: textCapital
            ? TextCapitalization.characters
            : TextCapitalization.none,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey.shade700, fontSize: 20),
          floatingLabelStyle: MaterialStateTextStyle.resolveWith(
            (Set<MaterialState> states) {
              final Color color = states.contains(MaterialState.error)
                  ? Theme.of(context).colorScheme.error
                  : Colors.grey.shade700;
              return TextStyle(color: color, letterSpacing: 1.3, fontSize: 25);
            },
          ),
        ),
        // validator: (String? value) {
        //   if (value == null || value == '') {
        //     return 'Enter name';
        //   }
        //   return null;
        // },
        autovalidateMode: AutovalidateMode.always,
      ),
    );
  }
}
