import 'package:flash/domain/entities/card_entity.dart';
import 'package:flash/domain/entities/set_entity.dart';

abstract class AbstractSetRepository {
  // Базовые CRUD операции
  void createSet(SetEntity set);
  Future<void> editSet(SetEntity set);
  Future<void> deleteSet(String id);
  Future<SetEntity> getSet(String id);

  // Операции с карточками внутри набора
  Future<void> addCardToSet(String setId, CardEntity card);
  Future<void> deleteCardFromSet(String setId, String cardId);
}
