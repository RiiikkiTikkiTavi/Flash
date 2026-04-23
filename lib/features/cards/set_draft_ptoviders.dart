import 'package:flash/features/cards/view/card_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Провайдер для черновика набора
final setDraftProvider = StateNotifierProvider<SetDraftNotifier, SetDraft?>((
  ref,
) {
  return SetDraftNotifier();
});

// Провайдер для текущего набора
final nameControllerProvider = Provider((ref) => TextEditingController());
final descrControllerProvider = Provider((ref) => TextEditingController());

class SetDraftNotifier extends StateNotifier<SetDraft?> {
  SetDraftNotifier() : super(null);

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

// Провайдер для списка карточек
final cardsListProvider =
    StateNotifierProvider<CardsListNotifier, List<CardDraft>>((ref) {
      return CardsListNotifier();
    });

// Провайдер для текущей редактируемой карточки
final termControllerProvider = Provider((ref) => TextEditingController());
final defControllerProvider = Provider((ref) => TextEditingController());

class CardsListNotifier extends StateNotifier<List<CardDraft>> {
  CardsListNotifier() : super(_getInitialCards());

  static List<CardDraft> _getInitialCards() {
    return [
      const CardDraft(term: '', definition: ''),
      const CardDraft(term: '', definition: ''),
    ];
  }

  void addCard() {
    state = [...state, const CardDraft(term: '', definition: '')];
    //state = [...state, card];
  }

  void updateCard(int index, CardDraft card) {
    final newList = List<CardDraft>.from(state);
    newList[index] = card;
    state = newList;
  }

  void removeCard(int index) {
    final newList = List<CardDraft>.from(state);
    newList.removeAt(index);
    state = newList;
  }

  void clearCards() {
    state = [];
  }
}
