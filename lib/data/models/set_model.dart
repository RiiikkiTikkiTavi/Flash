// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flash/data/models/card_model.dart';
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
}
