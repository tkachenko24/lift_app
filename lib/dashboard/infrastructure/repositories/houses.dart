import 'package:notified_elevator/dashboard/export.dart';

class HousesRepositoryImplementation implements HousesRepository {
  final HousesDataBase dataBase;
  final HouseModelToHouseEntityMapper mapper;
  HousesRepositoryImplementation({
    required this.dataBase,
    required this.mapper,
  });
  @override
  Future<List<House>> add(House house) async {
    return dataBase
        .add(
          house: HouseModel(
            id: house.id,
            name: house.name,
            floors: house.floors,
            currentFloor: house.currentFloor,
            targetFloor: house.targetFloor,
          ),
        )
        .then(
          (listModels) =>
              listModels.map((model) => mapper.restore(model)).toList(),
        );
  }

  @override
  Future<List<House>> fetch() async {
    return dataBase.fetchList().then(
          (listModels) =>
              listModels.map((model) => mapper.restore(model)).toList(),
        );
  }
}
