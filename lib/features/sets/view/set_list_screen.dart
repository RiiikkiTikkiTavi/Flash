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
    final setListRepository = ref.watch(setListProvider);
    //final set = setRepository.getAllSets();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flashcards'),
      ),
      body: setListRepository.when(
        error: (e, st) {
          talker.error('Ошибка при загрузке наборов: $e');
          return const Center(child: Text('Ошибка при загрузке наборов'));
        },
        data: (set) {
          if (set.isEmpty) {
            return const Center(child: Text('Нет доступных наборов'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            itemCount: set.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: SetWidget(name: set[index].name),
                onTap: () {
                  context.router.push(const LearningRoute());
                  talker.info('Переход к экрану обучения');
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(const CardListRoute());
          talker.info('Переход к экрану карточек');
          ref.invalidate(setListProvider);
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
