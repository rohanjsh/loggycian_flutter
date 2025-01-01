import 'package:flutter/material.dart';
import 'package:loggycian_flutter/src/core/core.dart';
import 'package:loggycian_flutter/src/core/widgets/base_button.dart';

enum ActionButtonType { text, icon }

class ActionButton extends StatelessWidget {
  const ActionButton.text({
    required this.label,
    required this.onPressed,
    super.key,
  })  : icon = null,
        type = ActionButtonType.text;

  const ActionButton.icon({
    required this.icon,
    required this.onPressed,
    super.key,
  })  : label = null,
        type = ActionButtonType.icon;

  final String? label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final ActionButtonType type;

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      onPressed: onPressed,
      child: type == ActionButtonType.text
          ? Text(
              label!,
              style: AppTextStyleConstants.body,
            )
          : Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                icon,
                color: AppColors.white,
                size: 16,
              ),
            ),
    );
  }
}
