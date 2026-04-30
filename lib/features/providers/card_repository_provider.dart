import 'package:flash/data/repositories/card_repository.dart';
import 'package:flash/object_box_provider.dart';
import 'package:flash/talker_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cardRepositoryProvider = Provider<CardRepository>((ref) {
  final objectBox = ref.watch(objectBoxProvider);
  final talker = ref.watch(talkerProvider);

  return CardRepository(objectBox: objectBox, talker: talker);
});
