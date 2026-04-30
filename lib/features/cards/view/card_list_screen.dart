// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flash/features/cards/widgets/cards_widget.dart';
import 'package:flash/features/cards/widgets/header_set_widget.dart';
import 'package:flash/features/providers/card_list_provider.dart';
import 'package:flash/features/providers/set_creation_provider.dart';
import 'package:flash/features/providers/set_draft_ptovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class CardListScreen extends ConsumerWidget {
  const CardListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final talker = ref.read(talkerProvider);
    final cards = ref.watch(cardsListProvider);
    final set = ref.watch(setDraftProvider);

    Future<void> saveSet() async {
      final notifier = ref.read(setCreationNotifierProvider.notifier);
      bool result = await notifier.saveSet(set!);
      if (result && context.mounted) {
        ref.read(setDraftProvider.notifier).reset();
        context.router.pop();
      }
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: true,
            floating: true,
            title: const Text('Набор карточек'),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const CloseDialogWidget(),
                );
              },
              icon: const Icon(Icons.arrow_back),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.done),
                onPressed: () {
                  if (set != null && set.isValid) {
                    saveSet();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Заполните название и добавьте минимум 2 карточки',
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          const HeaderSetWidget(),
          SliverList.builder(
            itemCount: cards.length,
            itemBuilder: (context, index) {
              return CardWidget(
                index: index,
                initialTerm: '',
                initialDefinition: '',
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(cardsListProvider.notifier).addCard();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CloseDialogWidget extends StatelessWidget {
  const CloseDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Отмена создания'),
      content: const Text(
        'Вы уверены, что хотите выйти? Все изменения будут потеряны.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Нет'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            context.router.pop();
          },
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: const Text('Да, выйти'),
        ),
      ],
    );
  }
}
