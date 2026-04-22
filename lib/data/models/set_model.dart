// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flash/data/models/card_model.dart';
import 'package:flash/domain/entities/set_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class SetModel {
  @Id()
  int id = 0;

  final String name;
  final String? description;
  final DateTime createdAt;

  @Backlink()
  final cards = ToMany<CardModel>();

  SetModel({required this.name, this.description, required this.createdAt});

  // Преобразование Entity - Model
  // конструктор, который вернет существующий объект
  factory SetModel.fromEntity(SetEntity entity) {
    return SetModel(
      name: entity.name,
      description: entity.description,
      createdAt: entity.createdAt,
    );
  }

  // Преобразование Model → Entity
  SetEntity toEntity() {
    return SetEntity(
      id: id,
      name: name,
      description: description,
      createdAt: createdAt,
      cards: cards.map((cardModel) => cardModel.toEntity()).toList(),
    );
  }
}
