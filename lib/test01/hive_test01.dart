import 'package:hive_tests/test01/hive_controller.dart';

void execute() async {
  var hiveController = HiveController();
  try {
    await hiveController.initInDart(folder: 'hive_test01_hivedb');
    // await hiveController.deleteAll('teste1');
    // await hiveController.addBox('teste1');
    // await hiveController.create(
    //   boxName: 'teste1',
    //   data: {'time': DateTime.now().toIso8601String()},
    // );
    // await hiveController.createAll(
    //   boxName: 'teste1',
    //   data: [
    //     {
    //       'uuid': '069bf11d-f36f-4adb-8178-d98bf16ec79f',
    //       'time': DateTime.now().toIso8601String()
    //     },
    //     {'time': DateTime.now().toIso8601String()},
    //   ],
    // );

    // await hiveController.update(
    //   boxName: 'teste1',
    //   data: {
    //     'uuid': '069bf11d-f36f-4adb-8178-d98bf16ec79f',
    //     'time': DateTime.now().toIso8601String()
    //   },
    // );
    // Map<String, dynamic> collection = await hiveController.read(
    //   boxName: 'teste1',
    //   id: '069bf11d-f36f-4adb-8178-d98bf16ec79f',
    // );
    // print('$collection');
    // List<Map<String, dynamic>> collections =
    //     await hiveController.readAll('teste1');
    // for (var item in collections) {
    //   print(item);
    // }
    // List<String> boxes = await hiveController.listOfBoxes();
    // for (var item in boxes) {
    //   print(item);
    // }
  } catch (e) {
    print(e);
  }
}
