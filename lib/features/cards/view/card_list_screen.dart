// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flash/domain/entities/card_entity.dart';
import 'package:flash/domain/entities/set_entity.dart';
import 'package:flash/features/cards/providers/card_list_provider.dart';
import 'package:flash/features/cards/providers/set_draft_ptovider.dart';
import 'package:flash/features/cards/widgets/cards_widget.dart';
import 'package:flash/features/cards/widgets/header_set_widget.dart';
import 'package:flash/features/sets/providers/card_repository_provider.dart';
import 'package:flash/features/sets/providers/set_repository_provider.dart';
import 'package:flash/talker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class CardListScreen extends ConsumerWidget {
  const CardListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final talker = ref.read(talkerProvider);
    final setRepository = ref.read(setRepositoryProvider);
    final cardRepository = ref.read(cardRepositoryProvider);

    final cards = ref.watch(cardsListProvider);
    final set = ref.watch(setDraftProvider);

    Future<void> saveSet() async {
      if (set == null || !set.isValid) {
        talker.warning(
          'Невозможно сохранить набор: не все поля заполнены или недостаточно карточек',
        );
        return;
      }
      try {
        final newSet = SetEntity(
          id: 0,
          name: set.name,
          description: set.description,
          createdAt: set.createdAt,
          cards: set.cards.map((card) => card.toEntity()).toList(),
        );
        final setId = await setRepository.createSet(newSet);
        for (var card in set.cards) {
          await cardRepository.createCard(
            CardEntity(id: 0, term: card.term, definition: card.definition),
          );
        }
        if (context.mounted) {
          context.router.pop();
        }
      } catch (e) {
        talker.error(e.toString());
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
        }
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
