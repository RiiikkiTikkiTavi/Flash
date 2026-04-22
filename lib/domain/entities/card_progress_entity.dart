// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CardProgressEntity extends Equatable {
  final String cardId;
  final int stepIndex;
  final DateTime nextReviewAt;
  final DateTime lastReviewAt;
  const CardProgressEntity({
    required this.cardId,
    required this.stepIndex,
    required this.nextReviewAt,
    required this.lastReviewAt,
  });

  @override
  List<Object?> get props => [cardId, stepIndex, nextReviewAt, lastReviewAt];
}
