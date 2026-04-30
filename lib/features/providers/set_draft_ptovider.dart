import 'package:flash/features/providers/card_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Черновик набора
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
  bool get areAllCardsValid => cards.every((card) => card.isValid);

  bool get isValid => isNameValid && hasMinCards && areAllCardsValid;

  factory SetDraft.empty() {
    return SetDraft(
      name: '',
      description: null,
      createdAt: DateTime.now(),
      cards: [],
    );
  }

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

// Провайдер для черновика набора
final setDraftProvider = StateNotifierProvider<SetDraftNotifier, SetDraft?>((
  ref,
) {
  return SetDraftNotifier();
});

class SetDraftNotifier extends StateNotifier<SetDraft?> {
  SetDraftNotifier() : super(null);

  void reset() {
    state = SetDraft.empty();
  }

  void updateName(String name) {
    if (name.trim().isNotEmpty) {
      final currentSet =
          state ?? SetDraft(name: name, createdAt: DateTime.now(), cards: []);
      state = currentSet.copyWithName(name);
    }
  }

  void updateDescription(String? description) {
    if (state != null && description != null && description.trim().isNotEmpty) {
      state = state!.copyWithDescription(description);
    }
  }

  void updateCards(List<CardDraft> cards) {
    if (state != null) {
      state = state!.updateCards(cards);
    }
  }
}
