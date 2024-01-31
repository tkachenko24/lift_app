class HouseModel {
  final int id;
  final String name;
  final int floors;
  final int currentFloor;
  final int targetFloor;

  const HouseModel({
    required this.id,
    required this.name,
    required this.floors,
    required this.currentFloor,
    required this.targetFloor,
  });

  factory HouseModel.empty() {
    return const HouseModel(
      id: 0,
      name: '',
      floors: 0,
      currentFloor: 0,
      targetFloor: 0,
    );
  }

  HouseModel copyWith({
    int? id,
    String? name,
    int? floors,
    int? currentFloor,
    int? targetFloor,
  }) {
    return HouseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      floors: floors ?? this.floors,
      currentFloor: currentFloor ?? this.currentFloor,
      targetFloor: targetFloor ?? this.targetFloor,
    );
  }
}
