import 'package:auto_route/auto_route.dart';
import 'package:flash/features/providers/set_list_provider.dart';
import 'package:flash/router/router.dart';
import 'package:flash/talker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: переделать использование репозитория
// https://codewithandrea.com/articles/loading-error-states-state-notifier-async-value/

@RoutePage()
class SetListScreen extends ConsumerWidget {
  const SetListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final talker = ref.watch(talkerProvider);
    final setsNotifier = ref.watch(setListNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flashcards'),
      ),
      body: setsNotifier.when(
        loading: () {
          talker.info('[UI] Состояние: загрузка. Идет загрузка наборов');
          return const Center(child: CircularProgressIndicator());
        },
        error: (e, st) {
          talker.error('Ошибка при загрузке наборов: $e');
          return const Center(child: Text('Ошибка при загрузке наборов'));
        },
        data: (sets) {
          talker.info('[UI] Состояние: DATA');
          if (sets.isEmpty) {
            talker.info('[UI] Нет наборов, пустое состояние');
            return const Center(child: Text('Нет доступных наборов'));
          }
          talker.info('[UI] Отображается список из ${sets.length} наборов');
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            itemCount: sets.length,
            itemBuilder: (context, index) {
              final set = sets[index];
              return GestureDetector(
                child: SetWidget(name: set.name),
                onTap: () {
                  context.router.push(const LearningRoute());
                  talker.info('Переход к экрану обучения');
                },
                onLongPress: () {
                  talker.info('[UI] Долгое нажатие на набор: ${set.name}');
                  showOptionsMenu(context, ref, set.id);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await context.router.push(const CardListRoute());
          if (result == true) {
            final notifier = ref.read(setListNotifierProvider.notifier);
            await notifier.refresh();
          }
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

void showOptionsMenu(
  BuildContext context,
  WidgetRef ref,
  int setId,
  //String setName,
) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 40,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.blue),
              title: const Text('Редактировать'),
              onTap: () {}, //=> _onEditSet(context, ref, setId, setName),
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Удалить'),
              onTap: () => onDelete(context, ref, setId),
            ),
            const SizedBox(height: 8),
          ],
        ),
      );
    },
  );
}

void onDelete(BuildContext context, WidgetRef ref, int setId) async {
  final talker = ref.watch(talkerProvider);
  final notifier = ref.read(setListNotifierProvider.notifier);

  final result = await notifier.deleteSet(setId);
  if (result && context.mounted) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Набор удален')));
    talker.info('[UI] Набор $setId удален');
    Navigator.of(context).pop(true);
  }
}
