import 'package:flutter/material.dart';
import 'package:notified_elevator/common/presentation/theme/export.dart';

class OurButton extends StatelessWidget {
  const OurButton({
    super.key,
    required this.press,
    this.height,
    this.width,
    required this.color,
    required this.child,
  });

  final void Function() press;
  final double? height, width;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          splashFactory: NoSplash.splashFactory,
          fixedSize:
              MaterialStateProperty.all(Size(width ?? 228, height ?? 40)),
          side: MaterialStateProperty.all(
            const BorderSide(color: Palette.onBackgroundPrimary),
          ),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
          backgroundColor: MaterialStateProperty.all(color)),
      child: child,
      onPressed: () => press.call(),
    );
  }
}
