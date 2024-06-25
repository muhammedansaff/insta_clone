import 'package:flutter/material.dart';
import 'package:insta_clone/utils/colors.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool ispass;
  final String hint;
  final TextInputType textInputType;

  const MyTextField(
      {super.key,
      required this.hint,
      this.ispass = false,
      required this.textEditingController,
      required this.textInputType});

  @override
  Widget build(BuildContext context) {
    final InputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));

    return Container(
      color: mobileSearchColor,
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder,
          focusedBorder: InputBorder,
          contentPadding: EdgeInsets.all(8),
        ),
        keyboardType: textInputType,
        obscureText: ispass,
      ),
    );
  }
}
