import 'package:flash/data/repositories/set_repository.dart';
import 'package:flash/domain/entities/set_entity.dart';
import 'package:flash/object_box_provider.dart';
import 'package:flash/talker_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final setRepositoryProvider = Provider<SetRepository>((ref) {
  final objectBox = ref.watch(objectBoxProvider);
  final talker = ref.watch(talkerProvider);

  return SetRepository(objectBox: objectBox, talker: talker);
});

// Добавляем notifier для управления обновлением
final setListNotifierProvider =
    StateNotifierProvider<SetListNotifier, AsyncValue<List<SetEntity>>>((ref) {
      return SetListNotifier(ref);
    });

class SetListNotifier extends StateNotifier<AsyncValue<List<SetEntity>>> {
  final Ref ref;

  SetListNotifier(this.ref) : super(const AsyncValue.loading()) {
    loadSets();
  }

  // загрузка наборов
  Future<void> loadSets() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(setRepositoryProvider);
      final talker = ref.read(talkerProvider);

      final sets = await repository.getAllSets();

      state = AsyncValue.data(sets);
      talker.info('[Провайдер] загружено ${sets.length} наборов');
    } catch (e, stackTrace) {
      final talker = ref.read(talkerProvider);
      talker.error('[Провайдер] Ошибка загрузки наборов: $e');
      state = AsyncValue.error(e, stackTrace);
    }
  }

  // Обновление (после создания/удаления)
  Future<void> refresh() async {
    await loadSets();
  }

  Future<bool> deleteSet(int id) async {
    try {
      final repository = ref.read(setRepositoryProvider);
      final talker = ref.read(talkerProvider);

      final result = await repository.deleteSet(id);
      if (result) {
        talker.info('[Провайдер] набор $id удален');
        await refresh();
        return true;
      }
      return false;
    } catch (e, st) {
      ref.read(talkerProvider).handle(e, st, '[Провайдер] Ошибка удаления: $e');
      return false;
    }
  }
}
