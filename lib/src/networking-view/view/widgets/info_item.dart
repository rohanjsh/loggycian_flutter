import 'package:flutter/material.dart';
import 'package:loggycian_flutter/src/core/core.dart';

class InfoItem extends StatelessWidget {
  const InfoItem({
    required this.title,
    required this.description,
    super.key,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyleConstants.bodySemiBold.copyWith(
              color: AppColors.textGreyLight,
            ),
          ),
          const SizedBox(height: 4),
          SelectableText(
            description,
            style: AppTextStyleConstants.body.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
