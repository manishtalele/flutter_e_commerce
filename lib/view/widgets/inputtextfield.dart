import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/theme/themedata.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    required this.controller,
    required this.mylabel,
    this.obstext = false,
  });

  final TextEditingController controller;
  final String mylabel;
  final bool obstext;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      child: TextFormField(
        obscureText: obstext,
        controller: controller,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          filled: true,
          fillColor: white,
          labelText: mylabel,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
