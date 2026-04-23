import 'package:flash/domain/entities/card_entity.dart';
import 'package:flash/domain/entities/card_progress_entity.dart';

abstract class AbstractCardRepository {
  // Базовые CRUD операции с карточками
  void createCard(CardEntity card);
  Future<void> editCard(CardEntity card);
  Future<void> deleteCard(String id);
  Future<CardEntity> gerCard(String id);

  // Операции с прогрессом
  Future<CardProgressEntity> getProgress(String cardId);
}
