import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  Text inputText;
  final double padding;
  final TextEditingController? inputController;

  final double height;

  final int lines;

  final Color color;

  InputField({
    required this.inputText,
    this.padding = 5,
    this.inputController,
    this.height = 0,
    this.lines = 1,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: inputText,
          ),
          TextFormField(
            decoration: InputDecoration(filled: true, fillColor: color),
            maxLines: lines,
            controller: inputController,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          )
        ],
      ),
    );
  }
}
