import 'package:flash/data/models/card_model.dart';
import 'package:flash/domain/entities/card_entity.dart';
import 'package:flash/domain/entities/card_progress_entity.dart';
import 'package:flash/domain/repositories/abstr_card_repository.dart';
import 'package:flash/object_box.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CardRepository implements AbstractCardRepository {
  final ObjectBox _objectBox;
  final Talker _talker;

  CardRepository({required ObjectBox objectBox, required Talker talker})
    : _objectBox = objectBox,
      _talker = talker;

  @override
  void createCard(CardEntity card) {
    try {
      // преобразование entity в model
      final cardModel = CardModel.fromEntity(card);

      // сохранение в базу данных
      final id = _objectBox.cardBox.put(cardModel);

      _talker.info('Карточка "${cardModel.term}" сохранёна с ID: $id');
    } catch (e, stackTrace) {
      _talker.handle(
        e,
        stackTrace,
        'Ошибка при создании карточки ${card.term}',
      );
    }
  }

  @override
  Future<void> deleteCard(String id) {
    // TODO: implement deleteCard
    throw UnimplementedError();
  }

  @override
  Future<void> editCard(CardEntity card) {
    // TODO: implement editCard
    throw UnimplementedError();
  }

  @override
  Future<CardEntity> gerCard(String id) {
    // TODO: implement gerCard
    throw UnimplementedError();
  }

  @override
  Future<CardProgressEntity> getProgress(String cardId) {
    // TODO: implement getProgress
    throw UnimplementedError();
  }
}
