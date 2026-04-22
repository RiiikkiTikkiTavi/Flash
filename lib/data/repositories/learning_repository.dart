import 'package:flash/domain/entities/card_entity.dart';
import 'package:flash/domain/entities/card_progress_entity.dart';
import 'package:flash/domain/repositories/abstr_learning_repository.dart';

class LearningRepository extends AbstractLearningRepository {
  @override
  Future<CardEntity?> getNextCard(String cardId) {
    // TODO: implement getNextCard
    throw UnimplementedError();
  }

  @override
  Future<CardProgressEntity> updateProgress(String cardId, bool isCorrect) {
    // TODO: implement updateProgress
    throw UnimplementedError();
  }
}
