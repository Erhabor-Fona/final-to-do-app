import 'package:flutter/material.dart';

Widget buildDefaultSpinner() {
  return Center(
    child: CircularProgressIndicator(
      // backgroundColor: Colors.transparent,
      color: Colors.white,
    ),
  );
}

Widget buildToggleSpinner() {
  return Center(
    child: CircularProgressIndicator(
      strokeWidth: 1,
      color: Colors.white,
    ),
  );
}
