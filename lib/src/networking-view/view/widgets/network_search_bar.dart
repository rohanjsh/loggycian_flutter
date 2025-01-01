import 'package:flutter/material.dart';
import 'package:loggycian_flutter/src/core/core.dart';
import 'package:loggycian_flutter/src/networking-view/view/widgets/action_button.dart';

class NetworkSearchBar extends StatelessWidget {
  const NetworkSearchBar({
    required this.controller,
    required this.onClear,
    required this.onChanged,
    super.key,
  });
  final TextEditingController controller;
  final VoidCallback onClear;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 48,
      child: TextFormField(
        style: AppTextStyleConstants.body.copyWith(color: Colors.white),
        controller: controller,
        onChanged: onChanged,
        cursorColor: Colors.white,
        decoration: _getInputDecoration(),
      ),
    );
  }

  InputDecoration _getInputDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      hintText: AppStrings.searchHint,
      hintStyle: AppTextStyleConstants.body.copyWith(
        color: Colors.white.withValues(alpha: .8),
      ),
      border: _border,
      focusedBorder: _border,
      enabledBorder: _border,
      fillColor: const Color(0xff252525),
      filled: true,
      prefixIcon: const Icon(
        Icons.search,
        color: Colors.white,
        size: 18,
      ),
      suffixIcon: controller.text.isNotEmpty
          ? ActionButton.icon(
              icon: Icons.cancel_rounded,
              onPressed: onClear,
            )
          : null,
    );
  }

  OutlineInputBorder get _border => const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      );
}
