import 'package:flash/domain/entities/card_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

// Провайдер для списка карточек
final cardsListProvider =
    StateNotifierProvider<CardsListNotifier, List<CardDraft>>((ref) {
      return CardsListNotifier();
    });

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
