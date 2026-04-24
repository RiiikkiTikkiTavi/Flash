import 'package:flash/features/cards/providers/card_list_provider.dart';
import 'package:flash/features/cards/providers/set_draft_ptovider.dart';
import 'package:flash/talker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

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
    // создание уникальных контроллеров для каждой новой карточки
    termController = TextEditingController(text: widget.initialTerm);
    defController = TextEditingController(text: widget.initialDefinition);
  }

  // освобождение ресурсов
  @override
  void dispose() {
    termController.dispose();
    defController.dispose();
    super.dispose();
  }

  // временное сохранение карточки
  void _saveCard(Talker talker, WidgetRef ref) {
    final term = termController.text.trim();
    final definition = defController.text.trim();

    if (term.isNotEmpty && definition.isNotEmpty) {
      final card = CardDraft(term: term, definition: definition);
      ref.read(cardsListProvider.notifier).updateCard(widget.index, card);

      final updatedCards = ref.read(cardsListProvider);
      ref.read(setDraftProvider.notifier).updateCards(updatedCards);

      talker.info(
        'Сохранение карточки: term="$term", definition="$definition"',
      );
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
              FocusScope.of(context).nextFocus();
            },
            onChanged: (value) {
              _saveCard(talker, ref);
            },
            decoration: const InputDecoration(
              hintText: 'Enter term',
              border: UnderlineInputBorder(),
            ),
          ),
          TextField(
            controller: defController,
            onChanged: (value) {
              _saveCard(talker, ref);
            },
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
