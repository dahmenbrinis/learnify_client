import 'package:flutter/material.dart';

class CustomAvatarImage extends StatelessWidget {
  final ImageProvider image;

  final EdgeInsetsGeometry padding;
  const CustomAvatarImage(
      {required this.image, this.padding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: CircleAvatar(
          backgroundColor: const Color(0xff95acba),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: CircleAvatar(
                backgroundImage: image,
              ),
            ),
          )),
    );
  }
}
