import 'dart:io';
import 'package:hive/hive.dart';
import 'package:hive_tests/test01/hive_exception.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

class HiveController {
  final String _nameListOfBoxes = 'hiveboxes';
  final String _folder;
  String get folderAllBoxes => _folder;
  String get boxAndKeyWithListAllBoxes => _nameListOfBoxes;

  var _boxes = <String>{};
  Box? _box;

  /// The box with the name of all the boxes is 'hiveboxes'
  /// Please dont create any box with this name
  ///
  /// First method start is initInDart()
  HiveController({required String folder}) : _folder = folder;

  Future<void> initInDart() async {
    var pathFinal = '';
    try {
      var appPath = Directory.current.path;
      pathFinal = p.join(appPath, _folder);
    } catch (e) {
      throw HiveICantOpenDirectoryException();
    }
    try {
      Hive.init(pathFinal);
    } catch (e) {
      throw HiveICantInitException();
    }
    await _getNameOfBoxes();
  }

  initInFlutter() {
    print('coming soon...');
    exit(0);
  }

  Future<void> _getNameOfBoxes() async {
    var boxOpen = await Hive.openBox(_nameListOfBoxes);
    if (!boxOpen.isOpen) {
      throw HiveICantOpenTheBoxException(message: 'In _getNameOfBoxes.');
    }
    dynamic boxes;
    try {
      boxes = boxOpen.get(_nameListOfBoxes) ?? {};
    } catch (e) {
      throw HiveICantGetValueException(message: 'In _getNameOfBoxes.');
    }
    _updateNameOfBoxes(boxes);
  }

  _updateNameOfBoxes(dynamic boxes) {
    if (boxes.isNotEmpty) {
      _boxes.clear();
      _boxes.addAll(boxes);
    }
  }

  Future<void> closeAll() async {
    try {
      await Hive.close();
    } catch (e) {
      throw HiveICantCloseBoxesException();
    }
  }

  Future<void> close() async {
    try {
      await _box!.close();
    } catch (e) {
      throw HiveICantCloseBoxException();
    }
  }

  Future<void> addBox(String name) async {
    if (_boxes.add(name)) {
      await _saveBox();
    }
  }

  Future<void> _saveBox() async {
    try {
      _box = Hive.box(_nameListOfBoxes);
    } catch (e) {
      throw HiveICantGetTheBoxException();
    }
    try {
      await _box!.put(_nameListOfBoxes, _boxes.toList());
    } catch (e) {
      throw HiveICantPutValueException();
    }
  }

  Future<void> _openBox(String name) async {
    try {
      await Hive.openBox(name);
    } catch (e) {
      throw HiveICantOpenTheBoxException();
    }
  }

  Future<void> _getBox(String name) async {
    if (_boxes.contains(name)) {
      if (!Hive.isBoxOpen(name)) {
        await _openBox(name);
      }
      _box = Hive.box(name);
    } else {
      throw HiveUnregisteredBoxException();
    }
  }

  Future<String> create({
    required String boxName,
    required Map<String, dynamic> data,
    String? fieldId,
  }) async {
    await _getBox(boxName);
    String fieldUuid = fieldId ?? 'uuid';

    if (!data.containsKey(fieldUuid)) {
      data.addAll({fieldUuid: Uuid().v4()});
    }
    try {
      await _box!.put(data[fieldUuid], data);
    } catch (e) {
      throw HiveICantPutValueException(message: 'In create.');
    }
    return data[fieldUuid];
  }

  Future<void> createAll({
    required String boxName,
    required List<Map<String, dynamic>> data,
    String? fieldId,
  }) async {
    await _getBox(boxName);
    String fieldUuid = fieldId ?? 'uuid';
    for (var item in data) {
      if (!item.containsKey(fieldUuid)) {
        item.addAll({fieldUuid: Uuid().v4()});
      }
      try {
        await _box!.put(item[fieldUuid], item);
      } catch (e) {
        throw HiveICantPutValueException(message: 'In createAll.');
      }
    }
  }

  Future<Map<String, dynamic>> read(
      {required String boxName, required String id}) async {
    await _getBox(boxName);
    var map = <String, dynamic>{};
    dynamic doc;
    if (_box!.isNotEmpty) {
      try {
        doc = _box!.get(id);
      } catch (e) {
        throw HiveICantGetValueException(message: 'In get.');
      }
      if (doc != null) {
        try {
          map = doc.cast<String, dynamic>();
        } catch (e) {
          throw HiveICantCastDataException(message: 'In get.');
        }
      }
    }
    return map;
  }

  Future<List<Map<String, dynamic>>> readAll(
    String boxName,
  ) async {
    await _getBox(boxName);
    var docs = <Map<String, dynamic>>{};
    dynamic doc;
    if (_box!.isNotEmpty) {
      for (var boxKey in _box!.keys) {
        try {
          doc = _box!.get(boxKey);
        } catch (e) {
          throw HiveICantGetValueException(message: 'In readAll.');
        }
        if (doc != null) {
          var map = <String, dynamic>{};
          try {
            map = doc.cast<String, dynamic>();
          } catch (e) {
            throw HiveICantCastDataException(message: 'In readAll.');
          }
          docs.add(map);
        }
      }
    }
    return docs.toList();
  }

  Future<bool> update({
    required String boxName,
    required Map<String, dynamic> data,
    String? fieldId,
  }) async {
    await _getBox(boxName);
    String fieldUuid = fieldId ?? 'uuid';

    if (!data.containsKey(fieldUuid)) {
      return Future.value(false);
    }
    try {
      await _box!.put(data[fieldUuid], data);
    } catch (e) {
      throw HiveICantPutValueException(message: 'In update.');
    }
    return Future.value(true);
  }

  Future<void> delete({required String boxName, required String id}) async {
    try {
      _box!.delete(id);
    } catch (e) {
      throw HiveICantDeleteValueException(message: 'In delete.');
    }
  }

  Future<void> deleteAll(String boxName) async {
    try {
      Hive.deleteBoxFromDisk(boxName);
    } catch (e) {
      throw HiveICantDeleteBoxException(message: 'In deleteAll.');
    }
  }

  Future<List<String>> listOfBoxes() async {
    Box box;
    try {
      box = await Hive.openBox(_nameListOfBoxes);
    } catch (e) {
      throw HiveICantOpenTheBoxException();
    }
    var list = <String>[];
    dynamic doc;
    if (box.isNotEmpty) {
      try {
        doc = box.get(_nameListOfBoxes);
      } catch (e) {
        throw HiveICantGetValueException(message: 'In listOfBoxes.');
      }
      if (doc != null) {
        try {
          list = doc.cast<String>();
        } catch (e) {
          throw HiveICantCastDataException(message: 'In listOfBoxes.');
        }
      }
    }
    return list;
  }
}
