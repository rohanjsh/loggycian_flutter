import 'package:flutter/material.dart';
import 'package:loggycian_flutter/src/core/core.dart';

class UrlSection extends StatelessWidget {
  const UrlSection({
    required this.uri,
    required this.requestTime,
    super.key,
    this.responseTime,
  });

  final String uri;
  final DateTime? responseTime;
  final DateTime requestTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xff2D2D2D),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            uri,
            style: AppTextStyleConstants.body.copyWith(
              color: Colors.white,
            ),
          ),
          if (responseTime != null) ...[
            const SizedBox(height: 8),
            Text(
              responseTime!.difference(requestTime).durationInSec(),
              style: AppTextStyleConstants.body.copyWith(
                color: AppColors.textGreyLight,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
