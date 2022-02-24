import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackgroundWidget2 extends StatelessWidget {
  // static final RxBool _isCentered = true.obs;
  // bool get isCentered => _isCentered.value;
  // set isCentered(bool value) => _isCentered.value = value;
  final Widget child;
  final pos;
  const BackgroundWidget2({Key? key, required this.child, this.pos = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: -100,
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                  color: Colors.indigo,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(blurRadius: 40, color: Colors.indigo)],
                  gradient: LinearGradient(
                      colors: [Colors.indigoAccent, Colors.indigo],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
            ),
          ),
          Positioned(
            bottom: 100,
            right: -100,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(blurRadius: 40, color: Colors.blue)
                  ],
                  gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.blueAccent.shade200],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
            ),
          ),
          Positioned(
            top: 250,
            left: 50,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(blurRadius: 80, color: Colors.blue)
                ],
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.blueAccent.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              boxShadow: const [
                BoxShadow(blurRadius: 40.0, color: Colors.blue)
              ],
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(
                      MediaQuery.of(context).size.width - 150, 150.0)),
            ),
          ),
          child
        ],
      ),
    );
  }
}
