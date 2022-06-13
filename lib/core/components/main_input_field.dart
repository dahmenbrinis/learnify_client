import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconsax/iconsax.dart';

class MainInputField extends StatelessWidget {
  Text inputText;
  final double padding;
  final TextEditingController? inputController;

  final double height;

  final int lines;

  final Color color;

  final Icon icon;

  final Widget? input;

  bool isHidden;

  MainInputField({
    Key? key,
    required this.inputText,
    this.padding = 5,
    this.inputController,
    this.height = 0,
    this.lines = 1,
    this.color = Colors.white,
    required this.icon,
    this.input,
    this.isHidden = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Container(
        // color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 20)],
        ),
        child: StaggeredGrid.count(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 20,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 20,
              mainAxisCellCount: 2,
              child: inputText,
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 3,
              mainAxisCellCount: 2,
              child: icon,
            ),
            StaggeredGridTile.count(
              mainAxisCellCount: 2,
              crossAxisCellCount: 17,
              child: input ??
                  TextFormField(
                    decoration: const InputDecoration(
                        filled: true, fillColor: Colors.transparent),
                    style: Theme.of(context).textTheme.titleMedium,
                    controller: inputController,
                    obscureText: isHidden,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
