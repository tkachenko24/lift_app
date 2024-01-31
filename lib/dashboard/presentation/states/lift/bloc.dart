import 'package:notified_elevator/common/export.dart';
import 'package:notified_elevator/dashboard/export.dart';

part 'event.dart';
part 'state.dart';

class LiftBloc extends Bloc<LiftEvent, LiftState> {
  final LiftRepository repository;
  LiftBloc({required this.repository}) : super(LiftState.empty()) {
    on<Move>(_onMove);
    on<Update>(_onUpdate);
  }

  void _onMove(
    Move event,
    Emitter<LiftState> emit,
  ) async {
    emit(state.copyWith(
      house: House(
        id: state.house.id,
        name: state.house.name,
        floors: state.house.floors,
        currentFloor: state.house.currentFloor,
        targetFloor: event.floor,
      ),
    ));

    await for (final house in repository.move(event.index, event.floor)) {
      emit(state.copyWith(house: house));
    }
  }

  void _onUpdate(
    Update event,
    Emitter<LiftState> emit,
  ) async {
    emit(
      state.copyWith(status: Status.loading()),
    );
    try {
      House house = await repository.fetch(event.index);
      emit(
        state.copyWith(
          status: Status.success(unit),
          house: house,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: Status.failed(unit),
        ),
      );
    }
  }
}
