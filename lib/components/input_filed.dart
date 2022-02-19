import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String inputText;
  final double padding;
  final TextEditingController? inputController;

  InputField(
      {Key? key,
      required this.inputText,
      double this.padding = 10,
      this.inputController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: TextFormField(
        controller: inputController,
        decoration: InputDecoration(
          filled: true,
          border: UnderlineInputBorder(),
          labelText: inputText,
          labelStyle: TextStyle(fontSize: 20, color: Colors.black26),
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        ),
      ),
    );
  }
}
