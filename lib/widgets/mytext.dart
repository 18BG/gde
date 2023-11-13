import 'dart:ui';

import 'package:flutter/material.dart';

class CText extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final FontStyle? style;
  final FontWeight? weight;

  const CText(String this.text,
      {super.key, this.size, this.color, this.style, this.weight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: TextStyle(
          fontStyle: style,
          fontSize: size ?? 16.5,
          color: color ?? Colors.black,
          fontWeight: weight ?? FontWeight.normal),
    );
  }
}
