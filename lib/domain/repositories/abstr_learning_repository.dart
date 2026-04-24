import 'package:flash/domain/entities/card_entity.dart';
import 'package:flash/domain/entities/card_progress_entity.dart';

abstract class AbstractLearningRepository {
  // Получение следующей карточки для повторения
  Future<CardEntity?> getNextCard(int cardId);

  // Обновление прогресса после ответа
  Future<CardProgressEntity> updateProgress(int cardId, bool isCorrect);
}
