import 'package:flash/data/repositories/set_repository.dart';
import 'package:flash/object_box_provider.dart';
import 'package:flash/talker_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final setRepositoryProvider = Provider<SetRepository>((ref) {
  final objectBox = ref.watch(objectBoxProvider);
  final talker = ref.watch(talkerProvider);

  return SetRepository(objectBox: objectBox, talker: talker);
});
