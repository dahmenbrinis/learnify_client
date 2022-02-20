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
    double this.padding = 5,
    this.inputController,
    this.height = 0,
    this.lines = 1,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1),
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
    // return Padding(
    //   padding: EdgeInsets.symmetric(vertical: padding),
    //   child: TextFormField(
    //     maxLines: lines,
    //     style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
    //     controller: inputController,
    //     decoration: InputDecoration(
    //       filled: true,
    //       // border: const UnderlineInputBorder(),
    //       labelText: inputText,
    //       labelStyle: const TextStyle(fontSize: 18, color: Colors.black38),
    //       fillColor: Colors.white,
    //       contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    //     ),
    //   ),
    // );
  }
}
