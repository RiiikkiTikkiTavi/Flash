// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flash/data/models/progress_model.dart';
import 'package:flash/data/models/set_model.dart';
import 'package:flash/domain/entities/card_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class CardModel {
  @Id()
  int id = 0;

  final String term;
  final String definition;

  // Связь с набором: у одной карточки один набор
  final cardSet = ToOne<SetModel>();

  // Связь с прогрессом: у одной карточки один прогресс
  final progress = ToOne<ProgressModel>();

  CardModel({required this.term, required this.definition});

  // Преобразование Entity - Model
  // конструктор, который вернет существующий объект
  factory CardModel.fromEntity(CardEntity entity) {
    return CardModel(term: entity.term, definition: entity.definition);
  }

  // Преобразование Model → Entity
  CardEntity toEntity() {
    return CardEntity(id: id, term: term, definition: definition);
  }
}
