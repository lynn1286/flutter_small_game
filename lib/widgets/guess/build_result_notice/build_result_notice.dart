import 'package:flutter/material.dart';

class BuildResultNotice extends StatelessWidget {
  final Color color;
  final String message;
  final AnimationController controller;

  const BuildResultNotice({
    Key? key,
    required this.message,
    required this.color,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            alignment: Alignment.center,
            color: color,
            child: AnimatedBuilder(
              animation: controller,
              builder: (_, child) => Text(
                message,
                style: TextStyle(
                    fontSize: 54 * (controller.value),
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )));
  }
}
