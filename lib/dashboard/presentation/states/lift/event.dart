part of 'bloc.dart';

abstract class LiftEvent extends Equatable {
  const LiftEvent();

  @override
  List<Object?> get props => [];
}

class Move extends LiftEvent {
  final int index;
  final int floor;
  const Move(this.index, this.floor);

  @override
  List<Object?> get props => [
        index,
        floor,
      ];
}

class Update extends LiftEvent {
  final int index;
  const Update(this.index);

  @override
  List<Object?> get props => [index];
}
