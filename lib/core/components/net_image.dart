import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils.dart';

class NetImage extends StatelessWidget {
  final int? id;
  final String alt;

  final double minSize;
  const NetImage({this.id, required this.alt, this.minSize = 0});
  @override
  CircleAvatar build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      backgroundImage: const AssetImage('assets/loading.gif'),
      child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: minSize, minWidth: minSize),
          child: Image.network("${Utils.baseUrl}/api/images/$id/$alt"),),
    );
  }
}
