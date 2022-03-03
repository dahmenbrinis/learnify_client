import 'package:flutter/material.dart';

class CustomAvatarImage extends StatelessWidget {
  Widget? image;
  final EdgeInsetsGeometry padding;

  CustomAvatarImage(this.image, {this.padding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: CircleAvatar(
        backgroundColor: const Color(0x800090FF),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: image,
            ),
          ),
        ),
      ),
    );
  }
}
