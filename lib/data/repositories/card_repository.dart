import 'package:flash/domain/entities/card_entity.dart';
import 'package:flash/domain/entities/card_progress_entity.dart';
import 'package:flash/domain/repositories/abstr_card_repository.dart';

class CardRepository extends AbstractCardRepository {
  @override
  Future<void> createCard(CardEntity card) {
    // TODO: implement createCard
    throw UnimplementedError();
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
