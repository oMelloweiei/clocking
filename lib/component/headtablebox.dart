import 'package:flutter/material.dart';

class TopBox extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Color? borderColor;
  final List<double>? padding;

  const TopBox({
    this.color,
    this.borderColor,
    this.padding,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<double> defaultPadding = padding ?? [12.0, 28.0];
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: defaultPadding[0],
        horizontal: defaultPadding[1],
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        border: const Border(bottom: BorderSide(color: Colors.grey)),
        color: color ?? Colors.grey[300],
      ),
      child: child,
    );
  }
}
