import 'package:flutter/material.dart';

mixin ScrollableMixin<T extends StatefulWidget> on State<T> {
  final GlobalKey constrainedBoxKey = GlobalKey();
  bool scrollable = false;
  late double maxHeight;

  void checkHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox =
          constrainedBoxKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final size = renderBox.size;
        setState(() {
          scrollable = size.height >= maxHeight;
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    checkHeight();
  }
}
