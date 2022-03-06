import 'package:hive_tests/hivedatabase/hive_controller.dart';
import 'package:hive_tests/hivedatabase/hive_exception.dart';
import 'package:hive_tests/test02/task_model.dart';

void execute() async {
  var hiveController = HiveController();
  try {
    await hiveController.initInDart(folder: 'hiveDatabaseboxes');
    await hiveController.deleteAll('todo');
    await hiveController.addBox('todo');
    var date = DateTime.now();
    await hiveController.create(
      boxName: 'todo',
      data: {
        'date': date,
        // 'date': date.toIso8601String(),
        'description': 'teste',
        'finished': true
      },
    );
    List<Map<String, dynamic>> collections =
        await hiveController.readAll('todo');
    for (var item in collections) {
      print(item);
    }
    print('=============');
    final resultTasksModel =
        collections.map((e) => TaskModel.fromMap(e)).toList();
    for (var item in resultTasksModel) {
      print(item);
    }
    // Map<String, dynamic> collection = await hiveController.read(
    //   boxName: 'todo',
    //   id: '069bf11d-f36f-4adb-8178-d98bf16ec79f',
    // );
    // print('$collection');
  } on HiveException catch (e) {
    print(e.message);
  } catch (e) {
    print(e);
  }
}
