import 'package:notified_elevator/dashboard/export.dart';

class HouseModelToHouseEntityMapper {
  HouseModel convert(House input) {
    return HouseModel(
      id: input.id,
      name: input.name,
      floors: input.floors,
      currentFloor: input.currentFloor,
      targetFloor: input.targetFloor,
    );
  }

  House restore(HouseModel output) {
    return House(
      id: output.id,
      name: output.name,
      floors: output.floors,
      currentFloor: output.currentFloor,
      targetFloor: output.targetFloor,
    );
  }

  Map<String, dynamic> toMap(HouseModel model) {
    return {
      'id': model.id,
      'name': model.name,
      'floors': model.floors,
      'currentFloor': model.currentFloor,
      'targetFloor': model.targetFloor,
    };
  }

  HouseModel fromMap(Map<String, dynamic> map) {
    return HouseModel(
      id: map['id'] as int,
      name: map['name'] as String,
      floors: map['floors'] as int,
      currentFloor: map['currentFloor'] as int,
      targetFloor: map['targetFloor'] as int,
    );
  }
}
