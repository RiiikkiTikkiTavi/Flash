import 'package:flash/router/router.dart';
import 'package:flash/talker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlashApp extends ConsumerStatefulWidget {
  const FlashApp({super.key});

  @override
  ConsumerState<FlashApp> createState() => _FlashAppState();
}

class _FlashAppState extends ConsumerState<FlashApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    final talker = ref.watch(talkerProvider);
    talker.info('Главный экран загружен');
    return MaterialApp.router(routerConfig: _router.config());
  }
}
