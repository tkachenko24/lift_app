import 'package:notified_elevator/dashboard/export.dart';

abstract class HousesRepository {
  Future<List<House>> add(House house);
  Future<List<House>> fetch();
}
