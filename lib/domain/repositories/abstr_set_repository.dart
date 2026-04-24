import 'package:flash/domain/entities/card_entity.dart';
import 'package:flash/domain/entities/set_entity.dart';

abstract class AbstractSetRepository {
  // Базовые CRUD операции
  Future<void> createSet(SetEntity set);
  Future<void> editSet(SetEntity set);
  Future<void> deleteSet(int id);
  Future<SetEntity> getSet(int id);

  Future<List<SetEntity>> getAllSets();

  // Операции с карточками внутри набора
  Future<void> addCardToSet(int setId, CardEntity card);
  Future<void> deleteCardFromSet(int setId, int cardId);
}
