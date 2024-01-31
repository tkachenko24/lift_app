import 'package:flutter/material.dart';
import 'package:notified_elevator/common/presentation/theme/export.dart';
import 'package:notified_elevator/dashboard/presentation/export.dart';

class DashboardScreen extends StatelessWidget {
  final void Function() toHouse;
  const DashboardScreen({
    Key? key,
    required this.toHouse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundPrimary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(
              flex: 7,
            ),
            Text(
              'Test Task',
              style: Fonts.headlineSmall.copyWith(
                fontWeight: TypographyWeight.regular,
                height: 1,
                color: Palette.onBackgroundPrimary,
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  color: Palette.backgroundSecondary,
                  border: Border.all(color: Palette.errorContainer)),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.only(
                    top: 77, bottom: 94, left: 11, right: 12),
                child: Text(
                  'any image here',
                  style: Fonts.headlineSmall.copyWith(
                    fontWeight: FontWeight.w400,
                    height: 1,
                    color: Palette.onBackgroundPrimary,
                  ),
                ),
              )),
            ),
            const Spacer(
              flex: 1,
            ),
            OurButton(
              press: toHouse,
              height: 57,
              color: Palette.backgroundPrimary,
              child: Text(
                'Enter',
                style: Fonts.titleMedium.copyWith(
                  color: Palette.onBackgroundPrimary,
                  fontWeight: TypographyWeight.regular,
                ),
              ),
            ),
            const Spacer(
              flex: 6,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 49),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'desinged by ...',
                  style: Fonts.titleMedium.copyWith(
                    color: Palette.onBackgroundPrimary,
                    fontWeight: TypographyWeight.regular,
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}
