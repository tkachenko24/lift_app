import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notified_elevator/common/presentation/theme/export.dart';
import 'package:notified_elevator/dashboard/presentation/export.dart';

class LiftScreen extends StatelessWidget {
  final int houseId;

  const LiftScreen({
    required this.houseId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LiftBloc>().add(Update(houseId));
    return Scaffold(
        backgroundColor: Palette.backgroundPrimary,
        body: Center(
          child: Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 26,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Floors',
                        style: Fonts.titleMedium.copyWith(
                          color: Palette.onBackgroundPrimary,
                          fontWeight: TypographyWeight.regular,
                        ),
                      )),
                  const Divider(
                    color: Palette.onBackgroundPrimary,
                    thickness: 1,
                  ),
                  Flexible(
                    flex: 10,
                    child: BlocBuilder<LiftBloc, LiftState>(
                        buildWhen: (previous, current) => previous != current,
                        builder: (BuildContext context, LiftState state) {
                          List<int> floors = List.generate(
                              state.house.floors, (index) => index + 1);

                          return state.status.isLoading()
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20.0),
                                  child: CupertinoActivityIndicator(
                                    radius: 30,
                                  ),
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: false,
                                  prototypeItem: OurButton(
                                    height: 70,
                                    press: () {},
                                    color: Palette.backgroundPrimary,
                                    child: null,
                                  ),
                                  itemCount: state.house.floors,
                                  itemBuilder:
                                      (BuildContext context, int floor) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: OurButton(
                                          width: 228,
                                          height: 70,
                                          press: () {
                                            context.read<LiftBloc>().add(
                                                  Move(houseId, floor + 1),
                                                );
                                          },
                                          color:
                                              liftIndicatorColor(state, floor),
                                          child: Text(
                                            'Floor ${floors[floor].toString()}',
                                            textAlign: TextAlign.center,
                                            style: Fonts.titleMedium.copyWith(
                                              color:
                                                  Palette.onBackgroundPrimary,
                                              fontWeight:
                                                  TypographyWeight.regular,
                                            ),
                                          )),
                                    );
                                  });
                        }),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'desinged by ...',
                      style: Fonts.titleMedium.copyWith(
                        color: Palette.onBackgroundPrimary,
                        fontWeight: TypographyWeight.regular,
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                ],
              )),
        ));
  }
}

Color liftIndicatorColor(LiftState state, int floor) {
  return state.house.targetFloor == 0
      ? Palette.backgroundPrimary
      : state.house.targetFloor == floor + 1
          ? Palette.secondary
          : state.house.currentFloor == floor + 1
              ? Palette.primary
              : Palette.backgroundPrimary;
}
