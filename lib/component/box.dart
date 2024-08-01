import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Color? borderColor;
  final List<double>? padding;

  const InfoBox(
      {this.color,
      this.borderColor,
      this.padding,
      required this.child,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<double> defaultPadding = padding ?? [15.0, 15.0];
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: defaultPadding[0], horizontal: defaultPadding[1]),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color ?? Colors.white,
        border: Border.all(color: borderColor ?? Colors.grey),
      ),
      child: child,
    );
  }
}
