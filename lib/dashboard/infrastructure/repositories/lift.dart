import 'package:notified_elevator/dashboard/export.dart';

class LiftRepositoryImplementation implements LiftRepository {
  final HousesDataBase dataBase;
  final HouseModelToHouseEntityMapper mapper;
  final NotificationSource notification;
  LiftRepositoryImplementation({
    required this.dataBase,
    required this.mapper,
    required this.notification,
  });
  @override
  Future<House> fetch(int id) async {
    return dataBase.fetchHouse(id: id).then((model) => mapper.restore(model));
  }

  @override
  Stream<House> move(int id, targetFloor) async* {
    yield* dataBase.move(id: id, targetFloor: targetFloor).asyncMap((model) {
      notification.send(
        title: model.name,
        description: model.currentFloor.toString(),
      );
      return mapper.restore(model);
    });
  }
}
