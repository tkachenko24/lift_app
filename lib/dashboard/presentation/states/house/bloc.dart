import 'package:notified_elevator/common/export.dart';
import 'package:notified_elevator/dashboard/export.dart';

part 'event.dart';
part 'state.dart';

class HouseBloc extends Bloc<HouseEvent, HouseState> {
  final HousesRepository repository;
  HouseBloc({required this.repository}) : super(HouseState.empty()) {
    on<Fetch>(_onFetch);
    on<Add>(_onAdd);
    on<NameChanged>(_onNameChanged);
    on<FloorsChanged>(_onFloorsChanged);
  }

  void _onFloorsChanged(
    FloorsChanged event,
    Emitter<HouseState> emit,
  ) async {
    emit(
      state.copyWith(
        floors: event.value,
      ),
    );
  }

  void _onNameChanged(
    NameChanged event,
    Emitter<HouseState> emit,
  ) async {
    emit(
      state.copyWith(
        name: event.value,
      ),
    );
  }

  void _onFetch(
    Fetch event,
    Emitter<HouseState> emit,
  ) async {
    emit(
      state.copyWith(
        status: Status.loading(),
      ),
    );
    try {
      List<House> houses = await repository.fetch();
      emit(
        state.copyWith(
          status: Status.success(unit),
          houses: houses,
        ),
      );
    } catch (err) {
      emit(
        state.copyWith(
          status: Status.failed(unit),
        ),
      );
    }
  }

  void _onAdd(
    Add event,
    Emitter<HouseState> emit,
  ) async {
    emit(
      state.copyWith(
        status: Status.loading(),
      ),
    );
    try {
      List<House> houses = await repository.add(House(
        id: state.houses.isEmpty ? 1 : state.houses.last.id + 1,
        name: state.name,
        floors: state.floors,
        currentFloor: 1,
        targetFloor: 0,
      ));

      emit(
        state.copyWith(
          status: Status.success(unit),
          name: '',
          floors: 0,
          houses: houses,
        ),
      );
    } catch (err) {
      emit(
        state.copyWith(
          status: Status.failed(unit),
        ),
      );
    }
  }
}
