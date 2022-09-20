import 'package:flutter/material.dart';

class Textstyled extends StatelessWidget {
  final String content;
  final double size;
  // ignore: prefer_typing_uninitialized_variables
  final color;
  const Textstyled(
      {super.key, required this.content, required this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(content,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontSize: size, color: color));
  }
}
