// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flash/data/models/card_model.dart';
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
}
