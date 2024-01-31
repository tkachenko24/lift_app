import 'package:notified_elevator/dashboard/export.dart';

abstract class HousesDataBase {
  Future<List<HouseModel>> fetchList();
  Future<List<HouseModel>> add({required HouseModel house});
  Stream<HouseModel> move({
    required int id,
    required int targetFloor,
  });
  Future<HouseModel> fetchHouse({required int id});
}
