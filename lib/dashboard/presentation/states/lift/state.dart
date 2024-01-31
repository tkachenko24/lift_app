part of 'bloc.dart';

class LiftState extends Equatable {
  final Status<Unit, Unit> status;
  final House house;

  const LiftState({
    required this.status,
    required this.house,
  });

  factory LiftState.empty() {
    return LiftState(
      status: Status.empty(),
      house: House.empty(),
    );
  }

  LiftState copyWith({
    Status<Unit, Unit>? status,
    House? house,
  }) {
    return LiftState(
      status: status ?? this.status,
      house: house ?? this.house,
    );
  }

  @override
  List<Object?> get props => [
        status,
        house,
      ];
}
