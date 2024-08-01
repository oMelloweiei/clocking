import 'package:flutter/material.dart';

class Infoboxcolumn extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Color? borderColor;
  final List<double>? padding;
  final int index;

  const Infoboxcolumn({
    required this.index,
    this.color,
    this.borderColor,
    this.padding,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<double> defaultPadding = padding ?? [12.0, 12.0];
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        vertical: defaultPadding[0],
        horizontal: defaultPadding[1],
      ),
      decoration: BoxDecoration(
        // borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
        border: Border(
            bottom: BorderSide(color: Colors.grey),
            top: index == 0
                ? BorderSide.none
                : BorderSide(color: Colors.grey[200]!)),
        color: color ?? Colors.white,
      ),
      child: child,
    );
  }
}
