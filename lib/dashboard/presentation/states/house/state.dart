part of 'bloc.dart';

class HouseState extends Equatable {
  final Status<Unit, Unit> status;
  final List<House> houses;
  final String name;
  final int floors;

  const HouseState({
    required this.status,
    required this.houses,
    required this.name,
    required this.floors,
  });

  factory HouseState.empty() {
    return HouseState(
      status: Status.empty(),
      houses: const [],
      name: '',
      floors: 0,
    );
  }

  HouseState copyWith({
    Status<Unit, Unit>? status,
    List<House>? houses,
    String? name,
    int? floors,
  }) {
    return HouseState(
      status: status ?? this.status,
      houses: houses ?? this.houses,
      name: name ?? this.name,
      floors: floors ?? this.floors,
    );
  }

  @override
  List<Object?> get props => [
        status,
        houses,
        name,
        floors,
      ];
}
