import 'package:flutter/material.dart';

class Topboxcolumn extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Color? borderColor;
  final List<double>? padding;

  const Topboxcolumn({
    this.color,
    this.borderColor,
    this.padding,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<double> defaultPadding = padding ?? [4.0, 12.0];
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: defaultPadding[0],
        horizontal: defaultPadding[1],
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[100]!),
        ),
        color: color ?? Colors.white,
      ),
      child: child,
    );
  }
}
