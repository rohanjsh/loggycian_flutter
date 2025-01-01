import 'package:flutter/material.dart';
import 'package:loggycian_flutter/src/core/core.dart';
import 'package:loggycian_flutter/src/networking-view/view/widgets/action_button.dart';

class HeadersAndBodySection extends StatelessWidget {
  const HeadersAndBodySection({
    required this.type,
    required this.onCopy,
    super.key,
    this.headers,
    this.body,
  });

  final String type;
  final Map<String, String>? headers;
  final dynamic body;
  final Future<void> Function() onCopy;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                type,
                style: AppTextStyleConstants.bodyBold.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Material(
                color: Colors.transparent,
                child: ActionButton.icon(
                  icon: Icons.copy,
                  onPressed: onCopy,
                ),
              ),
            ],
          ),
          if (headers?.isNotEmpty ?? false) ...[
            const SizedBox(height: 16),
            Text(
              AppStrings.headers,
              style: AppTextStyleConstants.bodySemiBold.copyWith(
                color: AppColors.textGrey,
              ),
            ),
            const SizedBox(height: 8),
            ...headers!.entries.map<Widget>(
              (header) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: SelectableText.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${header.key}: ',
                        style: AppTextStyleConstants.bodySemiBold.copyWith(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      TextSpan(
                        text: header.value,
                        style: AppTextStyleConstants.body.copyWith(
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          if (body != null) ...[
            const SizedBox(height: 16),
            Text(
              AppStrings.body,
              style: AppTextStyleConstants.bodySemiBold.copyWith(
                color: AppColors.textGrey,
              ),
            ),
            const SizedBox(height: 8),
            SelectableText(
              body.toString(),
              style: AppTextStyleConstants.body.copyWith(
                color: Colors.grey.shade300,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
