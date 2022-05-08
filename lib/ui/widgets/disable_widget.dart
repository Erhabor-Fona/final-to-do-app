import 'package:flutter/cupertino.dart';

class DisableWidget extends StatelessWidget {
  double opacity;
  Widget? child;
  bool disable;
  DisableWidget({ Key? key , this.opacity=1.0, this.disable=false,this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disable?opacity:1,
      child: AbsorbPointer(absorbing: disable, child: child));
  }
}