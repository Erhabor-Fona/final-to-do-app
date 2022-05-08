

import 'package:flutter/material.dart';

class BlackSafeArea extends StatelessWidget {
  Widget child;
   BlackSafeArea({ Key? key , required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black,
        child: child,
      ),
    );
  }
}