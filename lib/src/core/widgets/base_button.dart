import 'package:flutter/material.dart';
import 'package:loggycian_flutter/src/core/core.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    required this.onPressed,
    required this.child,
    this.style,
    super.key,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextButtonTheme(
      data: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith<Color?>(
            (states) => states.contains(WidgetState.disabled) ||
                    states.contains(WidgetState.pressed)
                ? AppColors.white.withValues(alpha: .24)
                : AppColors.white,
          ),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ).merge(style),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: Size.zero,
        ),
        child: child,
      ),
    );
  }
}
