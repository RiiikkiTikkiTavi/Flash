import 'package:auto_route/auto_route.dart';
import 'package:flash/features/sets/providers/set_repository_provider.dart';
import 'package:flash/router/router.dart';
import 'package:flash/talker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class SetListScreen extends ConsumerWidget {
  const SetListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final talker = ref.watch(talkerProvider);
    final repository = ref.read(setRepositoryProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flashcards'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        itemCount: 40,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: const SetWidget(name: 'Set of cards'),
            onTap: () {
              context.router.push(const LearningRoute());
              talker.info('Переход к экрану обучения');
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(const CardListRoute());
          talker.info('Переход к экрану карточек');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SetWidget extends StatelessWidget {
  const SetWidget({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.blueGrey,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(name, style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}
