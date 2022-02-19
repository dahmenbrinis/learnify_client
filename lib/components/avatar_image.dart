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
          backgroundColor: Color(0xff2191FB),
          child: Padding(
            padding: EdgeInsets.all(2),
            child: CircleAvatar(
              backgroundImage: image,
            ),
          )),
    );
  }
}
