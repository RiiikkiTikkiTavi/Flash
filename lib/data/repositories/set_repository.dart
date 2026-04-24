import 'package:flash/data/models/set_model.dart';
import 'package:flash/domain/entities/card_entity.dart';
import 'package:flash/domain/entities/set_entity.dart';
import 'package:flash/domain/repositories/abstr_set_repository.dart';
import 'package:flash/object_box.dart';
import 'package:talker_flutter/talker_flutter.dart';

class SetRepository implements AbstractSetRepository {
  final ObjectBox _objectBox;
  final Talker _talker;

  SetRepository({required ObjectBox objectBox, required Talker talker})
    : _objectBox = objectBox,
      _talker = talker;

  @override
  Future<void> addCardToSet(int setId, CardEntity card) {
    // TODO: implement addCardToSet
    throw UnimplementedError();
  }

  @override
  Future<int> createSet(SetEntity set) async {
    try {
      // преобразование entity в model
      final setModel = SetModel.fromEntity(set);

      // сохранение в базу данных
      final id = _objectBox.setBox.put(setModel);

      _talker.info('Набор "${setModel.name}" сохранён с ID: $id');
      return id;
    } catch (e, stackTrace) {
      _talker.handle(e, stackTrace, 'Ошибка при создании набора ${set.name}');
      return -1;
    }
  }

  @override
  Future<void> deleteCardFromSet(int setId, int cardId) {
    // TODO: implement deleteCardFromSet
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSet(int id) {
    // TODO: implement deleteSet
    throw UnimplementedError();
  }

  @override
  Future<void> editSet(SetEntity cardSet) {
    // TODO: implement editSet
    throw UnimplementedError();
  }

  @override
  Future<SetEntity> getSet(int id) {
    // TODO: implement getSet
    throw UnimplementedError();
  }

  @override
  Future<List<SetEntity>> getAllSets() async {
    try {
      final setModels = _objectBox.setBox.getAll();
      _talker.info('Получено ${setModels.length} наборов из базы данных');
      return setModels.map((model) => model.toEntity()).toList();
    } catch (e, stackTrace) {
      _talker.handle(e, stackTrace, 'При получении наборов произошла ошибка');
      return [];
    }
  }
}
