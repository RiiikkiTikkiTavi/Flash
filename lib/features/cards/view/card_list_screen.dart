// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flash/domain/entities/card_entity.dart';
import 'package:flash/domain/entities/set_entity.dart';
import 'package:flash/features/cards/set_draft_ptoviders.dart';
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
    final talker = ref.watch(talkerProvider);
    final setRepository = ref.read(setRepositoryProvider);
    final cardRepository = ref.read(cardRepositoryProvider);

    // Получаем контроллеры из провайдеров
    final nameController = ref.watch(nameControllerProvider);
    final descrController = ref.watch(descrControllerProvider);

    final set = ref.watch(setDraftProvider);
    final cards = ref.watch(cardsListProvider);

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
                onPressed: set != null && set.isValid
                    ? () async {
                        try {
                          final newSet = SetEntity(
                            id: 0,
                            name: set.name,
                            description: set.description,
                            createdAt: set.createdAt,
                            cards: set.cards
                                .map((card) => card.toEntity())
                                .toList(),
                          );
                          final setId = setRepository.createSet(newSet);
                          for (var card in set.cards) {
                            cardRepository.createCard(
                              CardEntity(
                                id: 0,
                                term: card.term,
                                definition: card.definition,
                              ),
                            );
                          }
                        } catch (e) {
                          talker.error(e.toString());
                        }
                        //if (ref.mounted) {
                        context.router.pop();
                        //}
                      }
                    : null,
              ),
            ],
          ),
          HeaderSetWidget(
            nameController: nameController,
            descrController: descrController,
          ),
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

class HeaderSetWidget extends ConsumerWidget {
  const HeaderSetWidget({
    super.key,
    required this.nameController,
    required this.descrController,
  });

  final TextEditingController nameController;
  final TextEditingController descrController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final talker = ref.watch(talkerProvider);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              onEditingComplete: () {
                talker.info('Покинули поле name');
                if (nameController.text.trim().isNotEmpty) {
                  ref
                      .read(setDraftProvider.notifier)
                      .updateName(nameController.text);
                }
                FocusScope.of(context).nextFocus();
              },
              onChanged: (value) {},
              decoration: const InputDecoration(
                hintText: 'Enter name of the set',
                border: UnderlineInputBorder(),
              ),
            ),
            TextField(
              controller: descrController,
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
                if (descrController.text.trim().isNotEmpty) {
                  ref
                      .read(setDraftProvider.notifier)
                      .updateDescription(descrController.text);
                }
                talker.info('Покинули поле description');
              },
              onChanged: (value) {},
              decoration: const InputDecoration(
                hintText: 'Enter description of the set',
                border: UnderlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardWidget extends ConsumerStatefulWidget {
  const CardWidget({
    super.key,
    required this.index,
    this.initialTerm = '',
    this.initialDefinition = '',
  });

  final int index;
  final String initialTerm;
  final String initialDefinition;

  @override
  ConsumerState<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends ConsumerState<CardWidget> {
  late final TextEditingController termController;
  late final TextEditingController defController;

  @override
  void initState() {
    super.initState();
    // Создаем уникальные контроллеры для каждой карточки
    termController = TextEditingController(text: widget.initialTerm);
    defController = TextEditingController(text: widget.initialDefinition);
  }

  @override
  void dispose() {
    termController.dispose();
    defController.dispose();
    super.dispose();
  }

  void _saveCard() {
    final term = termController.text.trim();
    final definition = defController.text.trim();

    if (term.isNotEmpty && definition.isNotEmpty) {
      final card = CardDraft(term: term, definition: definition);
      ref.read(cardsListProvider.notifier).updateCard(widget.index, card);

      final updatedCards = ref.read(cardsListProvider);
      ref.read(setDraftProvider.notifier).updateCards(updatedCards);
    }
  }

  @override
  Widget build(BuildContext context) {
    final talker = ref.watch(talkerProvider);
    return Container(
      height: 120,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.cyanAccent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: termController,
            onEditingComplete: () {
              talker.info('Покинули поле term');
              // перевод фокуса на следующее поле
              FocusScope.of(context).nextFocus();
            },
            onChanged: (value) {},
            decoration: const InputDecoration(
              hintText: 'Enter term',
              border: UnderlineInputBorder(),
            ),
          ),
          TextField(
            controller: defController,
            onEditingComplete: () {
              // когда фокус ушел
              FocusScope.of(context).unfocus();
              talker.info('Покинули поле definition');
              _saveCard();
            },
            onChanged: (value) {},
            decoration: const InputDecoration(
              hintText: 'Enter definition',
              border: UnderlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

class SetDraft {
  final String name;
  final String? description;
  final DateTime createdAt;
  final List<CardDraft> cards;
  SetDraft({
    required this.name,
    this.description,
    required this.createdAt,
    required this.cards,
  });

  bool get isNameValid => name.trim().isNotEmpty;
  bool get hasMinCards => cards.length >= 2;

  bool get isValid => isNameValid && hasMinCards;

  SetDraft copyWithName(String newName) {
    return SetDraft(
      name: newName,
      description: description,
      createdAt: createdAt,
      cards: cards,
    );
  }

  SetDraft copyWithDescription(String? newDescription) {
    return SetDraft(
      name: name,
      description: newDescription,
      createdAt: createdAt,
      cards: cards,
    );
  }

  SetDraft updateCards(List<CardDraft> newCards) {
    return SetDraft(
      name: name,
      description: description,
      createdAt: createdAt,
      cards: newCards,
    );
  }
}

class CardDraft {
  final String term;
  final String definition;
  const CardDraft({required this.term, required this.definition});

  bool get isTermValid => term.trim().isNotEmpty;
  bool get isDefinitionValid => definition.trim().isNotEmpty;
  bool get isValid => isTermValid && isDefinitionValid;

  CardEntity toEntity() {
    return CardEntity(id: 0, term: term, definition: definition);
  }
}
