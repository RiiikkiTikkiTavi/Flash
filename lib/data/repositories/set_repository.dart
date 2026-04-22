import 'package:flash/domain/entities/card_entity.dart';
import 'package:flash/domain/entities/set_entity.dart';
import 'package:flash/domain/repositories/abstr_set_repository.dart';

class SetRepository extends AbstractSetRepository {
  @override
  Future<void> addCardToSet(String setId, CardEntity card) {
    // TODO: implement addCardToSet
    throw UnimplementedError();
  }

  @override
  Future<void> createSet(CardEntity cardSet) {
    // TODO: implement createSet
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCardFromSet(String setId, String cardId) {
    // TODO: implement deleteCardFromSet
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSet(String id) {
    // TODO: implement deleteSet
    throw UnimplementedError();
  }

  @override
  Future<void> editSet(CardEntity cardSet) {
    // TODO: implement editSet
    throw UnimplementedError();
  }

  @override
  Future<SetEntity> getSet(String id) {
    // TODO: implement getSet
    throw UnimplementedError();
  }
}
