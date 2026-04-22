// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flash/data/models/card_model.dart';
import 'package:flash/domain/entities/card_progress_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ProgressModel {
  @Id()
  int id = 0;

  // Связь с карточкой: один прогресс принадлежит одной карточке
  final card = ToOne<CardModel>();

  final int stepIndex;
  final DateTime nextReviewAt;
  final DateTime lastReviewAt;

  ProgressModel({
    required this.stepIndex,
    required this.nextReviewAt,
    required this.lastReviewAt,
  });

  // Преобразование Entity - Model
  // конструктор, который вернет существующий объект
  factory ProgressModel.fromEntity(ProgressModel entity) {
    return ProgressModel(
      stepIndex: entity.stepIndex,
      nextReviewAt: entity.nextReviewAt,
      lastReviewAt: entity.lastReviewAt,
    );
  }

  // Преобразование Model → Entity
  CardProgressEntity toEntity() {
    return CardProgressEntity(
      id: id,
      cardId: card.target!.id,
      stepIndex: stepIndex,
      nextReviewAt: nextReviewAt,
      lastReviewAt: lastReviewAt,
    );
  }
}
