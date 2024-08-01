import 'package:flutter/material.dart';

class ScreenConfig extends InheritedWidget {
  final bool isMobile;
  final bool isPortrait;

  const ScreenConfig({
    required this.isMobile,
    required this.isPortrait,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  static ScreenConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ScreenConfig>()!;
  }

  @override
  bool updateShouldNotify(covariant ScreenConfig oldWidget) {
    return isMobile != oldWidget.isMobile || isPortrait != oldWidget.isPortrait;
  }
}
