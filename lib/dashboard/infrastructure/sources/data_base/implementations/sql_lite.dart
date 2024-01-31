import 'package:notified_elevator/dashboard/export.dart';
import 'package:sqflite/sqflite.dart';

class HousesDataBaseSqLiteImplementation implements HousesDataBase {
  final Database database;
  final HouseModelToHouseEntityMapper mapper;
  HousesDataBaseSqLiteImplementation({
    required this.database,
    required this.mapper,
  });

  static const table = 'Houses';

  @override
  Future<List<HouseModel>> fetchList() async {
    // if (await database.query('sqlite_master',
    //     where: 'name = ?',
    //     whereArgs: [table]).then((list) async => list.isEmpty)) {
    //   database.execute(
    //       'CREATE TABLE $table (name TEXT, floors INTEGER, currentFloor INTEGER, targetFloor INTEGER)');
    // }
    return database
        .query(table)
        .then((listMap) => listMap.map((map) => mapper.fromMap(map)).toList());
  }

  @override
  Future<List<HouseModel>> add({required HouseModel house}) async {
    database.insert('Houses', mapper.toMap(house));
    return fetchList();
  }

  // @override
  // Stream<HouseModel> move({required int id, required int targetFloor}) async* {
  //   HouseModel house = await fetchHouse(id: id);
  //   yield* Stream<HouseModel>.periodic(const Duration(seconds: 2), (count) {
  //     // print(targetFloor - house.currentFloor);
  //     // print(count);
  //     HouseModel updatedHouse = house.copyWith(
  //       currentFloor: house.currentFloor + count,
  //       targetFloor: count == targetFloor ? 0 : targetFloor,
  //     );
  //     // HouseModel newModel = HouseModel(
  //     //     id: house.id,
  //     //     name: house.name,
  //     //     floors: house.floors,
  //     //     currentFloor: house.currentFloor + count,
  //     //     targetFloor: targetFloor);
  //     // print(mapper.toMap(house.copyWith(currentFloor: house.currentFloor + count)));
  //     database.update(
  //       table,
  //       mapper.toMap(updatedHouse),
  //       where: 'id = ?',
  //       whereArgs: [updatedHouse.id],
  //     );
  //     fetchHouse(id: id).then((value) => print(mapper.toMap(value)));
  //     return updatedHouse;
  //   }).take(targetFloor - house.currentFloor + 1);
  // }

  @override
  Stream<HouseModel> move({required int id, required int targetFloor}) async* {
    HouseModel house = await fetchHouse(id: id);
    int step = targetFloor - house.currentFloor;

    for (int floor = house.currentFloor;
        step.isNegative ? floor >= targetFloor : floor <= targetFloor;
        step.isNegative ? floor-- : floor++) {
      await Future.delayed(const Duration(minutes: 1));
      HouseModel updatedHouse = house.copyWith(
        currentFloor: floor,
        targetFloor: floor == targetFloor ? 0 : targetFloor,
      );
      database.update(
        table,
        mapper.toMap(updatedHouse),
        where: 'id = ?',
        whereArgs: [updatedHouse.id],
      );

      yield updatedHouse;
    }
  }

  @override
  Future<HouseModel> fetchHouse({required int id}) async {
    return fetchList().then(
      (list) => list.singleWhere((element) => element.id == id),
    );
  }
}
