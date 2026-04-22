import 'package:flash/object_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final objectBoxProvider = Provider<ObjectBox>((ref) {
  throw Exception('ObjectBox должен быть переопределен в main.dart');
});
