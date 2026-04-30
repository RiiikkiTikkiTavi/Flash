import 'dart:async';

import 'package:flash/domain/entities/card_entity.dart';
import 'package:flash/domain/entities/set_entity.dart';
import 'package:flash/features/providers/card_repository_provider.dart';
import 'package:flash/features/providers/set_draft_ptovider.dart';
import 'package:flash/features/providers/set_list_provider.dart';
import 'package:flash/talker_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final setCreationNotifierProvider = NotifierProvider<SetCreationNotifier, bool>(
  () => SetCreationNotifier(),
);

class SetCreationNotifier extends Notifier<bool> {
  @override
  bool build() {
    // начальное состояние
    return false;
  }

  Future<bool> saveSet(SetDraft set) async {
    final talker = ref.read(talkerProvider);
    try {
      if (!set.isValid) {
        talker.warning(
          'Невозможно сохранить набор: не все поля заполнены или недостаточно карточек',
        );
        throw Exception(
          'Невозможно сохранить набор: не все поля заполнены или недостаточно карточек',
        );
      }

      // Получаем репозитории
      final setRepository = ref.read(setRepositoryProvider);
      final cardRepository = ref.read(cardRepositoryProvider);

      final newSet = SetEntity(
        id: 0,
        name: set.name,
        description: set.description,
        createdAt: set.createdAt,
        cards: set.cards.map((card) => card.toEntity()).toList(),
      );
      final setId = await setRepository.createSet(newSet);
      if (setId == -1) throw Exception('Ошибка создания набора');
      for (var card in set.cards) {
        await cardRepository.createCard(
          CardEntity(id: 0, term: card.term, definition: card.definition),
        );

        talker.info('набор ${set.name.toString} создан с ID: $setId');
      }
      // состоние - данные
      state = true;
      return true;
    } catch (e, stackTrace) {
      talker.handle(e, stackTrace, 'Ошибка при создании набора ${set.name}');
      // состояние - ошибка
      state = false;
      return false;
    }
  }

  void reset() {
    state = false; // Сбрасываем перед новым использованием
  }
}
