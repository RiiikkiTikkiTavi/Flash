// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flash/domain/entities/card_entity.dart';

class SetEntity extends Equatable {
  final String id;
  final String name;
  final String? description;
  final DateTime createdAt;
  final List<CardEntity> cards;
  const SetEntity({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
    required this.cards,
  });

  @override
  List<Object?> get props => [id, name, description, createdAt, cards];
}
