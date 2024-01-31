import 'package:notified_elevator/dashboard/export.dart';

abstract class LiftRepository {
  Future<House> fetch(int id);
  Stream<House> move(int id, targetFloor);
}
