// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flash/router/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FlashApp());
}

class FlashApp extends StatefulWidget {
  const FlashApp({super.key});

  @override
  State<FlashApp> createState() => _FlashAppState();
}

class _FlashAppState extends State<FlashApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router.config());
  }
}
