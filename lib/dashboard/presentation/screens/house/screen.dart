import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notified_elevator/common/presentation/theme/export.dart';
import 'package:notified_elevator/dashboard/export.dart';

import 'widgets/export.dart';

class HouseScreen extends StatelessWidget {
  final void Function(int houseId) toLift;
  const HouseScreen({
    Key? key,
    required this.toLift,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundPrimary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 66),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(
                flex: 1,
              ),
              OurButton(
                color: Palette.primaryContainer,
                width: double.infinity,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    SvgPicture.asset(
                      'assets/icons/plus.svg',
                      width: 22,
                      height: 22,
                      colorFilter: const ColorFilter.mode(
                          Colors.transparent, BlendMode.clear),
                    ),
                    const Spacer(),
                    Text(
                      'Add house',
                      style: Fonts.titleMedium.copyWith(
                        color: Palette.onBackgroundPrimary,
                        fontWeight: TypographyWeight.regular,
                      ),
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      'assets/icons/plus.svg',
                      width: 22,
                      height: 22,
                    ),
                    const Spacer(),
                  ],
                ),
                press: () =>
                    showAddingHouseDialog(context, context.read<HouseBloc>()),
              ),
              Flexible(
                flex: 6,
                child: BlocBuilder<HouseBloc, HouseState>(
                    buildWhen: (previous, current) =>
                        previous.houses.length != current.houses.length,
                    builder: (BuildContext context, HouseState state) {
                      context.read<HouseBloc>().add(const Fetch());
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
                              itemCount: state.houses.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: OurButton(
                                      width: 228,
                                      height: 70,
                                      press: () {
                                        toLift(state.houses[index].id);
                                      },
                                      color: Palette.backgroundPrimary,
                                      child: Row(
                                        children: [
                                          Text(
                                            'House',
                                            style: Fonts.titleMedium.copyWith(
                                              color:
                                                  Palette.onBackgroundPrimary,
                                              fontWeight:
                                                  TypographyWeight.regular,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            state.houses[index].name,
                                            style: Fonts.titleMedium.copyWith(
                                              color:
                                                  Palette.onBackgroundPrimary,
                                              fontWeight:
                                                  TypographyWeight.regular,
                                            ),
                                          ),
                                          const Spacer(),
                                        ],
                                      )),
                                );
                              });
                    }),
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
