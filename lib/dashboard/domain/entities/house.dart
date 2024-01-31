import 'package:notified_elevator/common/export.dart';

class House extends Entity {
  final int id;
  final String name;
  final int floors;
  final int currentFloor;
  final int targetFloor;

  const House({
    required this.id,
    required this.name,
    required this.floors,
    required this.currentFloor,
    required this.targetFloor,
  });

  House copyWith({
    int? id,
    String? name,
    int? floors,
    int? currentFloor,
    int? targetFloor,
  }) {
    return House(
      id: id ?? this.id,
      name: name ?? this.name,
      floors: floors ?? this.floors,
      currentFloor: currentFloor ?? this.currentFloor,
      targetFloor: targetFloor ?? this.targetFloor,
    );
  }

  factory House.empty() {
    return const House(
      id: 0,
      name: '',
      floors: 0,
      currentFloor: 0,
      targetFloor: 0,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        floors,
        currentFloor,
        targetFloor,
      ];
}
