// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flash/app/flash_app.dart';
import 'package:flash/object_box.dart';
import 'package:flash/object_box_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация базы данных
  final objectbox = await ObjectBox.init();

  runApp(
    ProviderScope(
      overrides: [objectBoxProvider.overrideWithValue(objectbox)],
      child: const FlashApp(),
    ),
  );
}
