import 'package:flutter/material.dart';

class AddHeight extends StatelessWidget {
  final double height;
  const AddHeight({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class AddWidth extends StatelessWidget {
  final double width;
  const AddWidth({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
