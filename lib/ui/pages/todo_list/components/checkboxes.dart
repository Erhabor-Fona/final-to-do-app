import 'package:flutter/material.dart';

class CheckBoxEmpty extends StatelessWidget {
  const CheckBoxEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius:const BorderRadius.all(
          Radius.circular(6),
        ),
        color: const Color.fromRGBO(242, 242, 242, 1),
        border: Border.all(
          width: 1,
          color: const Color.fromRGBO(196, 196, 196, 1),
        ),
      ),
    );
  }
}

class CheckBoxGood extends StatelessWidget {
  const CheckBoxGood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
        color: Color.fromRGBO(0, 145, 32, 1),
      ),
      child: Center(
        child: Icon(
          Icons.check_rounded,
          color: Theme.of(context).scaffoldBackgroundColor,
          size: 24,
        ),
      ),
    );
  }
}
