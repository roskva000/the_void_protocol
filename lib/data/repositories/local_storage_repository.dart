import 'package:hive_flutter/hive_flutter.dart';
import '../models/save_data_model.dart';

class LocalStorageRepository {
  static const String _boxName = 'void_save_box';
  static const String _saveKey = 'main_save';

  late Box<SaveDataModel> _box;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SaveDataModelAdapter());
    _box = await Hive.openBox<SaveDataModel>(_boxName);
  }

  Future<void> save(SaveDataModel data) async {
    await _box.put(_saveKey, data);
  }

  SaveDataModel? load() {
    return _box.get(_saveKey);
  }

  Future<void> clear() async {
    await _box.clear();
  }
}
