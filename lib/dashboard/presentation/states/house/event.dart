part of 'bloc.dart';

abstract class HouseEvent extends Equatable {
  const HouseEvent();

  @override
  List<Object?> get props => [];
}

class NameChanged extends HouseEvent {
  final String value;
  const NameChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class FloorsChanged extends HouseEvent {
  final int? value;
  const FloorsChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class Fetch extends HouseEvent {
  const Fetch();

  @override
  List<Object?> get props => [];
}

class Add extends HouseEvent {
  const Add();

  @override
  List<Object?> get props => [];
}
