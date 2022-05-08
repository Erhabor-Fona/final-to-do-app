import 'package:flutter/material.dart';

Widget RetryWidget(
    {Function? retryPress, String? message, String? functionName}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message ?? "Seems an error occured",
          style: TextStyle(
              // color: Color.fromRGBO(119, 119, 119, 1),
              fontFamily: 'circular',
              fontSize: 18,
              fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
        TextButton(
          child: Text(
            functionName ?? "Try Again",
          ),
          onPressed: () async {
            retryPress!() ?? () {}();
          },
        ),
      ],
    ),
  );
}
