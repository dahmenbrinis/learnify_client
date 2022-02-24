import 'package:flutter/material.dart';

class SelectField extends StatefulWidget {
  final List<String> items;
  const SelectField({required this.items});

  @override
  _SelectFieldState createState() => _SelectFieldState();
}

class _SelectFieldState extends State<SelectField> {
  String dropdownValue = 'Student';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(3),
          color: Colors.white),
      // color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_drop_down),

        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>['Student', 'Teacher']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(fontSize: 20, color: Colors.black54),
            ),
          );
        }).toList(),
      ),
    );
  }
}
