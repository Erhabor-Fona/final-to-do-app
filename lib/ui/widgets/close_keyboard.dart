import 'package:flutter/material.dart';
import 'package:todo/utils/keyboard.dart';

class CloseKeyboard extends StatelessWidget {
  final Widget child;
  const CloseKeyboard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        KeyboardUtil.hideKeyboard(context);
      },
      child: this.child,
    );
  }
}
