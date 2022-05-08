import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:todo/app.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: false,
      builder: (_) => MyApp(),
    ),
  );
}
