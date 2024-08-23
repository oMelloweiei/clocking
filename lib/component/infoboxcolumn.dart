import 'package:flutter/material.dart';

class Infoboxcolumn extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Color? borderColor;
  final List<double>? padding;
  final int index;
  final int totalItems;

  const Infoboxcolumn({
    required this.index,
    this.color,
    this.borderColor,
    this.padding,
    required this.child,
    required this.totalItems,
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
        borderRadius: BorderRadius.vertical(
          top: index == 0 ? Radius.circular(10) : Radius.zero,
          bottom: index == totalItems - 1 ? Radius.circular(10) : Radius.zero,
        ),
        border: Border(
            bottom: index == totalItems - 1
                ? BorderSide.none
                : BorderSide(color: Colors.grey),
            top: index == 0
                ? BorderSide.none
                : BorderSide(color: Colors.grey[200]!)),
        color: color ?? Colors.white,
      ),
      child: child,
    );
  }
}
