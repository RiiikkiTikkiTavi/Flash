// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flash/data/models/progress_model.dart';
import 'package:flash/data/models/set_model.dart';
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
}
