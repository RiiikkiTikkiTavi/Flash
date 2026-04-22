// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CardEntity extends Equatable {
  final String id;
  final String term;
  final String definition;
  const CardEntity({
    required this.id,
    required this.term,
    required this.definition,
  });

  @override
  List<Object?> get props => [id, term, definition];
}
