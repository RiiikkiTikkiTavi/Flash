import 'package:flash/data/models/card_model.dart';
import 'package:flash/data/models/progress_model.dart';
import 'package:flash/data/models/set_model.dart';
import 'package:flash/objectbox.g.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

// Точка входа для использования ObjectBox.
// Это прямой интерфейс к базе данных,
// который управляет объектами Box

class ObjectBox {
  // главный объект ObjectBox для получения доступа к боксам
  late final Store store;

  // коробки для хранения данных
  late final Box<CardModel> cardBox;
  late final Box<ProgressModel> progressBox;
  late final Box<SetModel> setBox;

  // запрещаем создание объекта извне с помощью приватного конструктора
  ObjectBox._();

  // создание экземпляра ObjectBox
  static Future<ObjectBox> init() async {
    // создание пустого объекта через приватный конструктор
    final obj = ObjectBox._();

    // получение пути к папке
    final dir = await getApplicationDocumentsDirectory();
    final dbDir = path.join(dir.path, 'flashcards');

    // открытие БД в папке dbDir
    obj.store = await openStore(directory: dbDir);

    // получение боксов для хранения моделей
    obj.cardBox = obj.store.box<CardModel>();
    obj.progressBox = obj.store.box<ProgressModel>();
    obj.setBox = obj.store.box<SetModel>();

    return obj;
  }

  void close() => store.close();
}
