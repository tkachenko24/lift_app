import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notified_elevator/common/presentation/theme/export.dart';
import 'package:notified_elevator/dashboard/presentation/export.dart';

Future<void> showAddingHouseDialog(
  BuildContext context,
  HouseBloc bloc,
) {
  return showGeneralDialog<void>(
    context: context,
    barrierColor: Colors.transparent,
    pageBuilder: (
      BuildContext context,
      Animation<double> animationOne,
      Animation<double> animationTwo,
    ) {
      return SimpleDialog(
        backgroundColor: Palette.backgroundSecondary,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        insetPadding: const EdgeInsets.only(
          left: 19,
          right: 20,
        ),
        contentPadding: EdgeInsets.zero,
        shape: const ContinuousRectangleBorder(
            side: BorderSide(color: Palette.onBackgroundPrimary)),
        shadowColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/plus.svg',
              width: 22,
              height: 22,
              colorFilter:
                  const ColorFilter.mode(Colors.transparent, BlendMode.clear),
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
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () => Navigator.of(context).pop(),
              icon: Transform.rotate(
                angle: -math.pi / 4,
                child: SvgPicture.asset(
                  'assets/icons/plus.svg',
                  width: 22,
                  height: 22,
                ),
              ),
            ),
          ],
        ),
        children: <Widget>[
          const SizedBox(
            height: 36,
          ),
          SizedBox(
            width: 600,
            child: Padding(
              padding: const EdgeInsets.only(left: 32, right: 34),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 74),
                    child: Text(
                      'Name',
                      style: Fonts.bodyLarge.copyWith(
                        fontWeight: TypographyWeight.regular,
                        color: Palette.onBackgroundPrimary,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: ConstrainedBox(
                        constraints: BoxConstraints.loose(const Size(200, 17)),
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                              color: Palette.secondaryContainer),
                          child: TextFormField(
                            onChanged: (value) => bloc.add(NameChanged(value)),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20),
                            ],
                            cursorColor: Palette.onBackgroundPrimary,
                            cursorHeight: 10,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(
                                      color: Palette.secondaryContainer)),
                              disabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(
                                      color: Palette.secondaryContainer)),
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(
                                      color: Palette.onBackgroundPrimary)),
                              constraints:
                                  BoxConstraints.tight(const Size(200, 20)),
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(
                                      color: Palette.secondaryContainer),
                                  gapPadding: 0),
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 19,
          ),
          SizedBox(
            width: 600,
            child: Padding(
              padding: const EdgeInsets.only(left: 32, right: 34),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      'Floors count',
                      style: Fonts.bodyLarge.copyWith(
                        fontWeight: TypographyWeight.regular,
                        color: Palette.onBackgroundPrimary,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  ConstrainedBox(
                      constraints: BoxConstraints.loose(const Size(37, 17)),
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                            color: Palette.secondaryContainer),
                        child: TextFormField(
                          onChanged: (value) =>
                              bloc.add(FloorsChanged(int.tryParse(value))),
                          cursorColor: Palette.onBackgroundPrimary,
                          cursorHeight: 10,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.allow(RegExp("[1-9]")),
                          ],
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 4),
                            errorBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide:
                                    BorderSide(color: Palette.errorContainer)),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide: BorderSide(
                                    color: Palette.secondaryContainer)),
                            disabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide: BorderSide(
                                    color: Palette.secondaryContainer)),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide: BorderSide(
                                    color: Palette.onBackgroundPrimary)),
                            constraints:
                                BoxConstraints.tight(const Size(37, 20)),
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide: BorderSide(
                                    color: Palette.secondaryContainer),
                                gapPadding: 0),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 29,
          ),
          Row(
            children: [
              const Spacer(
                flex: 8,
              ),
              ConstrainedBox(
                constraints: BoxConstraints.tight(const Size(98, 24)),
                child: OurButton(
                    press: () =>
                        bloc.state.floors != 0 && bloc.state.name.isNotEmpty
                            ? {
                                bloc.add(const Add()),
                                Navigator.pop(context),
                              }
                            : null,
                    height: 24,
                    width: 27,
                    color: Palette.secondaryContainer,
                    child: Text(
                      'Add',
                      style: Fonts.bodyLarge.copyWith(
                        fontWeight: TypographyWeight.regular,
                        color: Palette.onBackgroundPrimary,
                      ),
                    )),
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );
    },
  );
}
