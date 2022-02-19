import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;
  const BackgroundWidget({required Widget this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: -100,
          top: -100,
          child: Container(
            width: 350,
            height: 350,
            decoration: const BoxDecoration(
                color: Colors.indigo,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(blurRadius: 10, color: Colors.indigo)],
                gradient: LinearGradient(
                    colors: [Colors.indigoAccent, Colors.indigo],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
        ),
        Positioned(
          right: -50,
          top: -50,
          child: Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              color: Colors.greenAccent,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.greenAccent)],
              // gradient: LinearGradient(colors: [Color(0x43F68B),Color(0x43F68B)] , begin: Alignment.bottomLeft , end: Alignment.bottomRight)
            ),
          ),
        ),
        Positioned(
            right: -100,
            bottom: -80,
            child: Transform.rotate(
              angle: 0.8,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(blurRadius: 10, color: Colors.indigo)
                  ],
                  // gradient: LinearGradient(colors: [Color(0x43F68B),Color(0x43F68B)] , begin: Alignment.bottomLeft , end: Alignment.bottomRight)
                ),
              ),
            )),
        Positioned(
            left: -100,
            bottom: -100,
            child: Transform.rotate(
              angle: 3.14 / 4,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(blurRadius: 10, color: Colors.greenAccent)
                  ],
                  // gradient: LinearGradient(colors: [Color(0x43F68B),Color(0x43F68B)] , begin: Alignment.bottomLeft , end: Alignment.bottomRight)
                ),
              ),
            )),
        Center(
          child: Opacity(
            opacity: 0.9,
            child: Transform.rotate(
              angle: 0.2,
              child: Container(
                width: 1000,
                height: 600,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(blurRadius: 10, color: Colors.blue)
                    ],
                    gradient: const LinearGradient(
                        colors: [Colors.lightBlue, Colors.blue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight)),
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
